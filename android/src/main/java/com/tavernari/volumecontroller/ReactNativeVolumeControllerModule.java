package com.tavernari.volumecontroller

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.util.Log;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import android.media.AudioManager;

public class ReactNativeVolumeControllerModule extends ReactContextBaseJavaModule {

    private ReactApplicationContext context;
    private float max_volume = 0.0;

    public ReactNativeVolumeControllerModule(ReactApplicationContext reactContext) {
      super(reactContext);
      this.context = reactContext;
          }


    @Override public String getName() {
      return "ReactNativeVolumeController";
    }

    @Override public void initialize() {
      super.initialize();

      try {
        audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
        max_volume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
      } catch (Exception e) {
        Log.e("ERROR", e.getMessage());
      }
    }


    public void sendEvent(ReactContext reactContext, String eventName, @Nullable WritableMap params) {
      this.context.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
          .emit(eventName, params);
    }//VolumeControllerValueUpdatedEvent

    @ReactMethod public void change(float volume) {
      audioManager.setStreamVolume(AudioManager.STREAM_MUSIC,volume*max_volume, 0);
    }

    @ReactMethod public void update() {
      float volume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
      audioManager.setStreamVolume(AudioManager.STREAM_MUSIC,volume, 0);
      WritableMap params = Arguments.createMap();
      params.putString("volume", volume);
      sendEvent(this.getReactApplicationContextModule(), "streamingOpen", params);
    }
}

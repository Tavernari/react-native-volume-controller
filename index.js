import React, { Component }  from 'react';
import { View, NativeModules, DeviceEventEmitter, Slider, requireNativeComponent } from 'react-native';

const {ReactNativeVolumeController} = NativeModules;


export default class SliderVolumeController extends Component {
    constructor(props) {
        super(props);
        this.state = {volume_value:0.8, button_width:0};
    }

    componentDidMount() {
      DeviceEventEmitter.addListener(
        'VolumeControllerValueUpdatedEvent', (evt) => {
            this.setState({volume_value:evt.volume});
        }
      );

      ReactNativeVolumeController.update();
    }

    render() {

        const soundRouteButton = Platform.OS === 'ios' ? <SoundRouteButton /> : null

      return(<View>
              <Slider {...this.props} value={this.state.volume_value} onValueChange={(value)=>ReactNativeVolumeController.change(value)}/>
              {soundRouteButton}
          </View>
        );
    }
}

var SoundRouteButton = requireNativeComponent('SoundRouteButton', SliderVolumeController);

export {SliderVolumeController, ReactNativeVolumeController}

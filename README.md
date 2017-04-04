# react-native-volume-controller
Volume Controller for iOS and Android.

## First installation step (applied for both iOS & Android)

`$ npm install react-native-volume-controller --save`

#### 2. Automatic installation

`$ react-native link react-native-volume-controller`

#### 3. Manual installation

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-volume-controller` => `ios`
   - add `ReactNativeVolumeController.xcodeproj` to the Libraries folder in your XCode project
3. In XCode, in the project navigator, select your project. Add `libReactNativeVolumeController.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)

### Android

#### Manual installation

1. In Android Studio open `Module Settings` and add a Gradle Project.
2. Look for `react-native-volume-controller` android folder and link with a Gradle.
3. Open MyApplication.java from main app and put the ReactNativeVolumeControllerPackage

```java
 @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          new MainReactPackage(),
          new ReactNativeVolumeControllerPackage()
      );
    }
```

## Usage

### Using component

```javascript

import { SliderVolumeController } from 'react-native-volume-controller';

class PlayerUI extends Component {
  render() {
    return (
        <SliderVolumeController />
    );
  }
}
```

### Style props

Use the props style like a [Slider](https://facebook.github.io/react-native/docs/slider.htmllike

## TODO - Need help :P

- [ ] Android Listener to know when press volume button and after dispatch event to react
- [X] Create interface to change volume with Android
- [ ] Enable Airplay button when is possible

import React, { Component }  from 'react';
import {NativeModules, DeviceEventEmitter, Slider} from 'react-native';

const {ReactNativeVolumeController} = NativeModules;

export default class SliderVolumeController extends Component {
    constructor(props) {
        super(props);
        this.state = {volume_value:0.8};
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
      return(<Slider {...this.props}
        value={this.state.volume_value}
        onValueChange={(value)=>ReactNativeVolumeController.change(value)}
        />);
    }
}

export {SliderVolumeController, ReactNativeVolumeController}

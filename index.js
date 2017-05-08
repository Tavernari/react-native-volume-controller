import React, { Component }  from 'react';
import { View, NativeModules, DeviceEventEmitter, Slider, requireNativeComponent, Image, Platform, Dimensions, Text } from 'react-native';

const ReactNativeVolumeController = NativeModules.ReactNativeVolumeController;

export default class SliderVolumeController extends Component {
    constructor(props) {
        super(props);
        this.state = {volume_value:0.8, has_button_route:false};
    }

  componentDidMount() {
    DeviceEventEmitter.addListener(
        'VolumeControllerValueUpdatedEvent', (evt) => {
            console.log("update view volume "+evt.volume);
            this.setState({volume_value:evt.volume});
        }
      );

      ReactNativeVolumeController.update();
    }

    render() {
        const dimension = Dimensions.get("window")
        const viewWidth = dimension.width-20;
        let sliderWidth = viewWidth;
        let buttonWidth = sliderWidth*0.15
        let soundRouteButton = null;
        if( Platform.OS === 'ios'){
            sliderWidth = viewWidth*0.85
            soundRouteButton = <SoundRouteButton style={{width:buttonWidth, top:3}} />
        }

        return(<View style={[this.props.style, {marginLeft:10, marginRight:10,flex:1, flexDirection:"row", width:viewWidth,
              alignItems:'center',
              justifyContent:'center'}]}>
              <Slider {...this.props} style={[{width:sliderWidth}]} value={this.state.volume_value} onValueChange={(value)=>ReactNativeVolumeController.change(value)}/>
              {soundRouteButton}

          </View>
        );
    }
}

var SoundRouteButton = requireNativeComponent('ReactNativeVolumeController', null);

export {SliderVolumeController, ReactNativeVolumeController, SoundRouteButton}

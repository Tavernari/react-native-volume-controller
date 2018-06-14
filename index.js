import React, { Component }  from 'react';
import PropTypes from 'prop-types';
import { View, NativeModules, DeviceEventEmitter, Slider, requireNativeComponent, Image, Platform, Dimensions, Text, StyleSheet } from 'react-native';

const ReactNativeVolumeController = NativeModules.ReactNativeVolumeController;

type Event = Object;

export default class SliderVolumeController extends Component {

  static propTypes = {
    /**
     * The color used for the thumb.
     */
    thumbTintColor: PropTypes.string,

    /**
     * The image for the thumb
     */
    thumbImage: Image.propTypes.source,

    /**
     * The size of the thumb area that allows moving the thumb.
     * The default is {width: 23, height: 23}.
     */
    thumbSize: PropTypes.shape({
      width: PropTypes.number,
      height: PropTypes.number
    }),

    /**
     * The color used for the track to the left of the button. Overrides the
     * default blue gradient image.
     */
    minimumTrackTintColor: PropTypes.string,

    /**
     * The color used for the track to the right of the button. Overrides the
     * default blue gradient image.
     */
    maximumTrackTintColor: PropTypes.string,

    /**
     * Specifies whether or not to show the route button for airplay
     */
    showsRouteButton: PropTypes.bool,

    /**
     * Callback continuously called while the user is dragging the slider.
     */
    onValueChange: PropTypes.func
  };

  static defaultProps = {
    thumbSize: { width: 23, height: 23 },
    showsRouteButton: true
  };

    constructor(props) {
      super(props);
      this.state = {volume_value:0.8, has_button_route:false};
      this.isDragging = false;
    }

    render() {
        const dimension = Dimensions.get("window")
        const viewWidth = dimension.width-20;
        let sliderWidth = viewWidth;
        let slider = <Slider {...this.props} value={this.state.volume_value} onValueChange={
          (value)=>{
            this.isDragging = true;
            ReactNativeVolumeController.change(value);
            ReactNativeVolumeController.update();
            setTimeout(()=>{
              this.isDragging = false;
            }, 500);
          }
        }/>
        if( Platform.OS === 'ios' ){
          const onValueChange = this.props.onValueChange && ((event: Event) => {
              this.props.onValueChange &&
              this.props.onValueChange(event.nativeEvent.value);
            });

          const { style, ...rest } = this.props;

            slider = <ReactNativeVolumeControllerSlider {...rest}
                                                        onValueChange={onValueChange}
                                                        style={[styles.slider, style, {width:sliderWidth}]}/>
        }

        return(<View style={[this.props.style, {marginLeft:10, marginRight:10,flex:1, flexDirection:"row", width:viewWidth,
              alignItems:'center',
              justifyContent:'center'}]}>

              {slider}

          </View>
        );
    }
}

const styles = StyleSheet.create({
  slider: {
    height: 23,
  },
});

var ReactNativeVolumeControllerSlider = requireNativeComponent('ReactNativeVolumeController', SliderVolumeController);

export {SliderVolumeController, ReactNativeVolumeController}

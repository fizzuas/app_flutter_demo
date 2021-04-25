

import 'package:flutter/material.dart';


/// This is the main application widget.
class SliderBarPage extends StatelessWidget {
  const SliderBarPage({Key key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  double _currentSliderValue = 0;
  double sliderValue = 100;
  double sliderEndValue = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _default(),
        _sliderTheme(context)
      ],
    );
  }

  Widget _default(){
    return Slider(
      value: _currentSliderValue,
      min: -100,
      max: 100,
      divisions: 200,
      label: _currentSliderValue.round().toString()+"%",
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }
  Widget _sliderTheme(context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 20,
        activeTrackColor: Colors.red,
        inactiveTrackColor: Colors.grey,
        disabledActiveTrackColor: Colors.yellow,
        disabledInactiveTrackColor: Colors.cyan,
        activeTickMarkColor: Colors.black,
        inactiveTickMarkColor: Colors.red,
        overlayColor: Colors.yellow,
        overlappingShapeStrokeColor: Colors.black,
        overlayShape: RoundSliderOverlayShape(),
        valueIndicatorColor: Colors.red,
        // tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 10.0),
        showValueIndicator: ShowValueIndicator.onlyForDiscrete,
        minThumbSeparation: 0,

        rangeTrackShape: RoundedRectRangeSliderTrackShape(),
        // rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 15, disabledThumbRadius: 15, pressedElevation: 3),
      ),

      child: RangeSlider(
        values: RangeValues(sliderValue, sliderEndValue),
        min: 0,
        max: 200,
        onChanged: (rangeValues) {

          sliderValue = rangeValues.start;
          sliderEndValue = rangeValues.end;

          setState(() {

          });
        },
      ),
    );
  }

}




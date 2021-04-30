import 'dart:async';
import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/serial/app_position.dart';
import 'package:geolocator/geolocator.dart';


class GeoLocatorWidget extends StatefulWidget {
  @override
  _GeoLocatorWidgetState createState() => _GeoLocatorWidgetState();
}

class _GeoLocatorWidgetState extends State<GeoLocatorWidget> {
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position>  _positionStreamSubscription;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(
          title: Text("ss"),
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: _positionItems.length,
            itemBuilder: (context, index) {
              final positionItem = _positionItems[index];
              if (positionItem.type == _PositionItemType.permission) {
                return ListTile(
                  title: Text(positionItem.displayValue,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                );
              } else {
                return Card(
                  child: ListTile(
                    tileColor: Colors.black45,
                    title: Text(
                      positionItem.displayValue,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Positioned(
              bottom: 10.0,
              right: 10.0,
              child: FloatingActionButton.extended(
                heroTag: "btn1",
                onPressed: () => setState(_positionItems.clear),
                label: Text("clear"),
              ),
            ),
            Positioned(
              bottom: 80.0,
              right: 10.0,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  await Geolocator.getLastKnownPosition().then((value) => {
                    _positionItems.add(_PositionItem(
                        _PositionItemType.position, value.toString()))
                  });

                  setState(
                        () {},
                  );
                },
                label: Text("Last Position"),
              ),
            ),
            Positioned(
              bottom: 150.0,
              right: 10.0,
              child: FloatingActionButton.extended(
                  heroTag: "btn2",
                  onPressed: () async {
                    await Geolocator.getCurrentPosition().then((value) {
                      print("value"+value.toString());
                      _positionItems.add(_PositionItem(
                          _PositionItemType.position, value.toString()));
                      return Future.value(Void);
                    });

                    setState(
                          () {},
                    );
                  },
                  label: Text("Current Position")),
            ),
            Positioned(
              bottom: 220.0,
              right: 10.0,
              child: FloatingActionButton.extended(
                heroTag: "btn3",
                onPressed: _toggleListening,
                label: Text(() {
                  if (_positionStreamSubscription == null) {
                    return "Start stream";
                  } else {
                    final buttonText = _positionStreamSubscription.isPaused
                        ? "Resume"
                        : "Pause";

                    return "$buttonText stream";
                  }
                }()),
                backgroundColor: _determineButtonColor(),
              ),
            ),
            Positioned(
              bottom: 290.0,
              right: 10.0,
              child: FloatingActionButton.extended(
                heroTag: "btn4",
                onPressed: () async {
                  await Geolocator.checkPermission().then((value)  {
                    print("checkPermission="+value.toString());
                    _positionItems.add(_PositionItem(
                        _PositionItemType.permission, value.toString()));

                  });
                  setState(() {});

                },

                label: Text("Check Permission"),
              ),
            ),
            Positioned(
              bottom: 360.0,
              right: 10.0,
              child: FloatingActionButton.extended(
                heroTag: "btn5",
                onPressed: () async {
                  await Geolocator.requestPermission().then((value)  {
                    print("requestPermission="+value.toString());

                    _positionItems.add(_PositionItem(
                        _PositionItemType.permission, value.toString()));
                  });
                  setState(() {});
                },
                label: Text("Request Permission"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription.isPaused);

  Color _determineButtonColor() {
    return _isListening() ? Colors.green : Colors.red;
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = Geolocator.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) => setState(() => _positionItems.add(
          _PositionItem(_PositionItemType.position, position.toString()))));
      _positionStreamSubscription?.pause();
    }

    setState(() {
      if (_positionStreamSubscription == null) {
        return;
      }

      if (_positionStreamSubscription.isPaused) {
        _positionStreamSubscription.resume();
      } else {
        _positionStreamSubscription.pause();
      }
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription !=null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }
}

enum _PositionItemType {
  permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
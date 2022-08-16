import 'package:flutter/material.dart';

class StickyApp extends StatefulWidget {
  const StickyApp({super.key});

  @override
  _StickyAppState createState() => _StickyAppState();
}

class _StickyAppState extends State<StickyApp> {
  final ScrollController _mainScrollController = ScrollController(initialScrollOffset: 1);

  final double _removableWidgetSize = 200;
  bool _isStickyOnTop = false;
  double percent = 0.0;

  Container _getStickyWidget() {
    return Container(
      alignment: Alignment.center,
      height: 80,
      color: Colors.green,
      child: Text(
        'sticky sub header'.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _mainScrollController.addListener(() {
      setState(() {
        percent = _mainScrollController.offset;
      });
      print("offssettt:: ${_mainScrollController.offset}");
      if (_mainScrollController.offset >= _removableWidgetSize && !_isStickyOnTop) {
        setState(() {
          _isStickyOnTop = true;
        });
      } else if (_mainScrollController.offset < _removableWidgetSize && _isStickyOnTop) {
        setState(() {
          _isStickyOnTop = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.blueGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 20),
                height: 100,
                color: Colors.pink.withOpacity(percent < 100 ? percent : 0),
                child: Text(
                  'header'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: Stack(
                  children: [
                    ListView(
                      controller: _mainScrollController,
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: _removableWidgetSize,
                          color: Colors.yellow,
                          child: Text(
                            'scrollable area'.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _getStickyWidget(),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 4),
                          shrinkWrap: true,
                          itemCount: 33,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              alignment: Alignment.center,
                              height: 50,
                              margin: const EdgeInsets.only(
                                bottom: 4,
                              ),
                              color: Colors.white.withOpacity(0.3),
                              child: Text(
                                '$index',
                                // textAlign: TextAlign.,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    if (_isStickyOnTop) _getStickyWidget()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

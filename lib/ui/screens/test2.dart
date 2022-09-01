import 'package:flutter/material.dart';

class StickyApp extends StatefulWidget {
  const StickyApp({super.key});

  @override
  _StickyAppState createState() => _StickyAppState();
}

class _StickyAppState extends State<StickyApp> {
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _subScrollController = ScrollController();

  final double _removableWidgetSize = 200;
  bool _isStickyOnTop = false;

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
      if (_mainScrollController.offset >= _removableWidgetSize && !_isStickyOnTop) {
        _isStickyOnTop = true;
        setState(() {});
      } else if (_mainScrollController.offset < _removableWidgetSize && _isStickyOnTop) {
        _isStickyOnTop = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 100),
          child: _isStickyOnTop ? _getStickyWidget() : const SizedBox.shrink(),
        ),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container(
            //   alignment: Alignment.bottomCenter,
            //   padding: const EdgeInsets.only(bottom: 20),
            //   height: 100,
            //   color: Colors.pink,
            //   child: Text(
            //     'header'.toUpperCase(),
            //     style: const TextStyle(
            //       color: Colors.white,
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
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
                        controller: _subScrollController,
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
                  // if (_isStickyOnTop) _getStickyWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

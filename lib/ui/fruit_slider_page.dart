import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task4/models/fruit.dart';
import 'package:task4/ui/fruit_detail_page.dart';
import 'package:task4/ui/widgets/fruit_card.dart';


class FruitsSliderPage extends StatefulWidget {
  const FruitsSliderPage({
    super.key,
  });

  @override
  _FruitsSliderPageState createState() => _FruitsSliderPageState();
}

class _FruitsSliderPageState extends State<FruitsSliderPage> {
  PageController? _pageController;
  late int _index;
  late int _auxIndex;
  double? _percent;
  double? _auxPercent;
  late bool _isScrolling;

  @override
  void initState() {
    _pageController = PageController();
    _index = 0;
    _auxIndex = _index + 1;
    _percent = 0.0;
    _auxPercent = 1.0 - _percent!;
    _isScrolling = false;
    _pageController!.addListener(_pageListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController!
      ..removeListener(_pageListener)
      ..dispose();
    super.dispose();
  }

  //--------------------------
  // Page View Listener
  //--------------------------
  void _pageListener() {
    _index = _pageController!.page!.floor();
    _auxIndex = _index + 1;
    _percent = (_pageController!.page! - _index).abs();
    _auxPercent = 1.0 - _percent!;

    _isScrolling = _pageController!.page! % 1.0 != 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const fruits = Fruit.fruits;
    const  angleRotate = -pi * .5;
    return Scaffold(
      //---------------
      // App Bar
      //---------------
      appBar: AppBar(
        title:const  Text("Fruits"),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: kThemeAnimationDuration,
            top: 0,
            bottom: 0,
            right: _isScrolling ? 10 : 0,
            left: _isScrolling ? 10 : 0,
            child: Stack(
              children: [

                Transform.translate(
                  offset: Offset(0, 50 * _auxPercent!),
                  child: FruitCard(
                    fruit: fruits[_auxIndex.clamp(0, fruits.length - 1)],
                    factorChange: _auxPercent,
                  ),
                ),

                Transform.translate(
                  offset: Offset(-800 * _percent!, 100 * _percent!),
                  child: Transform.rotate(
                    angle: angleRotate * _percent!,
                    child: FruitCard(
                      fruit: fruits[_index],
                      factorChange: _percent,
                    ),
                  ),
                )
              ],
            ),
          ),
          //-----------------------------------------------------
          // VOID PAGE VIEW
          // This page view is just for using the page controller
          //-----------------------------------------------------
          PageView.builder(
            controller: _pageController,
            itemCount: fruits.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => _openDetail(context, fruits[index]),
                child: const SizedBox(),
              );
            },
          )
        ],
      ),
    );
  }

  void _openDetail(BuildContext context, Fruit fruit) {
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: FruitDetailPage(
            fruit: fruit,
          ),
        );
      },
    ));
  }
}

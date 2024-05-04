import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task4/models/fruit.dart';

class FruitDetailPage extends StatefulWidget {
  const FruitDetailPage({
    super.key,
    required this.fruit,
  });

  final Fruit fruit;

  @override
  _FruitDetailPageState createState() => _FruitDetailPageState();
}

class _FruitDetailPageState extends State<FruitDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController? _controller;
  late Animation<double> _colorGradientValue;
  late Animation<double> _whiteGradientValue;

  late bool _changeToBlack;
  late bool _enableInfoItems;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _colorGradientValue = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
          curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
          parent: _controller!),
    );

    _whiteGradientValue = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
          curve: const Interval(0.1, 1, curve: Curves.fastOutSlowIn),
          parent: _controller!),
    );

    _changeToBlack = false;
    _enableInfoItems = false;

    Future.delayed(const Duration(milliseconds: 600), () {
      _controller!.forward();
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _changeToBlack = true;
        });
      });
    });

    _controller!.addStatusListener(_statusListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller!
      ..removeStatusListener(_statusListener)
      ..dispose();
    super.dispose();
  }


  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _enableInfoItems = true;
      });
    }
  }


  void _backButtonTap() async {
    setState(() {
      _enableInfoItems = false;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _changeToBlack = false;
      });
    });
    await _controller!.reverse();
    if(mounted){
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: Stack(
        children: [
          //-------------------------
          // Animated Background
          //-------------------------
          Positioned.fill(
              child: Hero(
            tag: "${widget.fruit.heroName}background",
            child: AnimatedBuilder(
                animation: _controller!,
                builder: (_, __) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(widget.fruit.rawColor!),
                          Colors.white
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          _colorGradientValue.value,
                          _whiteGradientValue.value
                        ],
                      ),
                    ),
                  );
                }),
          )),
          //----------------------
          // Items Body
          //----------------------
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SafeArea(
                  child: Hero(
                    tag: widget.fruit.pathImage!,
                    child: Image.asset(
                      widget.fruit.pathImage!,
                      height: size.height * .3,
                      width: size.width,
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Align(
                        heightFactor: .7,
                        alignment: Alignment.bottomLeft,
                        child: FittedBox(
                          child: Hero(
                            tag: widget.fruit.heroName!,
                            child: AnimatedDefaultTextStyle(
                              duration: kThemeAnimationDuration,
                              style: textTheme.headline2!.copyWith(
                                  color: _changeToBlack
                                      ? Colors.black
                                      : Colors.white),
                              child: Text(
                                widget.fruit.heroName!
                                    .replaceAll(' ', '\n')
                                    .toLowerCase(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //---------------------------------------
                          // Superhero Secret Identity Name
                          //---------------------------------------
                          AnimatedDefaultTextStyle(
                            duration: kThemeAnimationDuration,
                            style: textTheme.headline5!.copyWith(
                                color: _changeToBlack
                                    ? Colors.black
                                    : Colors.white),
                            child: Text(
                              widget.fruit.name!.toLowerCase(),
                            ),
                          ),
                          //--------------------------
                          // Animated Marvel Logo
                          //--------------------------
                          TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.fastOutSlowIn,
                            tween: Tween(
                              begin: 0,
                              end: _enableInfoItems ? 1.0 : 0.0,
                            ),
                            builder: (context, dynamic value, child) {
                              return Transform.scale(
                                scale: double.parse(value.toString()),
                                child: child,
                              );
                            },
                            child: Image.asset(
                              widget.fruit.pathImage!,
                              height: 35,
                              width: 100,
                            ),
                          )
                        ],
                      ),
                      const Divider(height: 30),

                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        transform: Matrix4.translationValues(
                          0,
                          _enableInfoItems ? 0 : 50,
                          0,
                        ),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _enableInfoItems ? 1.0 : 0.0,
                          child: Text(
                            widget.fruit.description!,
                            style: GoogleFonts.lato(
                              color: Colors.grey[500],
                              height: 1.5,
                            ),
                            maxLines: 4,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const Divider(height: 30),
                      //----------------------------------
                      // Section Movies Title
                      //----------------------------------
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        transform: Matrix4.translationValues(
                          0,
                          _enableInfoItems ? 0 : 50,
                          0,
                        ),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _enableInfoItems ? 1.0 : 0.0,
                          child: Text(
                            'Fruits',
                            style: textTheme.headline5!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //----------------------------
                // Superhero movies list
                //----------------------------
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      //---------------------------
                      // Animated Movie Card
                      //---------------------------
                      return TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 1000 + (300 * index)),
                        curve: Curves.elasticOut,
                        tween: Tween(
                          begin: 0,
                          end: _enableInfoItems ? 0.0 : 1.0,
                        ),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 50 * value),
                            child: Opacity(
                                opacity: 1 - value.clamp(0.0, 1.0),
                                child: child),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(images[index],height: 100,width: 100,),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          //-------------------------
          // Back Button
          //-------------------------
          Positioned(
            left: 20,
            top: 0,
            child: SafeArea(
              child: IconButton(
                onPressed: _backButtonTap,
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          )
        ],
      ),
    );
  }
}

List images = [
  "assets/grapes.png",
  "assets/kiwi.png",
  "assets/orange.png",
  "assets/appl.png",
  "assets/peach.png",

];
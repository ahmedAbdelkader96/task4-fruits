import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task4/models/fruit.dart';

class FruitCard extends StatelessWidget {
  const FruitCard({
    super.key,
    required this.fruit,
    required this.factorChange,
  });

  final Fruit fruit;
  final double? factorChange;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final separation = size.height * .24;
    return OverflowBox(
      alignment: Alignment.topCenter,
      maxHeight: size.height,
      child: Stack(
        children: [

          Positioned.fill(
            top: separation,
            child: Hero(
              tag: "${fruit.heroName}background",
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(fruit.rawColor!),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            top: separation * factorChange!,
            bottom: size.height * .55,
            child: Opacity(
              opacity: 1.0 - factorChange!,
              child: Transform.scale(
                scale: lerpDouble(1, .4, factorChange!)!,
                child: Hero(
                  tag: fruit.pathImage!,
                  child: Image.asset(fruit.pathImage!,fit: BoxFit.contain,),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            right: 100,
            top: size.height * .55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                FittedBox(
                  child: Hero(
                    tag: fruit.heroName!,
                    child: Text(
                      fruit.heroName!.replaceAll(' ', '\n').toLowerCase(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),

                Text(
                  fruit.name!.toLowerCase(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 25),
                Text.rich(
                  const TextSpan(
                    text: 'learn more',
                    children:  [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.arrow_right_alt,
                          color: Colors.amber,
                        ),
                      )
                    ],
                  ),
                  style: GoogleFonts.lato(
                      color: Colors.amber,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

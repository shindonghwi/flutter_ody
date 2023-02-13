import 'package:flutter/material.dart';

/**
 * @feature: 백그라운드에 표시되는 gif
 * @author: 2023/02/13 8:33 PM donghwishin
*/
class BackgroundGif extends StatefulWidget {
  const BackgroundGif({Key? key}) : super(key: key);

  @override
  State<BackgroundGif> createState() => _BackgroundGifState();
}

class _BackgroundGifState extends State<BackgroundGif> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    _changeOpacity();
  }

  void _changeOpacity() {
    setState(() {
      opacityLevel = 0.9;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacityLevel,
      duration: Duration(seconds: 3),
      child: Image.asset(
        "assets/gifs/login.gif",
        gaplessPlayback: true,
        fit: BoxFit.fill,
      ),
    );
  }
}

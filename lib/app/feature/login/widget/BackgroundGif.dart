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

  String backgroundGifPath = "assets/gifs/login.gif";
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
      duration: Duration(seconds: 1),
      child: Image.asset(
        backgroundGifPath,
        gaplessPlayback: true,
        fit: BoxFit.fill,
      ),
    );
  }
}

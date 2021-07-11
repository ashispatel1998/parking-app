
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class background extends StatelessWidget {
  const background({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect)=>LinearGradient(
          begin: Alignment.bottomCenter,
          end:Alignment.center,
          colors: [Colors.black,Colors.transparent]
      ).createShader(rect),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(
          image: AssetImage("assets/images/park.png"),
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}

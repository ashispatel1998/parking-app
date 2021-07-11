import 'package:flutter/material.dart';

import '../pallete.dart';

class OwnerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          hoverColor: Colors.transparent,
          icon: Icon(Icons.arrow_back_ios,color: kWhite,),
        ),
        title: Text("PAH"),
        centerTitle: true,
      ),
      body: Center(

      ),
    );
  }
}
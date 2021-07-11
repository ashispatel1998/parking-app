import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkingapp/widgets/background.dart';
import 'package:parkingapp/widgets/form-fields.dart';
import 'package:parkingapp/widgets/rounded-button.dart';

import '../pallete.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              hoverColor: Colors.transparent,
              icon: Icon(Icons.arrow_back_ios,color: kWhite,),
            ),
            title: Text("Forgot Password"),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextInputField(
                  icon: FontAwesomeIcons.envelope,
                  hint: 'Email',
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedButton(buttonName: 'Send Verification Link',),
              ],
            ),
          ),
        )
      ],
    );
  }
}

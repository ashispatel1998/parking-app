import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkingapp/Screens/user_login_screen.dart';
class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  static const IconData logout = IconData(0xe3b3, fontFamily: 'MaterialIcons');
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar : AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Park at home",style: TextStyle(color: Colors.black),),
          centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[
           Padding(
             padding: const EdgeInsets.all(15.0),
             child: GestureDetector(
                 child: FaIcon(
                   FontAwesomeIcons.signOutAlt,
                   color: Colors.redAccent,
                 ),
               onTap: () {
                   FirebaseAuth.instance.signOut();
                   Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(builder: (context) => UserScreen()),
                         (Route<dynamic> route) => false,
                   );
               },
             ),
           )
          ],
        ),
        drawer: Drawer(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:parkingapp/Screens/parking_owner_screen.dart';
import 'package:parkingapp/Screens/user_login_screen.dart';
import 'package:parkingapp/widgets/background.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        background(),
        Scaffold(
          appBar:AppBar(
            title:Text("PARK AT HOME",style: TextStyle(color: Colors.white),),
            centerTitle: true,
            elevation: 1,
            backgroundColor: Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                              colors: [Colors.redAccent,Colors.pink],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.people,color: Colors.white,),
                              title: Text('Continue as User',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                              subtitle: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text('Parking location near you.',
                                  style: TextStyle(fontSize: 15,color: Colors.white),),
                              ),
                            ),
                            ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: const Text('Continue',style: TextStyle(color: Colors.black),),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => UserScreen()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                              colors: [Colors.redAccent,Colors.pink],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.people,color: Colors.white,),
                              title: Text('Continue as House Owner',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                              subtitle: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text('Earn money by sharing your parking area.',
                                  style: TextStyle(fontSize: 15,color: Colors.white),),
                              ),
                            ),
                            ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: const Text('Continue',style: TextStyle(color: Colors.black),),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => OwnerScreen()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}


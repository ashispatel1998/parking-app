
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/pallete.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../methods.dart';
import 'add-details-screen.dart';

class CreateAccountScreen extends StatefulWidget {

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {

  String email;

  String password;

  String confirmPassword;

  bool _isLoading=false;

  GlobalKey<FormState> _formKey=GlobalKey<FormState>();


  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      setState(() {
        _isLoading=false;
      });
      return;
    }
    _formKey.currentState.save();
    _signup(email,password);
  }

  Future<void> _signup(String email,String password) async{
    FirebaseAuth _auth=FirebaseAuth.instance;
    try{
      User user=(await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
      if(user!=null){
        showToast("Account Created Successfully!");
        FirebaseAuth.instance.currentUser.sendEmailVerification();
        Navigator.push(context, MaterialPageRoute(builder : (context)=>AddDetails()));
      }else{
        showToast("Account Creation Failed.Try again sometime!");
      }
      setState(() {
        _isLoading=false;
      });
    }
    catch(e){
      showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          hoverColor: Colors.transparent,
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: Text("Create Account",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        opacity: 0.5,
        color: Colors.black,
        progressIndicator: CircularProgressIndicator(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),
                          onChanged: (val) {
                            email=val;
                          },
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter a valid email!';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password"),
                            onChanged: (val) {
                              password=val;
                            },
                            validator: (value) {
                              if (value.isEmpty || !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$").hasMatch(value)) {
                                return 'Enter a valid password! Eg. example@123';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Confirm Password"),
                            onChanged: (val) {
                              confirmPassword=val;
                            },
                            validator: (value) {
                              if (value.isEmpty || !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$").hasMatch(value) ) {
                                return 'Enter a valid password! Eg. example@123';
                              }
                              if(value!=password){
                                return 'Password must be same';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: size.height*0.08,
                          width: size.width*0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: kBlue
                          ),
                          child: FlatButton(
                            onPressed: (){
                              setState(() {
                                _isLoading=true;
                              });
                              _submit();
                            },
                            child: Text("Sign Up",style: kBodyText.copyWith(fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Colors.black))
                  ),
                  child: GestureDetector(
                    onTap: ()=>Navigator.pop(context),
                    child: Text('Already have an account',
                      style: TextStyle(color: Colors.blueAccent,fontSize: 18),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

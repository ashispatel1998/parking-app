import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/Screens/user-home-screen.dart';
import 'package:parkingapp/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../methods.dart';

class UserScreen extends StatefulWidget {

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with WidgetsBindingObserver  {

  String email;

  String password;

  GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  bool _isLoading=false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkUser();
  }

  void checkUser(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) async {
      if (user == null) {
      } else {
        if(user.emailVerified){
          Navigator.push(context, MaterialPageRoute(builder : (context)=>UserHomeScreen()));
        }else{
          await user.sendEmailVerification();
          showToast("Please check your email for verification!");
        }
      }
    });
  }

  void _submit(){
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      setState(() {
        _isLoading=false;
      });
      return;
    }
    _formKey.currentState.save();
    _login(email,password);
  }

  Future<void> _login(String email,String password) async{
    try{
      UserCredential user= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(FirebaseAuth.instance.currentUser.emailVerified){
        setState(() {
          _isLoading=false;
        });
        Navigator.push(context, MaterialPageRoute(builder : (context)=>UserHomeScreen()));
      }
      else{
        FirebaseAuth.instance.currentUser.sendEmailVerification();
        showToast("Please check your email for verification!");
        setState(() {
          _isLoading=false;
        });
      }
    }
    catch(e){
      setState(() {
        _isLoading=false;
      });
      showToast(e.toString());
  }
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: Text("Login",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body:LoadingOverlay(
        isLoading: _isLoading,
        opacity: 0.5,
        color: Colors.black,
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
                            email = val;
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
                              password = val;
                            },
                            validator: (value) {
                              if (value.isEmpty || !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$").hasMatch(value)) {
                                return 'Enter a valid password! Eg. example@123';
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(color: Colors.redAccent,fontSize: 18),
                                ),
                              ),
                              onTap: () => Navigator.pushNamed(context, 'forgotpassword'),
                            ),
                          ],
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
                            child: Text("Login",style: kBodyText.copyWith(fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("OR",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:5.0),
                      child: _buildSocialBtn(
                            () => print('Login with Facebook'),
                        AssetImage(
                          'assets/images/facebook.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:5.0),
                      child: _buildSocialBtn(
                            () => print('Login with Google'),
                        AssetImage(
                          'assets/images/google.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:5.0),
                      child: _buildSocialBtn(
                            () => print('Login with Apple'),
                        AssetImage(
                          'assets/images/apple.png',
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1,color: Colors.black))
                    ),
                    child: GestureDetector(
                      onTap: ()=>Navigator.pushNamed(context, 'usercreateaccount'),
                      child: Text('Create New Account',
                        style: TextStyle(color: Colors.blueAccent,fontSize: 18),),
                    ),
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

}





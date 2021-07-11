import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:parkingapp/methods.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../pallete.dart';

class AddDetails extends StatefulWidget {
  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name;
  String dob;
  String mobileno;
  String DLno;
  String gender = 'Male';
  String address;
  String dropdownValue = 'User';
  String ownerLat="70";
  String ownerLong="80";
  String ownerLocation="70,80";

  bool _isLoading = false;
  bool codesent=false;
  bool otpButtonVisibility=false;

  List <String> userItems = [
    'User',
    'Owner',
  ];

  List <String> genderItems = [
    'Male',
    'Female',
    'Others'
  ];

  void verifyEmail() {
    if (!FirebaseAuth.instance.currentUser.emailVerified) {
      showToast("Please verify your mail to continue!");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
        ),
        title: Text("Enter details", style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: LoadingOverlay(
          isLoading: _isLoading,
          opacity: 0.5,
          color: Colors.black,
          child: codesent?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Please enter the otp sent to your mobile no",style: TextStyle(fontSize: 18),),
                OTPTextField(
                  length: 6,
                  width: 270,
                  fieldWidth: 40,
                  style: TextStyle(
                      fontSize: 17
                  ),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onChanged: (val){
                    if(val.isEmpty||val.length==1){
                      setState(() {
                        otpButtonVisibility=false;
                      });
                    }else{
                      setState(() {
                        otpButtonVisibility=true;
                      });
                    }
                  },
                ),
                otpButtonVisibility?Padding(
                  padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 50),
                  child: Container(
                    height: size.height * 0.08,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: kBlue
                    ),
                    child: FlatButton(
                      onPressed: () {
                      },
                      child: Text("Submit", style: kBodyText.copyWith(
                          fontWeight: FontWeight.bold),),
                    ),
                  ),
                ):Text(""),
              ],
            ),
          ):SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10),
                  child: selectusertype(userItems),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter Name"),
                          onChanged: (val) {
                            name = val;
                          },
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter name!';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Enter Mobile"),
                            onChanged: (val) {
                              mobileno = val;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                if (value.length != 10) {
                                  return 'Invalid mobile number!';
                                }
                                return 'Enter mobile';
                              }
                              return null;
                            },
                          ),
                        ),
                        dropdownValue=='User'?Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Enter DL no"),
                            onChanged: (val) {
                              DLno = val;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter DL no!';
                              }
                              return null;
                            },
                          ),
                        ):Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: TextFormField(
                            initialValue: ownerLocation,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Location"),
                            onChanged: (val) {

                            },
                            readOnly: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Date of Birth",
                              hintText: 'Eg.14/02/1998'
                            ),
                            onChanged: (val) {
                              dob=val;
                            },
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: selectgendertype(genderItems),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: TextFormField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Enter Address"),
                            onChanged: (val) {
                              address = val;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Address!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: kBlue
                          ),
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                codesent=true;
                              });
                            },
                            child: Text("Continue", style: kBodyText.copyWith(
                                fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Container selectusertype(List<String> items) {
    return Container(
      height: 57,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
          border: Border.all(color: Colors.grey
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  onChanged: (String data) {
                    setState(() {
                      dropdownValue = data;
                    });
                  },
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(color: Colors.grey,),
                      ),),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container selectgendertype(List<String> items) {
    return Container(
      height: 57,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: gender,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  onChanged: (String data) {
                    setState(() {
                      gender = data;
                    });
                  },
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(color: Colors.grey,),
                      ),),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
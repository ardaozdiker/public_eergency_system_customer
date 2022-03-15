// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:public_eergency_system_customer/UserScreen.dart';

class OTPscreen extends StatefulWidget {
  const OTPscreen({Key? key, required this.phone}) : super(key: key);
  final String phone;

  @override
  _OTPscreenState createState() => _OTPscreenState();
  
}

class _OTPscreenState extends State<OTPscreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   String _verificationCode= "";
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(43, 46, 66, 1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color.fromARGB(126, 203, 224, 1)));
  @override
  
  void initState(){
    super.initState();
    verifyPhone();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          title: Center(child: Text("SMS Verification")),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              child: Center(
                child: Text(
                  "verify +90 ${widget.phone}",         //number where verification sent to 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: PinPut(                                                        //verification code here
                fieldsCount: 6,
                textStyle: const TextStyle(fontSize: 25, color: Colors.white),
                eachFieldWidth: 40,
                eachFieldHeight: 55,
                //       onSubmit: (String pin) => _showSnackBar(pin),
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                pinAnimationType: PinAnimationType.fade,
                submittedFieldDecoration: pinPutDecoration,
                selectedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration,
                onSubmit: (pin) async {
                  try {
                    print("deniyor");
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode, smsCode: pin))
                        .then((value) async {
                        if (value.user != null) {
                          print("pass to homepage");
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserScreen()),
                              (route) => false);
                      }
                    });
                  }catch (exception) {
                    FocusScope.of(context).unfocus();
                    scaffoldKey.currentState?.showSnackBar(SnackBar(
                        content:
                            Text("Invalid verification Code! Check the SMS.")));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  verifyPhone() async {
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+90 ${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print("user logged in!!");
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print("firebaseden kod atarken bir hata oluştu.");
          print(e.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          setState(() {
        //    _verificationCode = verificationID;
          });
                      _verificationCode = verificationID;
;
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }
}

import 'package:flutter/material.dart';
import 'package:public_eergency_system_customer/OTPscreen.dart';
import 'package:public_eergency_system_customer/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:public_eergency_system_customer/services/auth_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameCon = new TextEditingController();
  final TextEditingController emailCon = new TextEditingController();
  final TextEditingController passwordCon = new TextEditingController();
  final TextEditingController phoneCon = new TextEditingController();
  bool checkboxvalue = false;
  bool value = false;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900]!,
          Colors.orange[800]!,
          Colors.orange[400]!
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "We love our country.",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!))),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "       Name Surname",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                  controller: nameCon,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!))),
                                child: TextField(
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      hintText: "       Email Address",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                  controller: emailCon,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!))),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "       Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                  controller: passwordCon,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!))),
                                child: TextField(
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      prefix: Text("+90"),
                                      hintText: "Phone Number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                  controller: phoneCon,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                            ),
                            Builder(builder: (context) {
                              return Center(
                                child: TextButton(
                                  child: Text("I Already Have An Account"),
                                  style: TextButton.styleFrom(
                                      primary: Colors.grey),
                                  onPressed: () {},
                                ),
                              );
                            }),
                          ],
                        ),
                        Row(
                          //terms agreement here
                          children: [
                            Checkbox(
                                value: checkboxvalue,
                                activeColor: Colors.red,
                                onChanged: (bool) {
                                  setState(() {
                                    if (checkboxvalue == false) {
                                      checkboxvalue = true;
                                    } else {
                                      checkboxvalue = false;
                                    }
                                  });
                                }),
                            Text(
                              " I've read and accept the user agreement.",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(13),
                              child: ElevatedButton(
                                child: Text(
                                  "Register Now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  registerTap();
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            side: BorderSide(
                                                color: Colors.orange))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.orange[900])),
                              ),
                            ))
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
    );
  }

  void registerTap() {
    if (nameCon.text.isNotEmpty &&
        emailCon.text.isNotEmpty &&
        phoneCon.text.isNotEmpty &&
        passwordCon.text.isNotEmpty &&
        checkboxvalue == true) {
      setState(() {
        isloading = true;
      });
      AuthService()
          .createPerson(nameCon.text, emailCon.text, passwordCon.text,
              phoneCon.text, true)
          .then((value) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OTPscreen(
                  phone: phoneCon.text,
                )));
      }).catchError((Error) {
        if (Error.toString().contains("email-already-in-use")) {
          print("bu adres zaten kullanılmakta");
        }
        print(Error);
      }).whenComplete(() {
        setState(() {
          isloading = false;
        });
      });
      print("kayıt işlemi tamamlandı.");
    } else {
      print("eksik alanları doldurun");
    }
  }
}

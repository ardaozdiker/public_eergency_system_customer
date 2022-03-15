import 'package:flutter/material.dart';
import 'package:public_eergency_system_customer/UserScreen.dart';
import 'package:public_eergency_system_customer/main.dart';
import 'package:public_eergency_system_customer/widgets/emptySection.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmptySection(
                emptyImg: "assets/images/success_transparent.gif",
                emptyMsg: 'Successful !',
                key: null,
              ),
              Text(
                'Your Report has uploaded successfully ',
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                child: Text("Back to Home Page"),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserScreen(),
                  ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.orange))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange[900])),
              ),
            ],
          ),
        ) /* Column(
        */
        );
  }
}

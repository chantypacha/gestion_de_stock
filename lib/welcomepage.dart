import 'package:flutter/material.dart';

import 'loginpage.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        backgroundColor: Colors.yellow,
        body: Center(
          child: Container(
              //color: Colors.white,
              margin: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                Text("Bienvenu",style: TextStyle(fontSize: 50,color: Colors.black),),
                SizedBox(height: 20,),
                Container(
                    child: FlatButton(
                  color: Colors.blue,
                  onPressed: () async {

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_)=> LoginPage())
                    );
                  },/* print("1");
                    await Future.delayed(Duration(seconds: 2),(){
                      print("2");
                    });
                    print("3");

                    return;*/
                  child: Text("commencer",style: TextStyle(color: Colors.white),),
                ))
              ])),
        ));
  }
}

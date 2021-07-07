import 'package:flutter/material.dart';
import 'package:gestion_stock/appbar.dart';
import 'package:oktoast/oktoast.dart';
import 'operationpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String bouton_text = "Se connecter";
  String message_bouton = "Welcome";
  String message_erreur = "";
  String message_ok = "";

  var couleur_de_fond = Colors.white;
  TextEditingController username = TextEditingController(text: "patcha");
  TextEditingController password = TextEditingController(text: "patri123");
  List users = [
    {"username": "patcha", "password": "patri123"},
    {"username": "patc", "password": "patri1"},
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: couleur_de_fond,
        appBar: appbar_view("AUTHENTIFICATION"),
        body: Container(
            //color: Colors.white,
            margin: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(message_bouton),
                  SizedBox(
                    height: 60,
                  ),
                  Text("nom d'utilisateur"),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text("mot de passe"),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
             //     Text(message_erreur),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: FlatButton(
                      color: Colors.red,
                      child: Text(
                        bouton_text,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        print(username.text);
                        print(password.text);
                        print(users.length);

                        String valeurusername = username.text;
                        String valeurpassword = password.text;
                        var resultat = users
                            .where((e) =>
                                e["password"] == valeurpassword &&
                                e["username"] == valeurusername)
                            .toList();
                        print("tailleresultat ${resultat.length}");
                        print("resultat= $resultat");
                        if (resultat.length == 1) {
                          print(message_ok);
                          message_ok="Connexion réussie";
                          setState(() {});
                          showToast(message_ok,
                              position: ToastPosition.top,
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.green,
                              radius: 5.0,
                              textStyle: TextStyle(
                                  fontSize: 16.0, color: Colors.white));
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => OperationPage()));

                        } else {
                          message_erreur =
                              ("Le nom d'utilisateur ou le mot de passe est incorrecte");
                          showToast(message_erreur,
                              position: ToastPosition.top,
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                              radius: 5.0,
                              textStyle: TextStyle(
                                  fontSize: 16.0, color: Colors.black));

                          print(message_erreur);

                          setState(() {});
                        }
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}

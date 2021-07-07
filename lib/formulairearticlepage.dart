import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_stock/appbar.dart';
import 'package:gestion_stock/valeurs/constante.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Formulairearticlepage extends StatefulWidget {
  final Function ajouter;

  const Formulairearticlepage({Key key, this.ajouter}) : super(key: key);

  @override
  _FormulairearticlepageState createState() => _FormulairearticlepageState();
}

class _FormulairearticlepageState extends State<Formulairearticlepage> {
  TextEditingController nom_article = TextEditingController();
  TextEditingController prix = TextEditingController();
  TextEditingController quantite = TextEditingController();
  TextEditingController dateexpiration = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_view("FORMULAIRE ARTICLE"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text("Nom Article"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TextField(
                controller: nom_article,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 10),
            Text("Prix"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TextField(
                controller: prix,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 10),
            Text("Quantité"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TextField(
                controller: quantite,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),

            SizedBox(height: 10),
            Text("Date d'expiration"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TextField(
                controller: dateexpiration,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 20),
            FlatButton(
              color: Colors.red,
              child: Text(
                "ajouter article",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                //widget.ajouter(nom_article.text);
                SharedPreferences memoire = await SharedPreferences.getInstance();
                List<String> toutlesarticles =
                    memoire.getStringList(ARTICLES_KEY) ?? [];
                Map data={
                  "nom":nom_article.text,
                  "quantite":quantite.text,
                  "prix":prix.text,
                  "expiration":dateexpiration.text
                };
                print(data

                );
                String data2=json.encode(data);
                toutlesarticles.add(data2);
                print(toutlesarticles);
                memoire.setStringList(ARTICLES_KEY, toutlesarticles);
                Navigator.pop(context);//retourenarriere
              },
            ),
          ],
        ),
      ),
    );
  }
}

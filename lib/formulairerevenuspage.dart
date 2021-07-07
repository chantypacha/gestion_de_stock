import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_stock/appbar.dart';
import 'package:gestion_stock/valeurs/constante.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Formulairerevenuspage extends StatefulWidget {
  final Function ajouter;

  const Formulairerevenuspage({Key key, this.ajouter}) : super(key: key);

  @override
  _FormulairerevenuspageState createState() => _FormulairerevenuspageState();
}

class _FormulairerevenuspageState extends State<Formulairerevenuspage> {
  TextEditingController quantite = TextEditingController();
  TextEditingController prix = TextEditingController();
  TextEditingController total = TextEditingController();
  String article = null;
  List articles = [];
  int solde_quantite = 0;
  int prix_total = 0;

  @override
  void initState() {
    super.initState();
    recuperer_article();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_view("FORMULAIRE REVENUS"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            en_tete("ARTICLE"),
            SizedBox(height: 20),
            menu_deroulant_articles(),
            SizedBox(height: 20),
            en_tete("QUANTITE"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: quantite,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            en_tete("PRIX"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: prix,
                enabled: false,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            en_tete("TOTAL"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: total,
                enabled: false,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FlatButton(
                      color: Colors.red,
                      child: Text(
                        "ajouter revenu",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        //widget.ajouter(quantite.text);
                        //Navigator.pop(context);
                        SharedPreferences memoire =
                            await SharedPreferences.getInstance();
                        List<String> toutlesrevenus =
                            memoire.getStringList(REVENUS_KEY) ?? [];
                        Map data = {
                          "article": article,
                          "quantite": quantite.text,
                          "prix": prix.text,
                          //"total": prix4,
                        };

                        print(int.parse(quantite.text) * int.parse(prix.text));
                        print(data);
                        String data2 = json.encode(data);
                        toutlesrevenus.add(data2);
                        print(toutlesrevenus);
                        memoire.setStringList(REVENUS_KEY, toutlesrevenus);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget en_tete(text) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(text),
    );
  }

  recuperer_article() async {
    print("recuperer");
    SharedPreferences memoire = await SharedPreferences.getInstance();
    List<String> toutlesarticles = memoire.getStringList(ARTICLES_KEY) ?? [];
    articles = toutlesarticles;
    setState(() {});
  }

  menu_deroulant_articles() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      // height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1)),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                      isExpanded: true,
                      value: article,
                      items: articles.map<DropdownMenuItem<String>>((art) {
                        Map data = json.decode(art);
                        return DropdownMenuItem<String>(
                            value: data["nom"], child: Text(data["nom"]));
                      }).toList(),
                      onChanged: (new_value) {
                        print("nouvelle valeur $new_value");
                        article = new_value;
                        calcul_quantitedisponible(new_value);
                        List recherche_prix = articles.where((e) {
                          Map data = json.decode(e);
                          return data["nom"] == new_value;
                        }).toList();
                        print(recherche_prix);
                        print(recherche_prix[0]);
                        Map d = json.decode(recherche_prix[0]);
                        prix.text = d["prix"];
                        setState(() {});
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  calcul_quantitedisponible(String article_) async {
    SharedPreferences memoire = await SharedPreferences.getInstance();
    List<String> achats = memoire.getStringList(DEPENSES_KEY) ?? [];
    List<String> ventes = memoire.getStringList(REVENUS_KEY) ?? [];
    int somme_achat = 0;
    int somme_vente = 0;
    var resultat_achat = achats.where((e) {
      Map d = json.decode(e);
      return d["article"] == article_;
    }).toList();
    var resultat_vente = ventes.where((e) {
      Map d = json.decode(e);
      return d["article"] == article_;
    }).toList();
    if (resultat_achat.length != 0) {
      resultat_achat.forEach((el) {
        Map d = json.decode(el);
        int qty = int.parse(d["quantite"]);
        somme_achat = somme_achat + qty;
      });
    }
    if (resultat_vente.length != 0) {
      resultat_vente.forEach((ve) {
        Map d = json.decode(ve);
        int qty = int.parse(d["quantite"]);
        somme_vente = somme_vente - qty;
      });
      solde_quantite = somme_achat - somme_vente;
    }
  }}

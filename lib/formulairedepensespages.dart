import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_stock/appbar.dart';
import 'package:gestion_stock/valeurs/constante.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Formulairedepensespage extends StatefulWidget {
  final Function ajouter;

  const Formulairedepensespage({Key key, this.ajouter}) : super(key: key);

  @override
  _FormulairedepensespageState createState() => _FormulairedepensespageState();
}

class _FormulairedepensespageState extends State<Formulairedepensespage> {
  TextEditingController quantite = TextEditingController();
  TextEditingController prix = TextEditingController();
  String article = null;
  List articles = [];
  String erreur_prix = "";
  int solde = 0;
  int prix_total = 0;

  @override
  void initState() {
    super.initState();
    recuperer_article();
    calcul_revenudisponible();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_view("FORMULAIRE DEPENSES: $solde"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            en_tete("ARTICLE"),
           // Text(erreur_prix),
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
                onChanged: (text) {
                  if (text.isNotEmpty && article != null) {
                    int qte = int.parse(text);
                    int p= int.parse(prix.text);
                    prix_total=qte*p;
                    setState(() {

                    });
                  }
                  print(text);
                },
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
            SizedBox(height: 20),
            Divider(color: Colors.grey),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 15),
              child: Row(
                children: [
                  Text("PRIX TOTAL"),
                  SizedBox(width: 10),
                  Text(
                    prix_total.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ],
              ),
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
                        "ajouter depense",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        //widget.ajouter(quantite.text);
                        //Navigator.pop(context);
                        SharedPreferences memoire =
                            await SharedPreferences.getInstance();
                        // int solde = calcul_revenudisponible(memoire);
                        //return;
                        int quant = int.parse(quantite.text);
                        int pr = int.parse(prix.text);
                        int prix_total = quant * pr;
                        if (prix_total <= solde) {
                          erreur_prix = "";
                          List<String> touteslesdepenses =
                              memoire.getStringList(DEPENSES_KEY) ?? [];
                          Map data = {
                            "article": article,
                            "quantite": quantite.text,
                            "prix": prix.text,
                          };
                          print(data);
                          String data2 = json.encode(data);
                          touteslesdepenses.add(data2);
                          print(touteslesdepenses);
                          memoire.setStringList(
                              DEPENSES_KEY, touteslesdepenses);
                          Navigator.pop(context);
                        } else {
                          erreur_prix =
                              " le prix total de la facture a depassé le solde de votre caisse";
                          showToast(erreur_prix,
                              position: ToastPosition.top,
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                              radius: 5.0,
                              textStyle: TextStyle(
                                  fontSize: 16.0, color: Colors.black));
                        }
                        setState(() {});
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
  calculer_prix_total(String prix,String quantite)  {
    
    //setState(() {});
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
                        List recherche_prix = articles.where((e) {
                          Map data = json.decode(e);
                          return data["nom"] == new_value;
                        }).toList();
                        print(recherche_prix);
                        print(recherche_prix[0]);
                        Map d = json.decode(recherche_prix[0]);
                        prix.text = d["prix"];
                        String qte=quantite.text;
                        if(qte.isNotEmpty){
                          prix_total=int.parse(prix.text)*int.parse(qte);
                        }
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

  calcul_revenudisponible() async {
    SharedPreferences memoire = await SharedPreferences.getInstance();
    List<String> depenses = memoire.getStringList(DEPENSES_KEY) ?? [];
    List<String> revenus = memoire.getStringList(REVENUS_KEY) ?? [];
    int somme_depenses = 0;
    int somme_revenus = 0;
    depenses.forEach((de) {
      print(de);
      Map d = json.decode(de);
      String p = d["prix"] == "" ? "1" : d["prix"];
      int quantite = int.parse(d["quantite"]);
      int prix = int.parse(p);
      int total = quantite * prix;
      somme_depenses = somme_depenses + total;
      print(somme_depenses);
    });
    revenus.forEach((re) {
      print("revenus:$re");
      print(re.runtimeType);
      Map r = json.decode(re);
      int quantite = int.parse(r["quantite"]);
      int prix = int.parse(r["prix"]);
      int total = quantite * prix;
      somme_revenus = somme_revenus + total;
    });
    solde = CAISSE - somme_depenses + somme_revenus;
  }
}

import 'package:flutter/material.dart';
import 'package:gestion_stock/Articlespage.dart';
import 'package:gestion_stock/Revenuspage.dart';
import 'package:gestion_stock/Depensespage.dart';
import 'package:gestion_stock/appbar.dart';
import 'package:gestion_stock/valeurs/constante.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OperationPage extends StatefulWidget {
  @override
  _OperationPage createState() => _OperationPage();
}

class _OperationPage extends State<OperationPage> {
  List articles = ["Lotion"];
  List depenses = [];
  List revenus = [];

  @override
  Widget build(BuildContext context) {
    recuperer_article();

    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: appbar_view("OPERATIONS"),
        drawer: Drawer(
            child: Container(
          color: Colors.blue,
          // padding: EdgeInsets.only(left: 20),
          child: ListView(
            children: [
              Container(
                height: 62,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  child: Text(
                    "GESTO",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  // margin: EdgeInsets.all(0),
                  //padding: EdgeInsets.all(0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  //leading: Icons(Icons.book,color:Colors.black),
                  title: Text(
                      "Articles",
                    style: TextStyle(color: Colors.white, fontSize: 25)
                  ),

                  onTap: () async {
                   await Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Articlespage(
                              data_articles: articles,
                            )));
                  setState(() {

                  });
                   },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Colors.black,
                ),
              ), //Separateur
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    "Depenses",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Depensespage(
                              data_depenses: depenses,
                            )));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Colors.black,
                ),
              ), //Separateur
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    "Revenus",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Revenuspage(
                              data_revenus: revenus,
                            )));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )),
        body: (Center(
          child: Container(
            margin: EdgeInsets.only(top: 20,left: 10),
            child: Column(
              children: [
                article_view()
              ],
            ),
          ),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            somme(2, 7);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ));

    // ,floatingActionButton: FloatingActionButton(onPressed:(){) ,
    // centerTitle: false,
//MaterialPageRoute()
  }

  recuperer_article() async{
    SharedPreferences memoire= await SharedPreferences.getInstance();
    List<String> toutlesarticles = memoire.getStringList(ARTICLES_KEY) ?? [] ;
    articles = toutlesarticles;
    setState(() {});
  }

  ListView article_view() {
    return ListView.builder(
      shrinkWrap: true,
        itemCount: articles.length,
        itemBuilder: (c, index) {
        String article = articles[index];
          return Card(
            elevation: 8,
            color: Color.fromRGBO(64, 75, 96, 0.9),
            child: Padding(
              padding: const EdgeInsets.only(left: 1,right:1),
              child: ListTile(
                leading: Icon(Icons.list_alt,color: Colors.white,),
                title: Text(
                  article,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),

                //subtitle: Padding(
                  //padding: const EdgeInsets.symmetric(vertical: 8),
                  //child: Text("Sous-titre"),
                //),
                trailing:  Icon(Icons.keyboard_arrow_right,color: Colors.white,),
                onTap: ()  {
                },
              ),
            ),
          );
        });
  }

  ajouter() {
    print("ajouter2");
    somme(5, 20);
  }

  somme(int a, int b) {
    int c = a + b;
    print("somme égale $c");
  }

  cliquer(String type) {
    print("J'ai cliqué sur $type");
  }

  ajouterarticle(String article) {
    articles.add(article);
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_stock/appbar.dart';
import 'package:gestion_stock/valeurs/constante.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'formulairearticlepage.dart';

class Articlespage extends StatefulWidget {
  final List data_articles;

  const Articlespage({Key key, this.data_articles}) : super(key: key);

  @override
  _ArticlespageState createState() => _ArticlespageState();
}

class _ArticlespageState extends State<Articlespage> {
  List articles = [];
  @override
  void initState() {
    super.initState();
    recuperer_article();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: appbar_1("ARTICLES", context,recuperer_article),
        body: Container(
          margin: EdgeInsets.only(top: 20, left: 10),
          child: Column(
            children: [article_view()],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //print("Article avant mise à jour ${widget.data_articles}");
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => Formulairearticlepage(
                      ajouter: ajouter_articles,
                    )));
            recuperer_article();
            //print("Article après mise à jour ${widget.data_articles}");
            setState(() {});
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ));
  }

  recuperer_article() async{
    print("recuperer") ;
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
          Map data=json.decode(article);
          return Card(
            elevation: 8,
            color: Color.fromRGBO(64, 75, 96, 0.9),
            child: Padding(
              padding: const EdgeInsets.only(left: 1,right:1),
              child: ListTile(
                leading: Icon(Icons.list_alt,color: Colors.white,),
                title: Row(
                  children: [
                    Text(
                      data["nom"],
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "(${data["quantite"]})",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),

                subtitle: Padding(
               padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data["prix"],style: TextStyle(color: Colors.white),),
                    SizedBox(height: 8,),
                    Text(data["expiration"],style: TextStyle(color: Colors.white),),
                  ],
                ),
                ),
                trailing:  Icon(Icons.keyboard_arrow_right,color: Colors.white,),
                onTap: ()  {
                },
              ),
            ),
          );
        });
  }

  ajouter_articles(String new_article) {
    widget.data_articles.add(new_article);
    print(widget.data_articles);
  }
}

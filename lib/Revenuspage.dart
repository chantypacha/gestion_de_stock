import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_stock/appbar.dart';
import 'package:gestion_stock/valeurs/constante.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'formulairerevenuspage.dart';

class Revenuspage extends StatefulWidget {
 final List data_revenus;
 const Revenuspage({ Key key,this.data_revenus}):super(key: key);
  @override
  _RevenuspageState createState() => _RevenuspageState();
}

class _RevenuspageState extends State<Revenuspage> {
  List revenus = [];
  @override
  void initState() {
    super.initState();
    recuperer_revenu();
  }
  @override
  Widget build(BuildContext context) {
    int nombre=revenus.length;
    return Scaffold(
        appBar: appbar_1("REVENUS ($nombre)", context,recuperer_revenu),
        body: Container(
          margin: EdgeInsets.only(top: 20, left: 10),
          child: Column(
            children: [revenu_view()],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => Formulairerevenuspage()));
         recuperer_revenu();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ));
  }
  recuperer_revenu() async{
    print("recuperer") ;
    SharedPreferences memoire= await SharedPreferences.getInstance();
    List<String> data = memoire.getStringList(REVENUS_KEY) ?? [] ;
    revenus = data;
    setState(() {});
  }

  ListView revenu_view() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: revenus.length,
        itemBuilder: (c, index) {
          String article = revenus[index];
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
                      data["article"],
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "(${data["quantite"]} pces)",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data["prix"]==""?"0": data["prix"],style: TextStyle(color: Colors.white),),
                      SizedBox(width: 8,),
                      Text("CDF",style: TextStyle(color: Colors.white),),
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

}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_stock/appbar.dart';
import 'package:gestion_stock/valeurs/constante.dart';
import 'package:shared_preferences/shared_preferences.dart';
import'formulairedepensespages.dart';

class Depensespage extends StatefulWidget {
  final List data_depenses;

  const Depensespage({ Key key,this.data_depenses}):super(key: key);
  @override
  _DepensespageState createState() => _DepensespageState();
}

class _DepensespageState extends State<Depensespage> {
  List depenses = [];
  int nombre2 =0;
  @override
  void initState() {
    super.initState();
    recuperer_depense();
  }
  @override
  Widget build(BuildContext context) {
    //int nombre=depenses.length;
    //print (nombre);
   // print (nombre2);
    return Scaffold(
        appBar: appbar_1("DEPENSES ($nombre2)", context,recuperer_depense),
        body: Container(
          margin: EdgeInsets.only(top: 20, left: 10),
          child: Column(
            children: [depense_view()],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print("Depenses avant mise à jour ${widget.data_depenses}");
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => Formulairedepensespage()));
            recuperer_depense();
            //print("Depenses après mise à jour ${widget.data_depenses}");
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ));
  }
 recuperer_depense() async{
    print("recuperer") ;
    SharedPreferences memoire= await SharedPreferences.getInstance();
    List<String> data = memoire.getStringList(DEPENSES_KEY) ?? [] ;
    depenses = data;
    nombre2=depenses.length;
    setState(() {});
  }

  ListView depense_view() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: depenses.length,
        itemBuilder: (c, index) {
          String article = depenses[index];
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

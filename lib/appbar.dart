import 'package:flutter/material.dart';
import 'package:gestion_stock/operationpage.dart';

appbar_view(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: Colors.black,
    centerTitle: false,
    actions: [

    ],
  );
}

appbar_1(String title,context,Function recuperer) {
  return AppBar(
    title: Text(title),
    backgroundColor: Colors.black,
    centerTitle: false,
    actions: [
      IconButton(
          icon: Icon(
            Icons.sync,
            color: Colors.white,
          ),
          onPressed: () {
            recuperer();
            //Navigator.of(context).push(MaterialPageRoute(
               // builder: (_) => OperationPage(
              //  )));
          })
    ],
  );
}

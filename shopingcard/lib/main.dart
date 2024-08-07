import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingcard/product.dart';
import 'package:badges/badges.dart';
import 'package:shopingcard/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=> provider(),
      child: Builder(builder:(BuildContext context){
        return MaterialApp(

          title: 'shoping card',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(

          ),
          home: product(),
        );
      }) ,
    );
  }
}



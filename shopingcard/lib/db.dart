import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io'as io;
import 'package:path/path.dart';
import 'package:shopingcard/cardmdel.dart';

class DB{
  static Database? _db;
 Future<Database?>  get  db async{

   if(_db != null){
     return _db!;
   }
   _db = await initDatabase();

 }
 initDatabase()async{
   io.Directory doucumentDirectory = await getApplicationCacheDirectory();
   String path = join( doucumentDirectory.path, 'cart.db');
   var db = await openDatabase(path,version: 1, onCreate:_oncreate,);
   return db;
 }
 _oncreate(Database db , int version)async{
   await db.execute(
     'CREATE TABLE cart (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,productname TEXT,initailprice INTEGER,productprice INTEGER,quantity INTEGER,unittag TEXT,image TEXT)'
   );

 }
 Future<Cart> insert (Cart cart) async{
   var dbClient =await db;

   await dbClient!.insert('cart', cart.toMap());
   return cart;
 }
 Future<List<Cart>> getCartList() async{

   var dbClient = await db;
   final List<Map<String,Object?>> queryresult = await dbClient!.query('cart');

   return queryresult.map((e)=> Cart.fromMap(e)).toList();
 }

 Future<int> delete(int id)async{
   var dbClient =await db;
   return await dbClient!.delete(
       'cart',
     where: 'id = ?',
     whereArgs: [id],
   );
 }

  Future<int> updateQ(Cart cart)async{
    var dbClient =await db;
    return await dbClient!.update(
      'cart',
      cart.toMap(),
      where: 'id = ?',
      whereArgs: [cart.id!]
    );
  }
}
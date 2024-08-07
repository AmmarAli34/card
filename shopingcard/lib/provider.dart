

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopingcard/cardmdel.dart';
import 'package:shopingcard/db.dart';

class  provider with ChangeNotifier{
  DB db =DB();
  int _counter = 0;
  int get counter => _counter;

  double _totalprice= 0.0;
  double get totalprice => _totalprice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart ;

  Future<List<Cart>> getdata()async{
    _cart =db.getCartList();
    return _cart;
  }

  void _setpreitem()async{
    SharedPreferences shrepre= await SharedPreferences.getInstance();
    shrepre.setInt('cart_item', _counter);
    shrepre.setDouble('total_price', _totalprice);
    notifyListeners();

  }
  void getpreitem()async{
    SharedPreferences shrepre =await SharedPreferences.getInstance();
    _counter=shrepre.getInt('cart_item')??0;
    _totalprice =shrepre.getDouble('total_price')??0.0;
    notifyListeners();

  }
  void addprice(double price){
    _totalprice =_totalprice + price;
    _setpreitem();
    notifyListeners();
  }
  void removetotalprice(double price){

   _totalprice =_totalprice -price;
    _setpreitem();
    notifyListeners();
  }
  double  getprice(){
    getpreitem();
    return _totalprice ;
  }


  void addcounter(){
    _counter++;
    _setpreitem();
    notifyListeners();
  }
  void remove(){
    _counter--;
    _setpreitem();
    notifyListeners();
  }
  int  getcounter(){
    getpreitem();
    return _counter ;
  }

}
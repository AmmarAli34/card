import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingcard/cardmdel.dart';
import 'package:shopingcard/cart.dart';
import 'package:shopingcard/db.dart';
import 'package:shopingcard/provider.dart';

 class product extends StatefulWidget {
   const product({Key?key}):super(key: key);

   @override
   State<product> createState() => _productState();
 }

 class _productState extends State<product> {
  DB? db = DB();
   List<String> productname =['Civic','Brio','City','Xli','Gli','Fortuner','Parado','Yaris','Elantra','Sonata'];
   List<String> productunit =['piece','piece','piece','piece','piece','piece','piece','piece','piece','piece'];
   List<int> productprice=[9899000,2360000,5849000, 238000,7549000,19899000,75550000,6319000,6930000,9979000];
   List<String> productimage=['images/civic.jpg','images/brio.jpg','images/city.jpg','images/xli.jpg','images/gli.jpg','images/fortuner.jpg','images/parado.jpg','images/yaris.jpg','images/elantra.jpg','images/sonata.jpg'];
   @override
   Widget build(BuildContext context) {
     final cart = Provider.of<provider>(context);
     return MaterialApp(
       home: Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.green,
           title: Text('product List'),
           centerTitle: true,
           actions: [
             InkWell(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> cartscreen()));
               },
               child: Center(
                 child: Badge(
                   label: Consumer<provider>(
                      builder:(context,value,child){
                   return Text(value.getcounter().toString(),style: TextStyle(color: Colors.white),);
                   } ,
                   ),

                           child:Icon(Icons.shopping_bag_outlined),
                 ),
               ),
             ),
            SizedBox(width: 50,)
           ],
              ),

         body:SafeArea(
           child: Column(
             children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: productname.length,
                          itemBuilder: (context,index){
                     return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image(
                                      height: 100,
                                      width: 100,
                                      image: AssetImage(productimage[index].toString()),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(productname[index].toString(),
                                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        SizedBox(height: 5,),
                                        Text(productunit[index].toString() +' '+' '+r'PKR'+productprice[index].toString(),
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                        SizedBox(height: 5,),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          
                                          child: InkWell(
                                            onTap: ()
                                            {
                                                db!.insert(
                                                  Cart(
                                                      id: index,
                                                      productId:index.toString(),
                                                      productname: productname[index].toString(),
                                                      initailprice: productprice[index],
                                                      productprice: productprice[index],
                                                      quantity: 1,
                                                      unittag: productunit[index].toString(),
                                                      image: productimage[index].toString()
                                                  )


                                                ).then((value){
                                                      print('successfully add');
                                                   cart.addprice(double.parse(productprice[index].toString()));
                                                   cart.addcounter();
                                                }).onError((error,stackTrace){

                                                  print(error.toString());
                                                }

                                                );

                                            },
                                            child: Container(
                                              width: 100,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Text('Add to card',style: TextStyle(fontSize: 16,color: Colors.white),),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),


                                ],
                              )
                            ],
                          ),
                        ),
                      );

                  }))
             ],
           ),
         ) ,
       ),
     );
   }
 }




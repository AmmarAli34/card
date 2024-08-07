import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingcard/db.dart';
import 'package:shopingcard/provider.dart';
import 'cardmdel.dart';

class cartscreen extends StatefulWidget {
  const cartscreen({Key? key}):super(key: key);

  @override
  State<cartscreen> createState() => _cartscreenState();
}

class _cartscreenState extends State<cartscreen> {
  DB? db =DB();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<provider>(context);
    return MaterialApp(
      home:Scaffold (
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('My products'),
          centerTitle: true,
          actions: [
            Center(
              child: Badge(
                label: Consumer<provider>(
                  builder:(context,value,child){
                    return Text(value.getcounter().toString(),style: TextStyle(color: Colors.white),);
                  } ,
                ),

                child:Icon(Icons.shopping_bag_outlined),
              ),
            ),
            SizedBox(width: 50,)
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              FutureBuilder(
                  future: cart.getdata(),
                  builder: (context, AsyncSnapshot<List<Cart>> snapshot){
                   if(snapshot.hasData  ){
                         return Expanded(
                       child: ListView.builder(
                           itemCount: snapshot.data!.length,
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
                                           image: AssetImage(snapshot.data![index].image.toString()),
                                         ),
                                         SizedBox(width: 10,),
                                         Expanded(
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Text(snapshot.data![index].productname.toString(),
                                                     style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                   InkWell(
                                                     onTap: (){
                                                       db!.delete(snapshot.data![index].id!);
                                                       cart.remove();
                                                       cart.removetotalprice(double.parse(snapshot.data![index].productprice.toString()));

                                                     },

                                                       child: Icon(Icons.delete)),
                                                 ],
                                               ),

                                               SizedBox(height: 5,),
                                               Text(snapshot.data![index].unittag.toString() +' '+' '+r'PKR '+snapshot.data![index].productprice.toString(),
                                                 style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                               SizedBox(height: 5,),
                                               Align(
                                                 alignment: Alignment.centerRight,

                                                 child: InkWell(
                                                   onTap: ()
                                                   {

                                                   },

                                                   child: Container(
                                                     width: 100,
                                                     height: 35,
                                                     decoration: BoxDecoration(
                                                       color: Colors.green,
                                                       borderRadius: BorderRadius.circular(5),
                                                     ),
                                                     child: Padding(
                                                       padding: const EdgeInsets.all(4.0),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           InkWell(
                                                               onTap: () {
                                                                 int q = snapshot.data![index].quantity!;
                                                                 int price= snapshot.data![index].initailprice!;
                                                                 q--;
                                                                 int newprice = price* q;
                                                                 db!.updateQ(
                                                                     Cart(
                                                                         id: snapshot.data![index].id!,
                                                                         productId:snapshot.data![index].id!.toString(),
                                                                         productname: snapshot.data![index].productname!,
                                                                         initailprice: snapshot.data![index].initailprice!,
                                                                         productprice: newprice,
                                                                         quantity: q,
                                                                         unittag: snapshot.data![index].unittag!.toString(),
                                                                         image: snapshot.data![index].image!.toString()
                                                                     )
                                                                 ).then((value){
                                                                   q=0;
                                                                   newprice=0;
                                                                   cart.removetotalprice(double.parse(snapshot.data![index].initailprice!.toString()));
                                                                 }).onError((error , stackTrace){
                                                                   print(error.toString());
                                                                 });

                                                               },


                                                               child: Icon(Icons.remove,color: Colors.white,)),
                                                           Center(
                                                             child: Text(snapshot.data![index].quantity!.toString(),style: TextStyle(fontSize: 16,color: Colors.white),),
                                                           ),
                                                           InkWell(
                                                               onTap: (){
                                                                 int q = snapshot.data![index].quantity!;
                                                                 int price= snapshot.data![index].initailprice!;
                                                                 q++;
                                                                 int newprice = price* q;
                                                                 db!.updateQ(
                                                                     Cart(
                                                                     id: snapshot.data![index].id!,
                                                                     productId:snapshot.data![index].id!.toString(),
                                                                     productname: snapshot.data![index].productname!,
                                                                     initailprice: snapshot.data![index].initailprice!,
                                                                     productprice: newprice,
                                                                     quantity: q,
                                                                     unittag: snapshot.data![index].unittag!.toString(),
                                                                     image: snapshot.data![index].image!.toString()
                                                                 )).then((value){
                                                                   q=0;
                                                                   newprice=0;
                                                                   cart.addprice(double.parse(snapshot.data![index].initailprice!.toString()));
                                                                 }).onError((error , stackTrace){
                                                                   print(error.toString());
                                                                 });
                                                               },
                                                               child: Icon(Icons.add,color: Colors.white,)),
                                                         ],
                                                       ),
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

                           }

                           ),
                   );
                 }else{
                     return Text('');
                   }
                  }),
              Consumer<provider>(builder: (context,value,child){
                return Visibility(
                  visible:value.getprice().toStringAsFixed(2) == '0.00' ? false :true ,
                  child: Column(
                    children: [
                      reuseable(title: 'Sub Total', value: r'PKR'+value.getprice().toStringAsFixed(2))
                    ],
                  ),
                );
              }
              )
            ],
          ),
        ),

      ),
    );
  }
}
class reuseable extends StatelessWidget {
  final String title,value;
  const reuseable({required this.title,required this.value});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
          Text(value.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
        ],
      ),
    );

  }
}
class Cart{
  late final int? id;
  final String? productId;
  final String? productname;
  final int? initailprice;
  final int? productprice;
  final int? quantity;
  final String? unittag;
  final String? image;

  Cart({
    required this.id,
    required this.productId,
    required this .productname,
    required this.initailprice,
    required this.productprice,
    required this.quantity,
    required this.unittag,
    required this.image,

});

  Cart.fromMap(Map<dynamic,dynamic> res ):
        id = res['id'],
        productId =res['productId'],
        productname= res['productname'],
        initailprice= res[' initailprice'],
        productprice= res['productprice'],
        quantity= res['quantity'],
        unittag= res['unittag'],
        image= res['image'];


  Map<String ,Object?> toMap(){
    return {
    'id': id,
    'productId': productId,
    'productname': productname,
  ' initailprice': initailprice,
    'productprice': productprice,
    'quantity': quantity,
    'unittag':unittag,
   'image':image,
    };

    }
  }


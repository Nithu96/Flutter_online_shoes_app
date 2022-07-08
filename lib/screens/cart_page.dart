import 'package:flutter/material.dart';
import 'package:sleekshoes/constants.dart';
import 'package:sleekshoes/models/product.dart';
import '../services/font_size.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String total = '';

  @override
  void initState() {
    if (listOfCart.isNotEmpty) {
      setTotal();
    }
  }

  void setTotal() {
    double totalVal = 0.0;
    for (var data in listOfCart) {
      totalVal = totalVal + double.parse(data.price![0]);
    }
    setState(() {
      total =
          'Total: ${totalVal.toStringAsFixed(2)} ${listOfCart[0].price![1]}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        leadingWidth: 60,
        backgroundColor: Color(0xFF00000A),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFFFFFFF), size: 20),
            onPressed: () {
              Navigator.pop(context);
            }),
        titleSpacing: 0.0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Cart Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizeService().fs_s18,
                  ),
                ),
              ]),
        ),
        elevation: 8,
        actions: [],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.75,
              color: Colors.white,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: listOfCart.isEmpty
                      ? const Center(
                          child: Text('No Products.'),
                        )
                      : ListView.builder(
                          itemCount: listOfCart.length,
                          itemBuilder: (BuildContext context, int index) {
                            return productCard(listOfCart[index], index);
                          },
                        )),
            ),
            listOfCart.isEmpty
                ? const SizedBox()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Color(0xFFEBEBEE),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          total,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizeService().fs_s18,
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              print('Button clicked!');
                            },
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xFF00000A),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Text(
                                'Checkout',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: FontSizeService().fs_s16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget productCard(Product product, int index) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Color(0xFFEBEBEE),
          elevation: 10,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        width: 150.0,
                        height: 150.0,
                        padding: EdgeInsets.all(8),
                        // Border width
                        //decoration: BoxDecoration(color: Color(0xFF00000A), borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                              size: Size.fromRadius(48), // Image radius
                              child: Image.network(product.mainImage!)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 180.0,
                        height: 150.0,
                        // color: Colors.red,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name!,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizeService().fs_s16,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Colour : ${product.colour!}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSizeService().fs_s12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${product.price![0]} ${product.price![1]}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSizeService().fs_s14,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      listOfCart.removeAt(index);
                                      setState(() {
                                        if (listOfCart.isNotEmpty) {
                                          setTotal();
                                        } else {
                                          total = 'Total: 0.00';
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
      onTap: () async {
        // await Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => HomePage(product: product)));
        setState(() {});
      },
    );
  }
}

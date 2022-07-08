import 'package:flutter/material.dart';
import 'package:sleekshoes/constants.dart';
import 'package:sleekshoes/models/product.dart';
import 'package:sleekshoes/screens/cart_page.dart';
import 'package:sleekshoes/screens/product_page.dart';
import 'package:sleekshoes/services/font_size.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        leadingWidth: 60,
        backgroundColor: Color(0xFF00000A),
        leading: IconButton(
            icon: Icon(Icons.menu, color: Color(0xFFFFFFFF), size: 20),
            onPressed: () {}),
        titleSpacing: 0.0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.shopping_cart,
                        color: listOfCart.isEmpty
                            ? Color(0xFFFFFFFF)
                            : Colors.amber,
                        size: 20),
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()));
                      setState(() {});
                    }),
                const SizedBox(
                  width: 8,
                ),
                listOfCart.isEmpty
                    ? SizedBox()
                    : Text('${listOfCart.length} items',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizeService().fs_s14,
                        ))
              ],
            ),
          ]),
        ),
        elevation: 10,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ListView.builder(
            itemCount: listOfData.length,
            itemBuilder: (BuildContext context, int index) {
              return productCard(listOfData[index]);
            },
          )),
    );
  }

  Widget productCard(Product product) {
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
                              child: Image.network(product.mainImage!)
                              //AssetImage("assets/testUser.png")
                              //Image.network('assets/splashlogo.png', fit: BoxFit.cover),
                              ),
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
                              height: 10,
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
                              height: 30,
                            ),
                            Text(
                              '${product.price![0]} ${product.price![1]}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizeService().fs_s14,
                              ),
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
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(product: product)));
        setState(() {});
      },
    );
  }
}

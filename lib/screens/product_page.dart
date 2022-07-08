import 'package:flutter/material.dart';
import 'package:sleekshoes/constants.dart';
import 'package:sleekshoes/models/product.dart';
import 'package:sleekshoes/services/request_service.dart';

import '../services/font_size.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key, required this.product}) : super(key: key);

  Product product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.more_horiz,
                          color: Color(0xFFFFFFFF), size: 20),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ]),
          ),
          elevation: 8,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.white,
                  child: Container(
                    child: ClipRRect(
                      //borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        widget.product.mainImage!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55,
                  color: Colors.white,
                  child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                        color: Color(0xFFF2F2F7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              child: Text(
                                widget.product.name!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontSizeService().fs_s20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 270),
                              child: Text(
                                widget.product.stockStatus!,
                                style: TextStyle(
                                  color: Color(0xFFa86432),
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSizeService().fs_s15,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Brand : ${widget.product.brandName!}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSizeService().fs_s15,
                                  ),
                                ),
                                Text(
                                  'SKU : ${widget.product.sku}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSizeService().fs_s15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${widget.product.price![0]} ${widget.product.price![1]}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSizeService().fs_s18,
                                  ),
                                ),
                                Text(
                                  'Colour : ${widget.product.colour!.toUpperCase()}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSizeService().fs_s15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 150,
                              child: Text(widget.product.description!,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSizeService().fs_s14,
                                    // letterSpacing: 3,
                                    //wordSpacing: 3,
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Size:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: FontSizeService().fs_s18,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: selectSize(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      listOfCart.add(widget.product);
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xFF00000A),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Add to the Cart  ',
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
                          ],
                        ),
                      )))
            ],
          ),
        ));
  }

  List<Widget> selectSize() {
    List<Widget> data = [];
    int index = 0;
    for (var d in widget.product.sizes!) {
      data.add(chipDesign(d, index.toString()));
      index++;
    }
    return data;
  }

  List<String> keyList = [];

  void selectChip(String key) {
    if (keyList.contains(key)) {
      keyList.remove(key);
    } else {
      keyList.clear();
      keyList.add(key);
    }
    setState(() {});
  }

  Widget chipDesign(String label, String key) {
    return Container(
      decoration: BoxDecoration(
        color: keyList.contains(key)
            ? const Color(0xFFF9D105)
            : const Color(0xFF00000A),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: InkWell(
        onTap: () {
          selectChip(key);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: keyList.contains(key) ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

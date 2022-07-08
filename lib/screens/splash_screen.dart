import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sleekshoes/constants.dart';
import 'package:sleekshoes/models/product.dart';
import 'package:sleekshoes/screens/home_page.dart';
import 'package:sleekshoes/services/font_size.dart';
import 'package:sleekshoes/services/request_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    getDataFromDatabase();
  }

  getDataFromDatabase() async {
    var data = await RequestService.getRequest(
        "https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json");

    if (data['success'] == false) {
      print('Error');
    } else {
      var dataOne = data['data'];
      for (Map data in dataOne) {
        Product product = Product.fromSnapShot(data);
        listOfData.add(product);
      }
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const HomePage(),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color(0xFF00000A)),
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/splashlogo.png',
                scale: 1,
              ),
              Text("Sleek Shoes",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      fontSize: FontSizeService().fs_s20)),
            ],
          ),
        ),
      ),
    );
  }
}

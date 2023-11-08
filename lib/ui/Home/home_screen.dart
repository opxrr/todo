import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
 static const String routeName = 'home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('TODO App',
        style: TextStyle(
          color: Colors.white
        ),),
      ),


    );
  }
}

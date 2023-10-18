import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context,String message){
    showDialog(context: context,
        builder: (buildContext){
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text(message)
          ],

        ),
      );
        },barrierDismissible: false
    );

  }
  static void hideDialog (BuildContext context){
    Navigator.pop(context);
  }
  static void showMeassage (BuildContext context,String message,
  {String? postActionName, String? negActionName}){
    List<Widget>actions=[];
    if(postActionName!=null){
    }
    showDialog(context: context,
        builder: (buildContext){
          return AlertDialog(
            content: Text(message),
            actions: actions,
          );
        }
    );

  }
}
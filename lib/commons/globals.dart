import 'dart:developer';

import 'package:flutter/material.dart';

import 'Theme.dart';

String API_ENDPOINT = "http://192.168.56.1:8000/api/";
//String TOKEN_ENDPOINT = "http://192.168.1.13/mark/public/sanctum/";

class GlobalData
{
  static String user_id = "";
}

Map<String, String> attachNVP(Map<String, String> n)
{
  n["user_id"] = GlobalData.user_id;
  return n;
}

Padding noItems(String msg)
{
  return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(5, 15, 5, 5),
      child: Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(5),
        height: 50,
        child: Center(child: Text(msg,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20))),
        decoration: BoxDecoration(
            color: Colors.redAccent.shade100,
            border: Border.all(color:Colors.pink,width: 1),
            borderRadius: BorderRadius.circular(10)
        ),
      )
  );
}


void showMessage(BuildContext context, String title, String txt) {
  txt = txt.replaceAll("\\n", "\n");
  showDialog(

    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.redAccent,
                radius: 20,
                child: Icon(Icons.info_outline, color: Colors.white, size: 40,),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,10,10),
                  child: Text(title)
              )
            ]
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(5,0,0,0),
                  child: Text(txt)
              )
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0,0,10,10),
              child: TextButton(
                child: Text('Ok'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.redAccent,
                  onSurface: Colors.grey,
                ),
                onPressed: () {

                },
              )
          )
        ],
      );
    },
  );
}

void showOverlay(BuildContext context, String txt)
{
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: NowUIColors.m_blue_5,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(15.0),
        ),
        backgroundColor: NowUIColors.socialFacebook,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 10.0),
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 20.0),
              child: Center(
                child: Text(txt,
                    style: TextStyle(
                        color: NowUIColors.white,
                        fontWeight: FontWeight.w200,
                        fontSize: 20)),
              ),
            ),
          ],
        ),
      );
    },
  );
}
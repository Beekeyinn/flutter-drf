import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

import '../../commons/Theme.dart';
import '../../commons/globals.dart';
import '../model.dart';
import 'bloc.dart';

class StudentList extends StatefulWidget{
  @override
  StudentListState createState() => StudentListState();
}

class StudentListState extends State<StudentList>
{
  late StudentBloc bloc;
  Map<String, String> k_val = {};
  late BuildContext t_context;
  List<dynamic> messages = [];

  @override
  void initState() {
    bloc = StudentBloc(this);
    super.initState();
  }

  void operationFinished(ListItemModel result)
  {
    Navigator.pop(t_context);
    screen_rendered = true;
    if(result.data[0]['students'].length > 0)
    {
      setState(() {
        messages = result.data[0]['students'];
        print("Data received");
        print(messages);
      });
    }

  }

  bool screen_rendered = false;
  void callbackOnBuild(BuildContext context)
  {
    print("running");
    if(!screen_rendered) {
      showOverlay(context, "Loading...");

      bloc.getAllStudents(k_val);
    }
  }

  @override
  Widget build(BuildContext context) {

    t_context = context;
   WidgetsBinding.instance?.addPostFrameCallback((_) => callbackOnBuild(context));


    return Scaffold(
        appBar: AppBar(
          backgroundColor: NowUIColors.m_appbar_bg,
          title: Text("All Students List"),
          leadingWidth: 30,
        ),
        //drawer: BjlDrawer(currentPage: "messages"),
        // extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: SafeArea(
              child: (screen_rendered && messages.length <= 0)?
              noItems("No Students")
                  :
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemCount: messages.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 0, left: 0, right: 0),
                        child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Text(messages[index]["first_name"])
                        )
                    );
                  }
              )
          ),
        )
    );
  }

}


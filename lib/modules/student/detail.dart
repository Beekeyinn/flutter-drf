import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_app/modules/model.dart';
import 'package:learn_app/modules/student/create.dart';
import 'package:learn_app/modules/student/list.dart';

import 'bloc.dart';

class StudentDetail extends StatefulWidget {
  final int id;

  const StudentDetail({Key? key, required this.id}) : super(key: key);

  @override
  StudentDetailState createState() => StudentDetailState();
}

class StudentDetailState extends State<StudentDetail> {
  late StudentDetailBloc bloc;
  bool loaded = false;
  Map<String, dynamic> students = {};

  @override
  void initState() {
    super.initState();
    bloc = StudentDetailBloc(this);
  }

  Future createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Delete Student",
              style: TextStyle(
                  color: Colors.red, fontSize: 24, fontWeight: FontWeight.w400),
            ),
            content: const Text(
              "Are you Sure?",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop("ok");
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  void deleteStudent(int id) async {
    bool deleted = await bloc.deleteStudent(id);
    if (deleted) {
      Navigator.pushReplacement<void, void>(context,
          MaterialPageRoute<void>(builder: (context) => const StudentList()));
    }
  }

  void redirectToEdit(dynamic student) async {
    Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => CreateStudent(
                      item: student,
                    )),
            (route) => true)
        .then((value) => setState(() => {loaded = false}));
  }

  void studentLoaded(List<dynamic> result) {
    if (result.isNotEmpty) {
      setState(() {
        students = result[0]['student'][0];
      });
      loaded = true;
    }
  }

  void onBuild() {
    if (!loaded) {
      bloc.getSingleStudent(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      onBuild();
    });
    return Scaffold(
        appBar: AppBar(
          title: Text("${students['first_name']} ${students['last_name']}"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => {Navigator.pop(context, true)},
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Card(
              elevation: 60,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                        width: double.infinity / 2,
                        height: 30,
                        child: Text(
                          "Full Name:",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          width: double.infinity / 2,
                          child: Text(
                            "${students['first_name']} ${students['last_name']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                        width: double.infinity / 2,
                        height: 30,
                        child: Text(
                          "Email Address:",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          width: double.infinity / 2,
                          child: Text(
                            students['email'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            createAlertDialog(context).then((value) {
                              if (value == "ok") {
                                deleteStudent(students['id']);
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              redirectToEdit(students);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            )),
                      ],
                    )
                  ])),
        ));
  }
}

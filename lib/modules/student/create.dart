import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/modules/model.dart';

import 'bloc.dart';

class CreateStudent extends StatefulWidget {
  final dynamic? item;

  const CreateStudent({Key? key, this.item}) : super(key: key);

  @override
  CreateStudentState createState() => CreateStudentState();
}

class CreateStudentState extends State<CreateStudent> {
  late CreateStudentBloc bloc;
  Map<String, String> keyVal = {};
  late BuildContext sContext;
  bool isEdit = false;

  final _firstNameTextControler = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = CreateStudentBloc(this);
    if (widget.item != null) {
      if (kDebugMode) {
        // print(widget.item);
      }
      _firstNameTextControler.text = widget.item!['first_name'];
      _lastNameTextController.text = widget.item!['last_name'];
      _emailTextController.text = widget.item!['email'];
      isEdit = true;
    }
  }

  void addStudent(Map<String, String> keyVal) {
    bloc.createStudent(keyVal);
  }

  void editStudent(Map<String, String> keyVal, int id) {
    bloc.editStudent(keyVal, id);
  }

  void studentCreated(ListItemModel item) {
    if (item.data[1]['success']) {
      if (isEdit) {
        Navigator.pop(context);
      }
      else{
        Navigator.pop(context);
      }
    } else {
      if (kDebugMode) {
        print(item.data[0].errors ?? "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    sContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Add Student" : "Edit Student"),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Card(
          elevation: 60,
          shadowColor: Colors.black38,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "First Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _firstNameTextControler,
                    decoration: const InputDecoration(
                      hintText: "Enter Student first name.",
                      border: OutlineInputBorder(),
                    ),
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Last Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _lastNameTextController,
                    decoration: const InputDecoration(
                      hintText: "Enter Student last name.",
                      border: OutlineInputBorder(),
                    ),
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Email Address",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _emailTextController,
                    decoration: const InputDecoration(
                      hintText: "Enter Student email address.",
                      border: OutlineInputBorder(),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          dynamic data = {
                            "first_name": _firstNameTextControler.text,
                            "last_name": _lastNameTextController.text,
                            "email": _emailTextController.text
                          };
                          if (isEdit) {
                            editStudent(data, widget.item['id']);
                          } else {
                            addStudent(data);
                          }
                        },
                        child: const Text("Submit"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(sContext);
                        },
                        child: const Text("cancel"),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

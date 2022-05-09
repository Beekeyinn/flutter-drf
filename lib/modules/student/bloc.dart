import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:learn_app/modules/student/create.dart';
import 'package:learn_app/modules/student/detail.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc.dart';
import '../model.dart';
import 'list.dart';

class StudentBloc extends AppBloc
{
  late StudentListState state;
  // CreateStudentState? stte;
  StudentBloc(StudentListState s)
  {
    state = s;
  }

  getAllStudents(Map<String, String> kval) async {
    ListItemModel itemModel = await repository().getStudents(kval);
    state.operationFinished(itemModel);
  }

}

class CreateStudentBloc extends AppBloc{
  late CreateStudentState state;
  CreateStudentBloc(CreateStudentState createStudentState){
    state = createStudentState;
  }

  void createStudent(Map<String,String> keyVal)async{
    ListItemModel res = await repository().createStudent(keyVal);
    print(res.data);
    state.studentCreated(res);
  }
  void editStudent(Map<String,String> keyVal, int id)async{
    ListItemModel res = await repository().editStudent(keyVal, id);
    state.studentCreated(res);
  }
}

class StudentDetailBloc extends AppBloc{
  late StudentDetailState state;
  StudentDetailBloc(StudentDetailState studentDetailState){
    state=studentDetailState;
  }

  void getSingleStudent(int id)async{
    ListItemModel item = await repository().getSingleStudent(id);
    state.studentLoaded(item.data);
  }
  Future<bool> deleteStudent(int id)async{
    bool deleted = await repository().deleteStudent(id);
    return deleted;
  }
}
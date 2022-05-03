import 'dart:async';
import 'provider.dart';
import 'model.dart';

//This Repository class is the central point from where the data will flow to the BLOC

class Repository {
  final apiProvider = ApiProvider();

  Future<ListItemModel> getStudents(Map<String, String> key_val) => apiProvider.doPost("students", key_val);
  Future<ListItemModel> addStudent(Map<String, String> key_val) => apiProvider.doPost("student/insert", key_val);

}

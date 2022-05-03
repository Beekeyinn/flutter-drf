import 'package:rxdart/rxdart.dart';

import '../bloc.dart';
import '../model.dart';
import 'list.dart';

class StudentBloc extends AppBloc
{
  late StudentListState state;
  StudentBloc(StudentListState s)
  {
    state = s;
  }

  getAllStudents(Map<String, String> kval) async {
    ListItemModel itemModel = await repository().getStudents(kval);
    print(itemModel);
    state.operationFinished(itemModel);
  }

}
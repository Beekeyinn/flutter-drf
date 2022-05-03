import 'repository.dart';
import 'package:rxdart/rxdart.dart';
import 'model.dart';

class AppBloc {

  final _repository = Repository();
  final _fetcher = PublishSubject<ListItemModel>();
  // Observable<ListItemModel> get allData => _fetcher.stream;

  Repository repository()
  {
    return _repository;
  }

  PublishSubject<ListItemModel> fetcher()
  {
    return _fetcher;
  }

  dispose() {
    _fetcher.close();
  }
}
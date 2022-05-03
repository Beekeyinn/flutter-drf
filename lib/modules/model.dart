class ListItemModel {
  dynamic _data = [];

  ListItemModel();

  ListItemModel.fromJson(dynamic parsedJson) {
    _data = parsedJson;
  }
  List get data => _data;
}
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' show Client;
import '../commons/globals.dart';
import 'package:http/http.dart' as http;
import '../commons/globals.dart' as globals;
import 'model.dart';

class ApiProvider {
  Client client = Client();

  void printRequestUrl(String urlx, Map<String, String> key_val) {
    urlx = urlx.replaceAll("http:", "");
    Uri outgoingUri = Uri(scheme: "http", path: urlx, queryParameters: key_val);
    urlx = outgoingUri.toString().replaceAll("////", "//");
    print(urlx);
  }

  String makeRequestURL(String uri) {
    return globals.API_ENDPOINT + uri;
  }

  bool checkForFiles(Map<String, String> key_val) {
    bool file_present = false;
    for (var v in key_val.keys) {
      (v.contains("FILE_")) ? file_present = true : '';
    }
    return file_present;
  }

  Future<ListItemModel> doGet(String uri, {String? id}) async {
    if (id != null) {
      uri = uri + "$id/";
    }
    String urlx = makeRequestURL(uri);
    // returns globals.API_ENDPOINTS+uri
    var response = await client.get(Uri.parse(urlx), headers: <String, String>{
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return ListItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to fetch data");
    }
  }

  Future<ListItemModel> doPost(String uri, Map<String, String> key_val) async {
    key_val = attachNVP(key_val);
    String urlx = makeRequestURL(uri);
    printRequestUrl(urlx, key_val);

    var response;

    if (checkForFiles(key_val)) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(urlx),
      );
      Map<String, String> headers = {"Content-type": "multipart/form-data"};

      String field_name = "";
      for (var v in key_val.keys) {
        if (v.contains("FILE_")) {
          File file;
          file = File(key_val[v].toString());

          field_name = v.replaceAll("FILE_", "");

          String filename = field_name +
              "_" +
              DateTime.now().toString() +
              "_" +
              p.extension(key_val[v].toString());

          request.files.add(
            http.MultipartFile(
              field_name,
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: filename,
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        }
      }

      request.headers.addAll(headers);
      request.fields.addAll(key_val);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      response = await client.post(
        Uri.parse(urlx),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(key_val),
      );
    }

    if (response.statusCode == 200) {
      return ListItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed fetching from server');
    }
  }

  Future<ListItemModel> createStudent(
      String uri, Map<String, dynamic> keyVal) async {
    // final queryParams =
    //     "first_name=${keyVal['first_name']}&last_name=${keyVal['last_name']}&email=${keyVal['email']}";
    // String urlx = uri + "?" + queryParams;
    String hitPoint = makeRequestURL(uri);

    // var response = await client.get(
    //   Uri.parse(hitPoint),
    //   headers: <String, String>{"Content-Type": "application/json"},
    // );

    var response = await client.post(Uri.parse(hitPoint),
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(keyVal));

    if (response.statusCode == 201) {
      var json = jsonDecode(response.body);
      return ListItemModel.fromJson(json);
    } else {
      throw Exception("Failed to create");
    }
  }

  Future<ListItemModel> editStudent(
      String uri, Map<String, String> keyVal, String id) async {
    String urlx = uri + "$id/";

    String hitPoint = makeRequestURL(urlx);
    var response = await client.put(Uri.parse(hitPoint),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonEncode(keyVal));
    if (response.statusCode == 200) {
      return ListItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to update");
    }
  }

  Future<bool> deleteStudent(String uri, String id) async {
    String urlx = "$uri$id/";
    String hitPoint = makeRequestURL(urlx);
    var response = await client.delete(Uri.parse(hitPoint),
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete student");
    }
  }
}

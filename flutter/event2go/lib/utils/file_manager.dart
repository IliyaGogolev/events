import 'package:event2go/data/event.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class FileManager {
//  Client client = Client();
//  fetchPosts() async {
//    final response = await client.get("https://jsonplaceholder.typicode.com/posts/1");
//    ItemModel itemModel = ItemModel.fromJson(json.decode(response.body));
//    return itemModel;
//  }

  Future<String> loadFile(String fileName) async {
    return await rootBundle.loadString(fileName);
  }

//  Future<String> loadAsset(BuildContext context) async {
//    return await DefaultAssetBundle.of(context).loadString('assets/my_text.txt');
//  }
}
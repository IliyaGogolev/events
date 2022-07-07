import 'package:event2go/data/event.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class ApiProvider {
//  Client client = Client();
//  fetchPosts() async {
//    final response = await client.get("https://jsonplaceholder.typicode.com/posts/1");
//    ItemModel itemModel = ItemModel.fromJson(json.decode(response.body));
//    return itemModel;
//  }

  getEvents() async {
    var jsonString = await _loadEventsFile();
//    Map eventMap = jsonDecode(jsonString)
//    return Event.fromJson(eventMap);
    var  eventsJson = jsonDecode(jsonString)['events'] as List;
    return eventsJson.map((eventMap) => Event.fromJson(eventMap)).toList();
  }

  Future<String> _loadEventsFile() async {
    return await rootBundle.loadString('assets/events.json');
  }

//  Future<String> loadAsset(BuildContext context) async {
//    return await DefaultAssetBundle.of(context).loadString('assets/my_text.txt');
//  }
}
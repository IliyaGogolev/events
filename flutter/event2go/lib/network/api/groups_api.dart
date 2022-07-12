import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../dio_client.dart';
import '../endpoints.dart';
import '../raw_models/contact.dart';

class GroupsApi {
  NetworkClient dioClient;

  GroupsApi ({@required this.dioClient}):assert(dioClient != null);

  Future<Response> add(String title, List<Contact> contacts) async {
    try {
      final Response response = await dioClient.dio.post(
        Endpoints.groups,
        data: {
          'title': title,
          'contacts' : contacts.map((e) => e.toJson()).toList()
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> groups() async {
    try {
      final Response response = await dioClient.dio.get(Endpoints.groups);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> update(int groupId, String title, List<Contact> contacts) async {
    try {
      final Response response = await dioClient.dio.put(
        Endpoints.groups + '/$groupId',
        data: {
          'title': title,
          'contacts' : contacts.map((e) => e.toJson()).toList()
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(int groupId) async {
    try {
      await dioClient.dio.delete(Endpoints.groups + '/$groupId');
    } catch (e) {
      rethrow;
    }
  }
}
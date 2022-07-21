import 'package:dio/dio.dart';
import 'package:event2go/network/dio_exception.dart';
import 'package:event2go/network/network_exception.dart';
import 'package:flutter/material.dart';

import '../network_client.dart';
import '../endpoints.dart';
import '../raw_models/contact.dart';

class GroupsService {
  NetworkClient networkClient;

  GroupsService ({@required this.networkClient}):assert(networkClient != null);

  Future<Response> add(String title, List<Contact> contacts) async {
    try {
      final Response response = await networkClient.dio.post(
        Endpoints.group,
        data: {
          'title': title,
          'contacts' : contacts.map((e) => e.toJson()).toList()
        },
      );
      return response;
    } catch (e) {

      // rethrow;
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw NetworkException(e.toString());
      throw NetworkException(errorMessage);
    }
  }

  Future<Response> groups() async {
    try {
      final Response response = await networkClient.dio.get(Endpoints.groups);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> update(int groupId, String title, List<Contact> contacts) async {
    try {
      final Response response = await networkClient.dio.put(
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
      await networkClient.dio.delete(Endpoints.groups + '/$groupId');
    } catch (e) {
      rethrow;
    }
  }
}
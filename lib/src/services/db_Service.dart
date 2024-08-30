// lib/services/user_service.dart
import 'dart:convert';

import 'package:assignment_second/src/modules/home/model/Home_model.dart';
import 'package:assignment_second/src/modules/verbersuggesties/model/verber_model.dart';
import 'package:assignment_second/src/overrides.dart';
import 'package:http/http.dart' as http;

class DbService {
  Future<VerberModel> fetchUsersList(String url) async {
    final response = await http.get(Uri.parse("${Overrides.API_BASE_URL}$url"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return VerberModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<HomeModel> fetchUsers(String url) async {
    final response = await http.get(Uri.parse("${Overrides.API_BASE_URL}$url"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return HomeModel.fromJson(data);
    } else {
      throw Exception('Failed to load users');
    }
  }
}

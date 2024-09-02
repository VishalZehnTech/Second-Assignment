import 'dart:convert';

import 'package:assignment_second/src/overrides.dart';
import 'package:assignment_second/src/services/db_service_response_model.dart';
import 'package:http/http.dart' as http;

class DbService {
  Future<ResponseModel> getApi(String url) async {
    try {
      final response =
          await http.get(Uri.parse("${Overrides.API_BASE_URL}$url"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: data);
      } else {
        return ResponseModel(statusCode: response.statusCode, data: null);
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      return const ResponseModel(
          statusCode: 500, data: null); // Example status code for error
    }
  }

  Future<ResponseModel> postApi(String url,
      {Map<String, dynamic>? mapData}) async {
    try {
      final response = await http.post(
        Uri.parse("${Overrides.API_BASE_URL}$url"),
        headers: {
          "Content-Type": "application/json"
        }, // Ensure correct headers for JSON
        body: json.encode(mapData), // Encode mapData as JSON
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: data);
      } else {
        return ResponseModel(statusCode: response.statusCode, data: null);
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      return const ResponseModel(
          statusCode: 500, data: null); // Example status code for error
    }
  }
}

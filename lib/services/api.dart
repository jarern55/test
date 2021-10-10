import 'dart:convert';

import 'package:flutter_food/models/api_result.dart';
import 'package:http/http.dart' as http;

class Api {
  static const BASE_URL = 'https://cpsu-test-api.herokuapp.com';

  Future<dynamic> submit(String endPoint, Map<String, dynamic> params) async {
    var url = Uri.parse('$BASE_URL/$endPoint');
    final response = await http.post(url, body: params);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);

      print('RESPONSE BODY: $jsonBody');

      var result = ApiResult.fromJson(jsonBody);

      print('STATUS: ${result.status}');

      if (result.status == 'ok') {
        return result.data;
      } else {
        throw Exception(result.message);
      }

      /*print(jsonBody['status']);
      print(jsonBody['data']);
      if (jsonBody['status'] == 'ok') {
        return jsonBody['data'];
      } else {
        throw Exception(jsonBody['message']);
      }*/
    } else {
      throw Exception('Server connection failed!');
    }
  }

  Future<dynamic> fetch(String endPoint) async {
    var url = Uri.parse('$BASE_URL/$endPoint');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);

      var result = ApiResult.fromJson(jsonBody);

      print('STATUS: ${result.status}');

      if (result.status == 'ok') {
        return result.data;
      } else {
        throw Exception(result.message);
      }

      /*print(jsonBody['status']);
      print(jsonBody['data']);
      if (jsonBody['status'] == 'ok') {
        return jsonBody['data'];
      } else {
        throw Exception(jsonBody['message']);
      }*/
    } else {
      throw Exception('Server connection failed!');
    }
  }
}
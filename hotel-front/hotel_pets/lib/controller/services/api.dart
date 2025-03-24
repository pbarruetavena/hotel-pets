import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Api {
  final String baseUrl = "http://localhost:3000/";

  Future<http.Response> getRequest(String endUrl) async {
    return await http.get(Uri.parse(baseUrl + endUrl));
  }

  Future<http.Response> postRequest(
      String endUrl, Map<String, dynamic> body) async {
    print(body);
    print(jsonEncode(body));
    return await http.post(
      Uri.parse(baseUrl + endUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
  }
}

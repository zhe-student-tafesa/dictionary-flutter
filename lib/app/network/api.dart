import 'dart:convert';
import 'package:dictionary_flutter/app/models/response_model.dart';
import 'package:http/http.dart' as http;

class API {
  static const String baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/";

  static Future<DictionaryResponseModel> fetchMeaning(String word) async {
    final response = await http.get(Uri.parse("$baseUrl$word"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DictionaryResponseModel.fromJson(data[0]);
    } else {
      throw Exception("failed to load meaning");
    }
  }
}

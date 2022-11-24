import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:master_neo/model/neo.dart';

class ApiCalls {
  static const API_FETCH_ALL_URL =
      'https://api.nasa.gov/neo/rest/v1/neo/browse';

  static final API_KEY = dotenv.env['API_KEY'];

  static Future<List<NEO>> fetchAll() async {
    List<NEO> result = List.empty(growable: true);
    final uri = Uri.parse('${API_FETCH_ALL_URL}?api_key=${API_KEY}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> globalJson = jsonDecode(response.body);
      List<dynamic> nearEarthObjectList = globalJson['near_earth_objects'];

      nearEarthObjectList.forEach((element) {
        result.add(NEO.fromJson(element));
      });

      return result;
    } else {
      throw Exception('Failed to fetch');
    }
  }
}

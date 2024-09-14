import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> getPrediction(String city) async {
    final url = Uri.parse('$baseUrl/predict?city=$city');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load prediction');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
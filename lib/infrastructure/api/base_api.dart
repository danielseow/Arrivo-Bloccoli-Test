import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseAPI {
  final String _baseUrl;

  BaseAPI(this._baseUrl);

  Future<dynamic> get(String path) async {
    final url = Uri.parse('$_baseUrl$path');
    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    return _handleResponse(response);
  }

  Future<dynamic> post(String path, {required dynamic body}) async {
    final url = Uri.parse('$_baseUrl$path');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('API error: ${response.statusCode} - ${response.body}');
    }
  }
}

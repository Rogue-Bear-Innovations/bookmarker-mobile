import 'dart:convert';

import 'package:http/http.dart' as http;

class Bookmark {
  int id;
  String? name;
  String? description;
  String? link;

  Bookmark({required this.id, this.name, this.description, this.link});

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'] as int,
      name: json['name'] as String?,
      description: json['description'] as String?,
      link: json['link'] as String?,
    );
  }
}

class API {
  Future<String> register(String email, String password) async {
    var url = Uri.parse('http://localhost:1323/auth/register');
    var response = await http.post(url,
        body: jsonEncode(<String, String>{'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (!isSuccess(response.statusCode) || isError(response.statusCode)) {
      throw Exception('got bad status code ${response.statusCode}');
    }

    Map<String, dynamic> data = jsonDecode(response.body);
    final String token = data['token']!;
    if (token == '') {
      throw Exception('no token presented');
    }

    return token;
  }
}

bool isSuccess(int code) {
  return code > 199 && code < 300;
}

bool isError(int code) {
  return code > 399;
}

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Girl3Service {
  final String _endpoint =
      dotenv.env['API_ENDPOINT'] ?? "http://127.0.0.1:8000/";
  Future<String> sendMessage(String message) async {
    final uri = Uri.parse('$_endpoint/girl3/');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );

    if (response.statusCode == 429) {
      throw Exception('リクエストが多すぎます。しばらく待ってから再度試してください。');
    } else if (response.statusCode != 200) {
      throw Exception('メッセージの送信に失敗しました。');
    }

    final responseData = jsonDecode(response.body);
    return responseData['response']; // レスポンスメッセージを返す
  }
}

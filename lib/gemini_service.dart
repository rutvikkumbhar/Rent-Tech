import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey = "AIzaSyABm49EraZbEpg9EsxXiey06r9pWRzV2Zs";

  Future<String> getResponse(String userMessage) async {
    final String url = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$apiKey";

    final response = await http.post(
      Uri.parse(url),

      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {"parts": [{"text": userMessage}]}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData["candidates"][0]["content"]["parts"][0]["text"];
    } else {
      return "Error: ${response.statusCode} - ${response.body}";
    }
  }
}

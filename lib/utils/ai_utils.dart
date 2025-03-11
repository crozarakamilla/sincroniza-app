import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> structureTextWithAI(
    String unstructuredText) async {
  List<Map<String, dynamic>> finalMap = [];
  const apiKey = '';
  final response = await http.post(
    Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "contents": [
        {
          "parts": [
            {
              "text":
                  "Organize the following text: \n$unstructuredText\n\n Extract structured information from this and return a list of maps, please, don't include any code formatting, I just want a pure list. This is the text structure: data, título, subtítulo (optional), obras executadas, solista (optional), maestro, local, horário"
            }
          ]
        }
      ]
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final String aiResponse =
        jsonResponse['candidates'][0]['content']['parts'][0]['text'];

    try {
      return List<Map<String, dynamic>>.from(jsonDecode(aiResponse));
    } catch (e) {
      throw Exception("AI response was not valid JSON: $aiResponse");
    }

    //final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    //final String structuredText =
    //    jsonResponse['choices'][0]['message']['content'];
    //return jsonDecode(structuredText);
  } else {
    return finalMap;
  }
}

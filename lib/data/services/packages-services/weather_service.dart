// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class WeatherService {
//   Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
//     final url =
//         'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true';

//     final res = await http.get(Uri.parse(url));

// ignore_for_file: prefer_single_quotes

//     if (res.statusCode == 200) {
//       return jsonDecode(res.body)['current_weather'];
//     } else {
//       throw Exception('Weather fetch failed');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherService {
  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final url =
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&hourly=precipitation,uv_index&daily=sunrise,sunset&timezone=auto';

    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      return {
        'temp': data['current_weather']['temperature'],
        'windspeed': data['current_weather']['windspeed'],
        'weathercode': data['current_weather']['weathercode'],
        'precipitation': data['hourly']['precipitation'][0],
        'uv_index': data['hourly']['uv_index'][0],
        // Format the strings right here in the service
        'sunrise': _formatTime(data['daily']['sunrise'][0]),
        'sunset': _formatTime(data['daily']['sunset'][0]),
      };
    } else {
      throw Exception('Weather fetch failed');
    }
  }

  // Helper to convert "2026-01-24T07:15" -> "7:15 AM"
  String _formatTime(String isoTime) {
    try {
      final DateTime parsedDate = DateTime.parse(isoTime);
      return DateFormat('h:mm a').format(parsedDate);
    } catch (e) {
      return "--:--";
    }
  }
}

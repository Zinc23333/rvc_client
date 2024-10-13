import 'dart:convert';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/http.dart' as http;

const server = "http://127.0.0.1:8010";
// const server = "http://192.168.43.9:8010";

class LiveTalking {
  static Future<Map<String, dynamic>?> offer(RTCSessionDescription description) async {
    final r = await http.post(
      Uri.parse("$server/offer"),
      body: json.encode(
        {
          "type": description.type,
          "sdp": description.sdp,
        },
      ),
    );
    print("=====================");
    print(r.body);
    if (r.statusCode == 200) {
      print("=====================");
      final data = json.decode(r.body);
      return data;
    }
    return null;
  }
}

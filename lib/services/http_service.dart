import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';

final _backendURL = kDebugMode
    ? defaultTargetPlatform == TargetPlatform.android
          ? "http://192.168.1.2:4000"
          : "http://localhost:4000"
    : "https://toeatonodejs.onrender.com";

@immutable
class HttpService {
  const HttpService();

  // 🔹 create user
  Future<Map<String, dynamic>> createUser({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    return _callAPI('auth/register', {
      Fields.name: name,
      Fields.phone: phone,
      Fields.email: email,
      Fields.password: password,
    });
  }

  // 🔹 request otp
  Future<Map<String, dynamic>> requestOTP(String phone) async {
    return _callAPI('otp/request', {Fields.phone: phone});
  }

  // 🔹 verify otp
  Future<Map<String, dynamic>> verifyOTP({
    required String phone,
    required String otp,
  }) async {
    return _callAPI('otp/verify', {Fields.phone: phone, 'otp': otp});
  }

  // 🔹 get generated token
  Future<Map<String, dynamic>> getAuthToken(String phone) async {
    return _callAPI('auth/generate-token', {Fields.phone: phone});
  }
}

Future<Map<String, dynamic>> _callAPI(
  String endPoint,
  Map<String, dynamic> body,
) async {
  try {
    final url = Uri.parse('$_backendURL/$endPoint');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    if (response.statusCode != 200) {
      throw response.errorMessage;
    }
    return json.decode(response.body);
  } catch (e) {
    throw e.firebaseErrorMessage;
  }
}

final httpServiceProvider = Provider<HttpService>((_) => HttpService());

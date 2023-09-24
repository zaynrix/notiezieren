import 'package:dio/dio.dart';

class HttpAuth {
  final Dio _client;

  HttpAuth({required Dio client}) : _client = client;

  // ---------- Get Data ----------

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    _client.options.headers = {
      'Content-Type': 'application/json',
    };
    return _client.get(url, queryParameters: query);
  }

  // ---------- Post Data ----------

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) {
    _client.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };

    return _client.post(url, queryParameters: query, data: data);
  }

  // ---------- Update Data ----------

  Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) {
    _client.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };

    return _client.put(url, queryParameters: query, data: data);
  }

  // ---------- Delete Data ----------

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) {
    _client.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return _client.delete(url, queryParameters: query);
  }
}

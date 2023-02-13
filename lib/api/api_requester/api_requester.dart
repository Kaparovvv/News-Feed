import 'package:dio/dio.dart';

class ApiRequester {
  static const String url = 'https://megalab.pythonanywhere.com/';

  Future<Dio> initDio() async {
    return Dio(
      BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
        receiveTimeout: 30000,
        headers: {
          "Authorization": 'Token b82c75723323e4656c38b1cb4659cefa2273b9cb'
        },
        connectTimeout: 30000,
      ),
    );
  }

  Future<Response> toGet(
    String url, {
    Map<String, dynamic>? queryParam,
  }) async {
    Dio dio = await initDio();
    try {
      return dio.get(url, queryParameters: queryParam);
    } catch (e) {
      throw Exception(e);
    }
  }
}

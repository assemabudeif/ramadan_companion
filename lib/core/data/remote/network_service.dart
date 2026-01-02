import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_service.g.dart';

@Riverpod(keepAlive: true)
NetworkService networkService(NetworkServiceRef ref) {
  return NetworkService();
}

class NetworkService {
  final Dio _dio;

  NetworkService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.aladhan.com/v1', // Example API for Prayer Times
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  Future<Map<String, dynamic>> getPrayerTimes({
    required double lat,
    required double long,
    required int method,
  }) async {
    try {
      final response = await _dio.get(
        '/timings',
        queryParameters: {'latitude': lat, 'longitude': long, 'method': method},
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

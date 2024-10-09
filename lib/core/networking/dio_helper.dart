import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';

class DioHelper {
  static late Dio dio;
  static late CacheOptions cacheOptions;

  DioHelper();

  static Future<void> initializeCache() async {
    dio = Dio();

    final dir = await getApplicationDocumentsDirectory();
    cacheOptions = CacheOptions(
      store: HiveCacheStore(dir.path),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 1),
    );

    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  Future<Response> getData(String url) async {
    dio = Dio();

    try {
      Response response = await dio.get(
        url,
        options: cacheOptions.toOptions(),
      );
      return response;
    } on DioException catch (e) {
      throw e;
    }
  }
}

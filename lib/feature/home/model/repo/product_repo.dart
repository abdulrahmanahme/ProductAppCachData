import 'package:dartz/dartz.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:product_app/core/networking/dio_helper.dart';
import 'package:product_app/feature/home/model/product_model.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProductRepo {
  ProductRepo(
    this.dioHelper,
  );
  DioHelper? dioHelper;

  static const CACHED_Products = "CACHED_Products";
 static late CacheOptions cacheOptions;
  Future<List<ProductModel>> fetchServerProductList() async {
    final res = await dioHelper!.getData('https://fakestoreapi.com/products/',);
    try {
      if (res.statusCode == 200) {
        return (res.data as List<dynamic>)
            .map(
              (data) => ProductModel.fromJson(data),
            )
            .toList();
      } else {
        throw Exception('There an error');
      }
    } catch (error) {
      throw Exception('There was an error: $error');
    }
  }

  Future<Unit> saveProducts(List<ProductModel> productModels) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    List productModelsToJson = productModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(
        CACHED_Products, json.encode(productModelsToJson));
    return Future.value(unit);
  }

  Future<List<ProductModel>> fetchAllLocalProducts() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final jsonString = sharedPreferences.getString(CACHED_Products);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<ProductModel> jsonToProductModels = decodeJsonData
          .map<ProductModel>((jsonToProductModels) =>
              ProductModel.fromJson(jsonToProductModels))
          .toList();
      return Future.value(jsonToProductModels);
    } else {
      throw Exception();
    }
  }

  static Future<void> initializeCache() async {
    final dir = await getApplicationDocumentsDirectory();
    cacheOptions = CacheOptions(
      store: HiveCacheStore(dir.path),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 7),
    );

  }

}

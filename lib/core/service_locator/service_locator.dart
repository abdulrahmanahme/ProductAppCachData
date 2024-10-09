import 'package:get_it/get_it.dart';
import 'package:product_app/core/networking/dio_helper.dart';
import 'package:product_app/feature/home/model/repo/product_repo.dart';
import 'package:product_app/feature/logic/cubit/product_cubit.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void setup() async {
    /// Register DioHelper singleton
    getIt.registerLazySingleton<DioHelper>(() => DioHelper());
    getIt.registerLazySingleton<ProductRepo>(
        () => ProductRepo(getIt<DioHelper>()));
    getIt.registerFactory<ProductsCubit>(() => ProductsCubit());
  }
}

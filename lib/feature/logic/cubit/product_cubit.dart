import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_app/core/service_locator/service_locator.dart';
import 'package:product_app/feature/home/model/repo/product_repo.dart';
import 'package:product_app/feature/logic/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProductsCubit extends Cubit<ProductState> {
  ProductsCubit() : super(InitialProductState());
  var  productRepo=getIt<ProductRepo>();
  double? priceRealTime;
  StreamSubscription<DocumentSnapshot>? priceSubscription;
  Future<void> fetchAllProducts() async {
    emit(LoadingProductState());
    try {
      bool hasConnection = await InternetConnectionChecker().hasConnection;

      if (hasConnection) {
        // / Fetch products list from server
        final res = await productRepo.fetchServerProductList();

        /// Save products list
        await productRepo.saveProducts(res);

        /// Feted saved products
        var fetchAllProductList = await productRepo.fetchAllLocalProducts();

        emit(SuccessProductState(fetchAllProductList,priceRealTime.toString()));
      } else {
        final fetchAllProductList = await productRepo.fetchAllLocalProducts();
        emit(SuccessProductState(fetchAllProductList,priceRealTime.toString()));
      }
    } catch (error) {
      emit(ErrorProductState(error.toString()));
    }
  }


  void cancelLister() {
    priceSubscription!.cancel();
  }
}

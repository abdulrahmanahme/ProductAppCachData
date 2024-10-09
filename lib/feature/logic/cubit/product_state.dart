import 'package:product_app/feature/home/model/product_model.dart';

abstract class ProductState {}

class InitialProductState extends ProductState {}

/// Home States
class LoadingProductState extends ProductState {}

class SuccessProductState extends ProductState {
  SuccessProductState(this.listProductModel ,this.price);
  List<ProductModel> listProductModel;
  String price;
}

class ErrorProductState extends ProductState {
  ErrorProductState(this.error);
  String error;
}


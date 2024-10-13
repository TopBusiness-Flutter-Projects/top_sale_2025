import '../../../core/models/all_products_model.dart';
import '../../../core/models/category_model.dart';

abstract class DirectSellState {}

class DirectSellInitial extends DirectSellState {}

class ChangeIndexState extends DirectSellState {}
class LoadingCatogries extends DirectSellState {}
class ErrorCatogriesextends extends DirectSellState {}
class LoadedCatogries extends DirectSellState {
   GetCategoriesModel ?catogriesModel;
  LoadedCatogries({required this.catogriesModel});
}
//product
class LoadingProduct extends DirectSellState {}
class ErrorProduct extends DirectSellState {}
class LoadedProduct extends DirectSellState {
   AllProductsModel ?allProductmodel;
  LoadedProduct({required this.allProductmodel});
}

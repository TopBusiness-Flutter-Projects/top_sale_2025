import '../../../core/models/all_products_model.dart';
import '../../../core/models/category_model.dart';

abstract class DirectSellState {}

class DirectSellInitial extends DirectSellState {}

class ChangeIndexState extends DirectSellState {}

class LoadingCatogries extends DirectSellState {}

class ErrorCatogriesextends extends DirectSellState {}

class LoadedCatogries extends DirectSellState {
  CategoriesModel? catogriesModel;
  LoadedCatogries({required this.catogriesModel});
}

//product
class LoadingProduct extends DirectSellState {}

class Loading2Product extends DirectSellState {}

class ErrorProduct extends DirectSellState {}

class LoadedProduct extends DirectSellState {
  AllProductsModel? allProductmodel;
  LoadedProduct({required this.allProductmodel});
}

class LoadingTheQuantityCount extends DirectSellState {}

class IncreaseTheQuantityCount extends DirectSellState {}

class DecreaseTheQuantityCount extends DirectSellState {}

//product by catgorey
class LoadingProductByCatogrey extends DirectSellState {}

class ErrorProductByCatogrey extends DirectSellState {}

class LoadedProductByCatogrey extends DirectSellState {
  AllProductsModel? allProductmodel;
  LoadedProductByCatogrey({required this.allProductmodel});
}

class LoadingCreateQuotation extends DirectSellState {}

class LoadedCreateQuotation extends DirectSellState {}

class ErrorCreateQuotation extends DirectSellState {}

class OnChangeCountOfProducts extends DirectSellState {}

class OnChangeUnitPriceOfItem extends DirectSellState {}

class OnDeleteItemFromBasket extends DirectSellState {}

class OnChangeAllUnitPriceOfItem extends DirectSellState {}
class ClearSearchText extends DirectSellState {}

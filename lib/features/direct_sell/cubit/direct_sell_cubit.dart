import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/config/routes/app_routes.dart';
import 'package:top_sale/core/utils/dialogs.dart';
import '../../../core/models/all_products_model.dart';
import '../../../core/models/category_model.dart';
import '../../../core/models/create_order_model.dart';
import '../../../core/remote/service.dart';
import '../../details_order/screens/widgets/custom_order_details_item.dart';
import 'direct_sell_state.dart';

class DirectSellCubit extends Cubit<DirectSellState> {
  DirectSellCubit(this.api) : super(DirectSellInitial());
  ServiceApi api;
  List<CategoryModelData>? result;

  int currentIndex = -1;
  changeIndex(int index, int? id) {
    currentIndex = index;
    emit(ChangeIndexState());
    print("sucess change");
    if (currentIndex == -1) {
      getAllProducts();
    } else {
      print("catogrey id" + '$id');
      getAllProductsByCatogrey(id: id);
    }

    allProductsModel.result?.products = [];
    print("sucess change 2");
  }

  CategoriesModel? catogriesModel;
  Future<void> getCategries() async {
    emit(LoadingCatogries());
    final response = await api.getAllCategories();
    //
    response.fold((l) {
      emit(ErrorCatogriesextends());
    }, (right) async {
      print("sucess cubit");
      catogriesModel = right;
      print("loaded");
      emit(LoadedCatogries(catogriesModel: catogriesModel));
    });
  }

  AllProductsModel allProductsModel = AllProductsModel();
  AllProductsModel homeProductsModel = AllProductsModel();
  Future<void> getAllProducts(
      {bool isHome = false, bool isGetMore = false, int pageId = 1}) async {
    isGetMore ? emit(Loading2Product()) : emit(LoadingProduct());
    final response = await api.getAllProducts(pageId);
    //
    response.fold((l) {
      emit(ErrorProduct());
    }, (right) async {
      print("sucess cubit");
      if (isHome) {
        homeProductsModel = right;
        updateUserOrderedQuantities(homeProductsModel);
      } else {
        if (isGetMore) {
          // allProductsModel = AllProductsModel(
          //   count: right.count,
          //   next: right.next,
          //   prev: right.prev,
          //   result: [...allProductsModel.result!, ...right.result!],
          // );
          updateUserOrderedQuantities(allProductsModel);
        } else {
          allProductsModel = right;
        }
        updateUserOrderedQuantities(allProductsModel);
      }
      print("loaded");
      emit(LoadedProduct(allProductmodel: allProductsModel));
    });
  }

  List<ProductModelData> basket = [];

  double totalBasket() {
    double total = 0.0;
    for (int i = 0; i < basket.length; i++) {
      total += (basket[i].userOrderedQuantity * (basket[i].listPrice ?? 1));
    }
    return total;
  }

  addAndRemoveToBasket(
      {required bool isAdd, required ProductModelData product}) {
    emit(LoadingTheQuantityCount());
    if (isAdd) {
      bool existsInBasket = basket.any((item) => item.id == product.id);
      if (!existsInBasket) {
        if (product.userOrderedQuantity < product.stockQuantity) {
          product.userOrderedQuantity++;
          basket.add(product);
        }

        emit(IncreaseTheQuantityCount());
      } else {
        final existingProduct =
            basket.firstWhere((item) => item.id == product.id);
        if (product.userOrderedQuantity < product.stockQuantity) {
          existingProduct.userOrderedQuantity++;
        }
        emit(IncreaseTheQuantityCount());
        debugPrint('::::||:::: ${existingProduct.userOrderedQuantity}');
      }
    } else {
      if (product.userOrderedQuantity == 0) {
        basket.removeWhere((item) => item.id == product.id);
        emit(DecreaseTheQuantityCount());
      } else {
        product.userOrderedQuantity--;
        emit(DecreaseTheQuantityCount());
      }
    }
    emit(OnChangeCountOfProducts());
    // updateUserOrderedQuantities(allProductsModel);
    // updateUserOrderedQuantities(homeProductsModel);
    totalBasket();
  }

  Future<void> getAllProductsByCatogrey({required int? id}) async {
    print("sucess change 3");

    emit(LoadingProductByCatogrey());
    final response = await api.getAllProductsByCategory(1, categoryId: id!);
    //
    response.fold((l) {
      emit(ErrorProductByCatogrey());
    }, (right) async {
      allProductsModel = right;
      // for (var element in allProductsModel.result!) {}
      updateUserOrderedQuantities(allProductsModel);
      updateUserOrderedQuantities(homeProductsModel);
      emit(LoadedProductByCatogrey(allProductmodel: allProductsModel));
    });
  }

  //!
  //! Method to update userOrderedQuantity based on items in the basket
  void updateUserOrderedQuantities(AllProductsModel allProductsModes) {
    for (var basketItem in basket) {
      for (ProductModelData product
          in allProductsModes.result!.products ?? []) {
        if (product.id == basketItem.id) {
          product.userOrderedQuantity =
              basketItem.userOrderedQuantity; //! Update quantity
        }
      }

      // emit(OnChangeCountOfProducts());
    }
  }

  CreateOrderModel? createOrderModel;
  createQuotation({
    required int partnerId,
    required BuildContext context,
    required String warehouseId,
  }) async {
    emit(LoadingCreateQuotation());
    final result = await api.createQuotation(
        partnerId: partnerId, products: basket, warehouseId: warehouseId);

    result.fold((l) {
      emit(ErrorCreateQuotation());
    }, (r) {
      createOrderModel = r;
      successGetBar('Success Create Quotation');
      debugPrint("Success Create Quotation");
      basket = [];
      //! Nav to
      Navigator.pushReplacementNamed(context, Routes.deleveryOrderRoute);
      emit(LoadedCreateQuotation());
    });
  }

  clearSearchText() {
    searchController.clear();
    emit(ClearSearchText());
  }

  TextEditingController searchController = TextEditingController();
  AllProductsModel? searchedProductsModel;

  // Search products by name
  searchProducts(
      {int pageId = 1, bool isGetMore = false, bool isBarcode = false}) async {
    final response =
        await api.searchProducts(pageId, searchController.text, isBarcode);
    response.fold((l) => emit(ErrorProduct()), (r) {
      searchedProductsModel = r;
      // final updatedResults = _updateUserOrderedQuantity(r.result!);
      updateUserOrderedQuantities(searchedProductsModel!);
      // searchedproductsModel = AllProductsModel(
      //   count: r.count,
      //   next: r.next,
      //   prev: r.prev,
      //   result: updatedResults,
      // );

      emit(LoadedProduct(allProductmodel: allProductsModel));
    });
  }

  TextEditingController newPriceController = TextEditingController();

  onChnagePriceOfUnit(ProductModelData item, BuildContext context) {
    item.listPrice = double.parse(newPriceController.text.toString());
    Navigator.pop(context);
    newPriceController.clear();
    emit(OnChangeUnitPriceOfItem());
  }

  deleteFromBasket(int id) {
    basket.removeWhere((element) {
      return element.id == id;
    });
    print('|||||||||::${basket.length}::|||||||||');
    emit(OnDeleteItemFromBasket());
  }

  TextEditingController newDiscountController = TextEditingController();

  onChnageDiscountOfUnit(ProductModelData item, BuildContext context) {
    if (double.parse(calculateDiscountedPrice(
            double.parse(newDiscountController.text.toString()),
            item.listPrice,
            item.userOrderedQuantity)) >=
        double.parse(item.cost.toString())) {
      item.discount = double.parse(newDiscountController.text.toString());
    } else {
      errorGetBar('discount_invalid'.tr());
    }
    Navigator.pop(context);
    newDiscountController.clear();
    emit(OnChangeUnitPriceOfItem());
  }

  TextEditingController newAllDiscountController = TextEditingController();

  onChnageAllDiscountOfUnit(BuildContext context) {
    for (int i = 0; i < basket.length; i++) {
      if (double.parse(calculateDiscountedPrice(
              double.parse(newAllDiscountController.text.toString()),
              basket[i].listPrice,
              basket[i].userOrderedQuantity)) >=
          double.parse(basket[i].cost.toString())) {
        basket[i].discount =
            double.parse(newAllDiscountController.text.toString());
      } else {
        errorGetBar('discount_invalid'.tr());
      }
    }
    Navigator.pop(context);
    newAllDiscountController.clear();
    emit(OnChangeAllUnitPriceOfItem());
  }
}

//
//

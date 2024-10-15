import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/all_products_model.dart';
import '../../../core/models/category_model.dart';
import '../../../core/remote/service.dart';
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
      print("catogrey id" + '${id}');
      getAllProductsByCatogrey(id: id);
    }

    allProductsModel?.result = [];
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
  Future<void> getAllProducts({bool isHome = false, bool isGetMore = false, int pageId = 1}) async {
    emit(LoadingProduct());
    final response = await api.getAllProducts(pageId);
    //
    response.fold((l) {
      emit(ErrorProduct());
    }, (r) async {
      if (isHome) {
        homeProductsModel = r;
      } else {
         if (isGetMore) {
        allProductsModel = AllProductsModel(
          count: r.count,
          next: r.next,
          prev: r.prev,
          result: [...allProductsModel.result!, ...r.result!],
        );
      } else {
        allProductsModel = r;
      }
        // allProductsModel = right;
      }
      emit(LoadedProduct(allProductmodel: allProductsModel));
    });
  }

  List<ProductModelData> basket = [];
  addAndRemoveToBasket(
      {bool isAdd = false, required ProductModelData product}) {
    if (isAdd) {
      product.userOrderedQuantity++;
      basket.add(product);
      emit(IncreaseTheQuantityCount());
    } else {
      if (product.userOrderedQuantity == 0) {
        basket.remove(product);
        emit(DecreaseTheQuantityCount());
      } else {
        product.userOrderedQuantity--;
        emit(DecreaseTheQuantityCount());
      }
    }
  }

  Future<void> getAllProductsByCatogrey({required int? id}) async {
    print("sucess change 3");

    emit(LoadingProductByCatogrey());
    final response = await api.getAllProductsByCategory(1, categoryId: id!);
    //
    response.fold((l) {
      print("errorr change 2");

      emit(ErrorProductByCatogrey());
    }, (right) async {
      print("sucess cubit");
      allProductsModel = right;
      for (var element in allProductsModel.result!) {}
      print("loaded");
      emit(LoadedProductByCatogrey(allProductmodel: allProductsModel));
    });
  }
}

//
//

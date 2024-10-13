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
  changeIndex(int index,int? id) {
    currentIndex = index;
    emit(ChangeIndexState());
    print("sucess change");
    if( currentIndex==-1){
      getAllProducts();
    }
    else{
      print("catogrey id"+'${id}');
      getAllProductsByCatogrey(id: id);
    }


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

  AllProductsModel? allProductsModel;

  Future<void> getAllProducts() async {
    emit(LoadingProduct());
    final response = await api.getAllProducts(1);
    //
    response.fold((l) {
      emit(ErrorProduct());
    }, (right) async {
      print("sucess cubit");
      allProductsModel = right;
      print("loaded");
      emit(LoadedProduct(allProductmodel: allProductsModel));
    });
  }

  addAndRemoveToBasket({bool isAdd = false, required int index}) {
    if (isAdd) {
      allProductsModel!.result![index].userOrderedQuantity++;
      emit(IncreaseTheQuantityCount());
    } else {
      if (allProductsModel!.result![index].userOrderedQuantity > 0) {
        allProductsModel!.result![index].userOrderedQuantity--;
        emit(DecreaseTheQuantityCount());
      }
    }
  }
  Future<void> getAllProductsByCatogrey({ required int ?id}) async {
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
      print("loaded");
      emit(LoadedProductByCatogrey(allProductmodel: allProductsModel));
    });
  }
}

//
//

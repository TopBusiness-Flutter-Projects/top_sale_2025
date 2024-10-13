import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/all_products_model.dart';
import '../../../core/models/category_model.dart';
import '../../../core/remote/service.dart';
import 'direct_sell_state.dart';

class DirectSellCubit extends Cubit<DirectSellState> {
  DirectSellCubit(this.api) : super(DirectSellInitial());
  ServiceApi api;
  List<Result> ?result;

  int currentIndex = -1;
  changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }
  GetCategoriesModel ?catogriesModel;
  Future<void> getCatogries() async {
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
  AllProductsModel?allProductsModel;

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
      emit(LoadedProduct( allProductmodel: allProductsModel));
    });
  }
}

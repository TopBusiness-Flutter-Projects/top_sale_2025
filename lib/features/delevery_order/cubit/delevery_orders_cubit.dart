import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';
import '../../../core/models/get_orders_model.dart';
import 'delevery_orders_state.dart';

class DeleveryOrdersCubit extends Cubit<DeleveryOrdersState> {
  DeleveryOrdersCubit(this.api) : super(DeleveryOrdersInitial());
  ServiceApi api;
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(DeleveryOrdersIndexChanged(currentIndex));
    getOrders();
  }
  GetOrdersModel? getOrdersModel;
  void getOrders() async {
    emit(OrdersLoadingState());
    final result = await api.getOrders();
    result.fold(
          (failure) => emit(OrdersErrorState('Error loading  data: $failure')),
          (r) {
            getOrdersModel = r;
            print("model $getOrdersModel");
        emit(OrdersLoadedState());
      },
    );
  }
}

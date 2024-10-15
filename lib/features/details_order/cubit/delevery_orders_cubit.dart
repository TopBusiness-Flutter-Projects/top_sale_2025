import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';
import 'package:top_sale/features/details_order/cubit/delevery_orders_state.dart';
import '../../../core/models/all_journals_model.dart';
import '../../../core/models/create_order_model.dart';
import '../../../core/models/order_details_model.dart';

class DetailsOrdersCubit extends Cubit<DetailsOrdersState> {
  DetailsOrdersCubit(this.api) : super(DetailsOrdersInitial());
  ServiceApi api;
  OrderDetailsModel? getDetailsOrdersModel;
  TextEditingController moneyController = TextEditingController();
  void getDetailsOrders({required int orderId}) async {
    emit(GetDetailsOrdersLoadingState());
    final result = await api.getOrderDetails(orderId: orderId);
    result.fold(
      (failure) =>
          emit(GetDetailsOrdersErrorState('Error loading  data: $failure')),
      (r) {
        getDetailsOrdersModel = r;
        emit(GetDetailsOrdersLoadedState());
      },
    );
  }
  CreateOrderModel? createOrderModel;
  void confirmDelivery({required int pickingId,required int orderId}) async {
    emit(ConfirmDeliveryLoadingState());
    final result = await api.confirmDelivery(pickingId: pickingId);
    result.fold(
      (failure) =>
          emit(ConfirmDeliveryErrorState('Error loading  data: $failure')),
      (r) {
        createOrderModel = r;
        emit(ConfirmDeliveryLoadedState());
        getDetailsOrders(orderId: orderId);

      },
    );
  }
  void createAndValidateInvoice({required int orderId}) async {
    emit(CreateAndValidateInvoiceLoadingState());
    final result = await api.createAndValidateInvoice(orderId: orderId);
    result.fold(
      (failure) =>
          emit(CreateAndValidateInvoiceErrorState('Error loading  data: $failure')),
      (r) {
        createOrderModel = r;
        emit(CreateAndValidateInvoiceLoadedState());
        getDetailsOrders(orderId: orderId);

      },
    );
  }
  GetAllJournalsModel ? getAllJournalsModel;
  void getAllJournals() async {
    emit(GetAllJournalsLoadingState());
    final result = await api.getAllJournals();
    result.fold(
      (failure) =>
          emit(GetAllJournalsErrorState('Error loading  data: $failure')),
      (r) {
        getAllJournalsModel = r;
        emit(GetAllJournalsLoadedState());
      },
    );
  }
}

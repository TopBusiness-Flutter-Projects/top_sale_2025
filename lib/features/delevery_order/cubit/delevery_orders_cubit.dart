import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';
import '../../../core/models/get_orders_model.dart';
import '../../../core/models/partner_model.dart';
import 'delevery_orders_state.dart';

class DeleveryOrdersCubit extends Cubit<DeleveryOrdersState> {
  DeleveryOrdersCubit(this.api) : super(DeleveryOrdersInitial());
  ServiceApi api;
  int currentIndex = 0;
  final List<String> items = [
    'all',
    "show_price",
    'new',
    'delivered',
  ];
  String selectedValue = "all";
  void changeIndex(int index) {
    currentIndex = index;
    emit(DeleveryOrdersIndexChanged());
  }

  void changeSelectedValue(String newValue) {
    selectedValue = newValue;
    emit(DeleveryOrdersIndexChanged());
  }

  List<OrderModel> completeOrders = []; // الطلبات السابقة
  List<OrderModel> currentOrders = []; // الطلبات الحالية كلها
  List<OrderModel> draftOrders = []; // طلبات عرض السعر
  List<OrderModel> newOrders = []; // pending   الطلبات الجديدة
  List<OrderModel> deliveredOrders = []; // تم التسليم
  GetOrdersModel getOrdersModel = GetOrdersModel();
  void getOrders() async {
    emit(OrdersLoadingState());
    completeOrders = []; // الطلبات السابقة
    currentOrders = []; // الطلبات الحالية كلها
    draftOrders = []; // طلبات عرض السعر
    newOrders = []; // pending   الطلبات الجديدة
    deliveredOrders = []; // تم التسليم
    final result = await api.getOrders();
    result.fold(
      (failure) => emit(OrdersErrorState('Error loading  data: $failure')),
      (r) async {
        for (var element in r.result!) {
          if (element.state.toString() == 'sale' &&
              element.invoiceStatus.toString() == 'invoiced' &&
              element.deliveryStatus.toString() == 'full') {
            completeOrders.add(element);
          } else {
            currentOrders.add(element);
            if (element.state.toString() == 'draft') {
              draftOrders.add(element);
            } else if (element.state.toString() == 'sale' &&
                element.invoiceStatus.toString() == 'to invoice' &&
                element.deliveryStatus.toString() == 'pending') {
              newOrders.add(element);
            } else if (element.state.toString() == 'sale' &&
                element.invoiceStatus.toString() == 'to invoice' &&
                element.deliveryStatus.toString() == 'full') {
              deliveredOrders.add(element);
            }
          }
        }

        getOrdersModel = r;

        print("model $getOrdersModel");
        emit(OrdersLoadedState());
      },
    );
  }

  Future<PartnerModel> getPartnerDetails({required int partnerId}) async {
    emit(OrdersLoadingState());
    PartnerModel? partnerModel;
    final result = await api.getPartnerDetails(partnerId: partnerId);
    result.fold(
      (failure) => emit(OrdersErrorState('Error loading  data: $failure')),
      (r) {
        partnerModel = r;
        print("model $getOrdersModel");
        emit(OrdersLoadedState());
      },
    );
    return partnerModel!;
  }
}

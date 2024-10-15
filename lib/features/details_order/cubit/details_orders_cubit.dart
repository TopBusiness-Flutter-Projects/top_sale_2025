import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';
import 'package:top_sale/core/utils/appwidget.dart';
import 'package:top_sale/core/utils/dialogs.dart';
import 'package:top_sale/features/delevery_order/cubit/delevery_orders_cubit.dart';
import 'package:top_sale/features/details_order/cubit/details_orders_state.dart';
import '../../../core/models/all_journals_model.dart';
import '../../../core/models/create_order_model.dart';
import '../../../core/models/order_details_model.dart';

class DetailsOrdersCubit extends Cubit<DetailsOrdersState> {
  DetailsOrdersCubit(this.api) : super(DetailsOrdersInitial());
  ServiceApi api;
  OrderDetailsModel? getDetailsOrdersModel;
  List list = [0, 1, 2,3]; // 0 عرض سعر
   // جديدة

     int page = 1;
     void changePage(int index) {
       page = index;
       emit(ChangePageState());
     }
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
  void confirmDelivery(BuildContext context,
      {required int pickingId, required int orderId}) async {
         AppWidget.createProgressDialog(context, "جاري التحميل");
    emit(ConfirmDeliveryLoadingState());
    final result = await api.confirmDelivery(pickingId: pickingId);
    result.fold(
        (failure) {
          Navigator.pop(context);
          emit(ConfirmDeliveryErrorState('Error loading  data: $failure'));
        },
        (r) {
          Navigator.pop(context);
      if (r.result != null) {
        if (r.result!.message != null) {
          successGetBar(r.result!.message);
          emit(ConfirmDeliveryLoadedState());
          
          
         context.read<DeleveryOrdersCubit>().getOrders();
          getDetailsOrders(orderId: orderId);
          
        } else {
          emit(ConfirmDeliveryErrorState('Error loading  data: '));

          errorGetBar("error");
        }
      } else {
        emit(ConfirmDeliveryErrorState('Error loading  data: '));

        errorGetBar("error");
      }
    });
  }

  void registerPayment(BuildContext context,
      {required int journalId,
      required int invoiceId,
      required int orderId}) async {
    emit(RegisterPaymentLoadingState());
    AppWidget.createProgressDialog(context, "جاري التحميل");
    final result = await api.registerPayment(
        invoiceId: invoiceId,
        journalId: journalId,
        amount: moneyController.text);
    result.fold(
      (failure) {
        Navigator.pop(context);
        Navigator.pop(context);
        errorGetBar("error");
        emit(RegisterPaymentErrorState('Error loading  data: $failure'));
      },
      (r) {
        Navigator.pop(context);
        Navigator.pop(context);
        if (r.result != null) {
          if (r.result!.message != null) {
            successGetBar(r.result!.message);
            emit(RegisterPaymentLoadedState());
            Navigator.pop(context);
            getDetailsOrders(orderId: orderId);
            context.read<DeleveryOrdersCubit>().getOrders();
          } else {
            emit(RegisterPaymentErrorState('Error loading  data: '));

            errorGetBar("error");
          }
        } else {
          emit(RegisterPaymentErrorState('Error loading  data: '));

          errorGetBar("error");
        }

        moneyController.clear();
      },
    );
  }

  void createAndValidateInvoice(BuildContext context,{required int orderId}) async {
    emit(CreateAndValidateInvoiceLoadingState());
             AppWidget.createProgressDialog(context, "جاري التحميل");

    final result = await api.createAndValidateInvoice(orderId: orderId);
    result.fold(
      (failure) {
        Navigator.pop(context);
        emit(
          CreateAndValidateInvoiceErrorState('Error loading  data: $failure'));
      },
          (r) {
        Navigator.pop(context);
        
        if (r.result != null) {
          if (r.result!.message != null) {
            successGetBar(r.result!.message);
            emit(CreateAndValidateInvoiceLoadedState());
           context.read<DeleveryOrdersCubit>().getOrders();
            getDetailsOrders(orderId: orderId);
          } else {
            emit(CreateAndValidateInvoiceErrorState('Error loading  data: '));

            errorGetBar("error");
          }
        } else {
          emit(CreateAndValidateInvoiceErrorState('Error loading  data: '));

          errorGetBar("error");
        }       
      },

    );
  }
  GetAllJournalsModel? getAllJournalsModel;
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

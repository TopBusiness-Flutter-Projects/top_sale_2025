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
  List list = [0, 1, 2, 3]; // 0 عرض سعر
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
    result.fold((failure) {
      Navigator.pop(context);
      emit(ConfirmDeliveryErrorState('Error loading  data: $failure'));
    }, (r) {
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

  void createAndValidateInvoice(BuildContext context,
      {required int orderId}) async {
    emit(CreateAndValidateInvoiceLoadingState());
    AppWidget.createProgressDialog(context, "جاري التحميل");

    final result = await api.createAndValidateInvoice(orderId: orderId);
    result.fold(
      (failure) {
        Navigator.pop(context);
        emit(CreateAndValidateInvoiceErrorState(
            'Error loading  data: $failure'));
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

  var listOfremovedItems = [];

  void removeItemFromOrderLine(int index) {
    // Check if getDetailsOrdersModel and its orderLines list are not null
    if (getDetailsOrdersModel != null &&
        getDetailsOrdersModel!.orderLines != null &&
        index >= 0 &&
        index < getDetailsOrdersModel!.orderLines!.length) {
      // Get the ID of the item to be removed
      var itemId = getDetailsOrdersModel!.orderLines![index].id;

      // Remove the item from orderLines
      getDetailsOrdersModel!.orderLines!.removeAt(index);

      // Add the ID to the list of removed items
      listOfremovedItems.add(itemId);

      print('Removed item ID: $itemId');
      print('List of removed items: $listOfremovedItems');

      // Emit the state after removal
      emit(RemoveItemFromOrderLineLoadedState());
    } else {
      // Handle invalid index case
      print('Error: Invalid index or null order lines.');
    }
  }

  onClickBack(BuildContext context) {
    Navigator.pop(context);
    listOfremovedItems.clear();
    emit(ClickBackState());
  }

  double totalBasket() {
    double total = 0.0;
    for (int i = 0; i < getDetailsOrdersModel!.orderLines!.length; i++) {
      total += (int.parse(
              getDetailsOrdersModel!.orderLines![i].productUomQty.toString()) *
          (double.parse(
              getDetailsOrdersModel!.orderLines![i].priceUnit.toString())));
    }

    getDetailsOrdersModel!.amountTotal = total;
    return total;
  }

  addAndRemoveToBasket({
    required bool isAdd,
    required OrderLine product,
  }) {
    emit(LoadingTheQuantityCount());

    if (isAdd) {
      bool existsInBasket = getDetailsOrdersModel!.orderLines!
          .any((item) => item.id == product.id);
      if (!existsInBasket) {
        product.productUomQty = int.parse(product.productUomQty.toString()) + 1;
        getDetailsOrdersModel!.orderLines?.add(product);
        emit(IncreaseTheQuantityCount());
      } else {
        final existingProduct = getDetailsOrdersModel!.orderLines!
            .firstWhere((item) => item.id == product.id);
        existingProduct.productUomQty =
            int.parse(existingProduct.productUomQty.toString()) + 1;
        emit(IncreaseTheQuantityCount());
        debugPrint('::::::::: ${existingProduct.productUomQty}');
      }
    } else {
      if (product.productUomQty == 0) {
        getDetailsOrdersModel!.orderLines
            ?.removeWhere((item) => item.id == product.id);
        listOfremovedItems.add(product.id);
        print('lllll');
        emit(DecreaseTheQuantityCount());
      } else {
        product.productUomQty = int.parse(product.productUomQty.toString()) - 1;
        emit(DecreaseTheQuantityCount());
      }
    }
    totalBasket();
  }

  // List<OrderLine> basket = [];
  CreateOrderModel? updatreOrderModel;
  updateQuotation(
      {required int partnerId, required BuildContext context}) async {
    emit(LoadingUpdateQuotation());
    final result = await api.updateQuotation(
        partnerId: partnerId,
        saleOrderId: getDetailsOrdersModel!.id.toString(),
        products: getDetailsOrdersModel!.orderLines ?? [],
        listOfremovedItems: listOfremovedItems);

    result.fold((l) {
      emit(ErrorUpdateQuotation());
    }, (r) {
      listOfremovedItems.clear();

      updatreOrderModel = r;
      successGetBar('Success Update Quotation');
      debugPrint("Success Update Quotation");
      getDetailsOrdersModel!.orderLines?.clear();
      //! Nav to
      confirmQuotation(orderId: getDetailsOrdersModel!.id!, context: context);
      emit(LoadedUpdateQuotation());
    });
  }

  confirmQuotation(
      {required int orderId, required BuildContext context}) async {
    emit(LoadingConfirmQuotation());
    final result = await api.confirmQuotation(orderId: orderId);
    result.fold((l) {
      emit(ErrorConfirmQuotation());
    }, (r) {
      context.read<DeleveryOrdersCubit>().getOrders();
      //! Make confirm quotation
      Navigator.pop(context);
      emit(LoadedConfirmQuotation());
    });
  }

  TextEditingController newPriceController = TextEditingController();

  onChnagePriceOfUnit(OrderLine item, BuildContext context) {
    item.priceUnit = double.parse(newPriceController.text.toString());
    Navigator.pop(context);
    newPriceController.clear();
    emit(OnChangeUnitPriceOfItem());
  }
}

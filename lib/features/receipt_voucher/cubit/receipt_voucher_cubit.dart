import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/models/all_partners_for_reports_model.dart';
import 'package:top_sale/core/models/all_payments_model.dart';
import 'package:top_sale/core/remote/service.dart';
import 'package:top_sale/core/utils/assets_manager.dart';
import 'package:top_sale/features/clients/cubit/clients_state.dart';
import 'package:top_sale/features/receipt_voucher/cubit/receipt_voucher_state.dart';

class ReceiptVoucherCubit extends Cubit<ReceiptVoucherState> {
  ReceiptVoucherCubit(this.api) : super(ReceiptVoucherInitial());
  ServiceApi api;
  TextEditingController clientNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> Images = [
    ImageAssets.addressIcon2,
    ImageAssets.invoiceIcon,
    ImageAssets.sellersIcon,
    ImageAssets.buyerIcon,
    ImageAssets.moneyIcon,
    ImageAssets.waitingMoneyIcon
  ];
  List<String> Texts = [
    "address",
    "invoices",
    "sales",
    "payments_due",
    "unbilled_amounts",
    "overdue_amounts"
  ];
  // onChangeSearch(String? value) {
  //   EasyDebounce.debounce(
  //       'my-debouncer',                 // <-- An ID for this particular debouncer
  //       Duration(milliseconds: 100),    // <-- The debounce duration
  //           () =>  getFromSearch()                // <-- The target method
  //   );
  //   emit(SearchLoaded());
  // }
  // AllPaymentsModel allPaymentsModel = AllPaymentsModel();
  // getAllReceiptVoucher() async {
  //   emit(ProfileClientLoading());
  //   final result = await api.getAllPayments();
  //   result.fold(
  //     (failure) => emit(ProfileClientError()),
  //     (r) {
  //       allPaymentsModel = r;
  //       emit(ProfileClientLoaded());
  //     },
  //   );
  // }
}

import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as perm;
import 'package:top_sale/features/clients/cubit/clients_state.dart';
import 'package:top_sale/features/receipt_voucher/cubit/receipt_voucher_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/models/all_partners_for_reports_model.dart';
import '../../../core/models/create_order_model.dart';
import '../../../core/models/partner_model.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/dialogs.dart';

class ReceiptVoucherCubit extends Cubit<ReceiptVoucherState> {
  ReceiptVoucherCubit(this.api) : super(ReceiptVoucherInitial());
  ServiceApi api;
  TextEditingController clientNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GetAllPartnersModel? allPartnersModel;
  List<String>Images=[ImageAssets.addressIcon2,ImageAssets.invoiceIcon,ImageAssets.sellersIcon,ImageAssets.buyerIcon,ImageAssets.moneyIcon,ImageAssets.waitingMoneyIcon];
  List<String>Texts=["address","invoices","sales","payments_due","unbilled_amounts","overdue_amounts"];

  // onChangeSearch(String? value) {
  //   EasyDebounce.debounce(
  //       'my-debouncer',                 // <-- An ID for this particular debouncer
  //       Duration(milliseconds: 100),    // <-- The debounce duration
  //           () =>  getFromSearch()                // <-- The target method
  //   );
  //   emit(SearchLoaded());
  // }
}

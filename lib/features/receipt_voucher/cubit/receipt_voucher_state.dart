import '../../../core/models/all_partners_for_reports_model.dart';

abstract class ReceiptVoucherState {}

class ReceiptVoucherInitial extends ReceiptVoucherState {}

class ErrorGetPartnersState extends ReceiptVoucherState {}

class LoadingGetPartnersState extends ReceiptVoucherState {}
class LoadingMorePartnersState extends ReceiptVoucherState {}

class SucessGetPartnersState extends ReceiptVoucherState {
  GetAllPartnersModel? allPartnersModel;
  SucessGetPartnersState({required this.allPartnersModel});
}
//create client
class CreateClientLoading extends ReceiptVoucherState {}
class CreateClientLoaded extends ReceiptVoucherState {}
class CreateClientError extends ReceiptVoucherState {}
//get from search
class SearchLoading extends ReceiptVoucherState {}
class SearchLoaded extends ReceiptVoucherState {}
class SearchError extends ReceiptVoucherState {
  String ?error;
  SearchError({required this.error});
}
//get client profile
class ProfileClientLoading extends ReceiptVoucherState {}
class ProfileClientLoaded extends ReceiptVoucherState {}
class ProfileClientError extends ReceiptVoucherState {}
//lat,long
class GetLatLongSuccess extends ReceiptVoucherState {}


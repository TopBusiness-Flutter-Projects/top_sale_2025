abstract class DetailsOrdersState {}

class DetailsOrdersInitial extends DetailsOrdersState {}


class GetDetailsOrdersLoadedState extends DetailsOrdersState {}
class GetDetailsOrdersLoadingState extends DetailsOrdersState {}
class GetDetailsOrdersErrorState extends DetailsOrdersState {
  String error;
  GetDetailsOrdersErrorState(this.error);
}class ConfirmDeliveryLoadedState extends DetailsOrdersState {}
class ConfirmDeliveryLoadingState extends DetailsOrdersState {}
class ConfirmDeliveryErrorState extends DetailsOrdersState {
  String error;
  ConfirmDeliveryErrorState(this.error);
}
class CreateAndValidateInvoiceLoadedState extends DetailsOrdersState {}
class CreateAndValidateInvoiceLoadingState extends DetailsOrdersState {}
class CreateAndValidateInvoiceErrorState extends DetailsOrdersState {
  String error;
  CreateAndValidateInvoiceErrorState(this.error);
}class GetAllJournalsLoadedState extends DetailsOrdersState {}
class GetAllJournalsLoadingState extends DetailsOrdersState {}
class GetAllJournalsErrorState extends DetailsOrdersState {
  String error;
  GetAllJournalsErrorState(this.error);
}

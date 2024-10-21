
 class CreateReceiptCoucherState {}

 class CreateReceiptCoucherInitial extends CreateReceiptCoucherState {}
 class GetAllJournalsLoadedState extends CreateReceiptCoucherState {}

 class GetAllJournalsLoadingState extends CreateReceiptCoucherState {}

 class GetAllJournalsErrorState extends CreateReceiptCoucherState {
  String error;
  GetAllJournalsErrorState(this.error);
 }

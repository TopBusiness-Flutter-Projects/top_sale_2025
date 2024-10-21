
abstract class ReceiptVoucherState {}

class ReceiptVoucherInitial extends ReceiptVoucherState {}
class SearchLoaded extends ReceiptVoucherState {}
class ProfileClientLoading extends ReceiptVoucherState {}
class ProfileClientError extends ReceiptVoucherState {}
class ProfileClientLoaded extends ReceiptVoucherState {}


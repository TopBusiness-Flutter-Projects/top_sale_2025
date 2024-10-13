abstract class DeleveryOrdersState {}

class DeleveryOrdersInitial extends DeleveryOrdersState {}

class DeleveryOrdersIndexChanged extends DeleveryOrdersState {
  int currentIndex;

  DeleveryOrdersIndexChanged(this.currentIndex);
}
class OrdersLoadingState extends DeleveryOrdersState {}
class OrdersLoadedState extends DeleveryOrdersState {}
class OrdersErrorState extends DeleveryOrdersState {
  String error;
  OrdersErrorState(this.error);
}

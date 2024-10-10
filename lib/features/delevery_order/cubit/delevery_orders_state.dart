abstract class DeleveryOrdersState {}

class DeleveryOrdersInitial extends DeleveryOrdersState {}

class DeleveryOrdersIndexChanged extends DeleveryOrdersState {
  int currentIndex;

  DeleveryOrdersIndexChanged(this.currentIndex);
}

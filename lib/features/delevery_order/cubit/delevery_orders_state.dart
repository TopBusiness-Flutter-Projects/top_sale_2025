abstract class DeleveryOrdersState {}

class DeleveryOrdersInitial extends DeleveryOrdersState {}

class DeleveryOrdersIndexChanged extends DeleveryOrdersState {
  final int currentIndex;

  DeleveryOrdersIndexChanged(this.currentIndex);
}

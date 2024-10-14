abstract class DetailsOrdersState {}

class DetailsOrdersInitial extends DetailsOrdersState {}


class GetDetailsOrdersLoadedState extends DetailsOrdersState {}
class GetDetailsOrdersLoadingState extends DetailsOrdersState {}
class GetDetailsOrdersErrorState extends DetailsOrdersState {
  String error;
  GetDetailsOrdersErrorState(this.error);
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'delevery_orders_state.dart';

class DeleveryOrdersCubit extends Cubit<DeleveryOrdersState> {
  DeleveryOrdersCubit() : super(DeleveryOrdersInitial());
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(DeleveryOrdersIndexChanged(currentIndex));
  }
}

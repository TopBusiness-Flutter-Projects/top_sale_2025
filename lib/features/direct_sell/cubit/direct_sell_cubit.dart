import 'package:flutter_bloc/flutter_bloc.dart';
import 'direct_sell_state.dart';

class DirectSellCubit extends Cubit<DirectSellState> {
  DirectSellCubit() : super(DirectSellInitial());
  int currentIndex = -1;
  changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }
}

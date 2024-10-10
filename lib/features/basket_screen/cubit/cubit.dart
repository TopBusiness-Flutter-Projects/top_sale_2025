import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';

import 'state.dart';

class BasketCubit extends Cubit<BasketState> {
  BasketCubit(this.api) : super(InitBasketState());
  ServiceApi api;
}

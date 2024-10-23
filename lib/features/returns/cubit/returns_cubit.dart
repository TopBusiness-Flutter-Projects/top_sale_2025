

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';
import 'package:top_sale/features/returns/cubit/returns_state.dart';

class ReturnsCubit extends Cubit<ReturnsState> {
  ReturnsCubit(this.api) : super(ReturnsInitial());
  ServiceApi api;
  TextEditingController searchController = TextEditingController();
}

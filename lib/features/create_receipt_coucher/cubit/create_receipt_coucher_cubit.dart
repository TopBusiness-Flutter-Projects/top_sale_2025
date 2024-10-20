

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';

import '../../../core/models/all_journals_model.dart';
import 'create_receipt_coucher_state.dart';

class CreateReceiptCoucherCubit extends Cubit<CreateReceiptCoucherState> {
  CreateReceiptCoucherCubit(this.api) : super(CreateReceiptCoucherInitial());
  ServiceApi api;
  DateTime? selectedDate;
  String? selectedPaymentMethod;

  GetAllJournalsModel? getAllJournalsModel;
  void getAllJournals() async {
    emit(GetAllJournalsLoadingState());
    final result = await api.getAllJournals();
    result.fold(
          (failure) =>
          emit(GetAllJournalsErrorState('Error loading  data: $failure')),
          (r) {
        getAllJournalsModel = r;
        emit(GetAllJournalsLoadedState());
      },
    );
  }
}

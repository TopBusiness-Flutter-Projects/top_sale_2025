import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/features/clients/cubit/clients_state.dart';

import '../../../core/models/all_partners_for_reports_model.dart';
import '../../../core/remote/service.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this.api) : super(ClientsInitial());
  ServiceApi api;
  TextEditingController clientNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  GetAllPartnersModel? allPartnersModel;
  getAllPartnersForReport({
    int page = 1,
    int pageSize = 20,
  }) async {
    emit(LoadingGetPartnersState());
    final result = await api.getAllPartnersForReport(page, pageSize);
    result.fold(
      (l) => emit(ErrorGetPartnersState()),
      (r) {
        allPartnersModel = r;
        emit(SucessGetPartnersState());
      },
    );
  }
}

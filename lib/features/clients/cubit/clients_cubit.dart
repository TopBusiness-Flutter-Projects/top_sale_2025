

import 'package:flutter_bloc/flutter_bloc.dart';

import 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit() : super(ClientsInitial());
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/features/clients/cubit/clients_state.dart';

import '../../../core/remote/service.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this.api) : super(ClientsInitial());
  ServiceApi api;
  TextEditingController clientNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController searchController = TextEditingController();

}

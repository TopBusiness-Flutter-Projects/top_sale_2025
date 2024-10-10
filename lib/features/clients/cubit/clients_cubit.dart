

import 'package:flutter_bloc/flutter_bloc.dart';

import 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit() : super(ClientsInitial());

}

abstract class ClientsState {}

class ClientsInitial extends ClientsState {}

class ErrorGetPartnersState extends ClientsState {}

class LoadingGetPartnersState extends ClientsState {}

class SucessGetPartnersState extends ClientsState {}
//create client
class CreateClientLoading extends ClientsState {}
class CreateClientLoaded extends ClientsState {}
class CreateClientError extends ClientsState {}
//get from search
class SearchLoading extends ClientsState {}
class SearchLoaded extends ClientsState {}
class SearchError extends ClientsState {
  String ?error;
  SearchError({required this.error});
}


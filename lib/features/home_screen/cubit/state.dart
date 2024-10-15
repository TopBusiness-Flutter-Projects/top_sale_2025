abstract class HomeState {}

class MainInitial extends HomeState {}
class ProfileUserLoading extends HomeState {}
class ProfileUserLoaded extends HomeState {
  String error;
  ProfileUserLoaded({ required this.error});
}
class ProfileUserError extends HomeState {}
//employee
class ProfileEmployeeLoading extends HomeState {}
class ProfileEmployeeError extends HomeState {
  String error;
  ProfileEmployeeError({ required this.error});
}
class ProfileEmployeeLoaded extends HomeState {}
class checkLoaded extends HomeState {}
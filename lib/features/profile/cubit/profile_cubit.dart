import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';
import 'package:top_sale/features/profile/cubit/profile_state.dart';
import 'package:top_sale/features/update_profile/cubit/update_profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(ProfileInitial());
  ServiceApi api;
  TextEditingController  name=TextEditingController();
  TextEditingController  phone=TextEditingController();
}

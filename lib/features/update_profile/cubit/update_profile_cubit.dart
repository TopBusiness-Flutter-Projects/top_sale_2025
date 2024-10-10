
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/features/update_profile/cubit/update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());
}

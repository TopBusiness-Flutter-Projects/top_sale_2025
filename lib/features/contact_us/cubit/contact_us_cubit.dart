
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());
}

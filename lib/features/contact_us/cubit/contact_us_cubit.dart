import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_sale/core/remote/service.dart';

import 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit(this.api) : super(ContactUsInitial());
  ServiceApi api;
}

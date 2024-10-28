// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_sale/core/remote/service.dart';
import 'state.dart';
class ItineraryCubit extends Cubit<ItineraryState>{
  ItineraryCubit(this.api)
   : 
   super(ItineraryInitial());
  ServiceApi api;
   GoogleMapController? mapController;
 
}

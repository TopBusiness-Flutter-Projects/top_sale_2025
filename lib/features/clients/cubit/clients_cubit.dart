import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as perm;
import 'package:top_sale/features/clients/cubit/clients_state.dart';
import '../../../core/models/all_partners_for_reports_model.dart';
import '../../../core/models/create_order_model.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/dialogs.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this.api) : super(ClientsInitial());
  ServiceApi api;
  TextEditingController clientNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GetAllPartnersModel? allPartnersModel;
//get partner
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
//location section
  loc.LocationData? currentLocation;

  Future<void> checkAndRequestLocationPermission() async {
    perm.PermissionStatus permissionStatus = await perm.Permission.location.status;
    if (permissionStatus.isDenied) {
      perm.PermissionStatus newPermissionStatus = await perm.Permission.location.request();
      if (newPermissionStatus.isGranted) {
        await enableLocationServices();
      }
    } else if (permissionStatus.isGranted) {
      await enableLocationServices();
    }
  }
// enable location
  Future<void> enableLocationServices() async {
    loc.Location location = loc.Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      } else {
        getCurrentLocation();
      }
    }

    loc.PermissionStatus permissionStatus = await loc.Location().hasPermission();
    if (permissionStatus == loc.PermissionStatus.granted) {
      getCurrentLocation();
    }
  }
//get currnet
  Future<void> getCurrentLocation() async {
    loc.Location location = loc.Location();
    location.getLocation().then(
          (location) async {
        currentLocation = location;
        // emit(GetCurrentLocationState());
        debugPrint("lat: ${currentLocation?.latitude}");
        debugPrint("long: ${currentLocation?.longitude}");
      },
    );
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      // emit(GetCurrentLocationState());
      print(currentLocation);
    });
  }
//create client
  CreateOrderModel? createOrderModel;
  void createClient( BuildContext context) async {
    emit(CreateClientLoading());
    final result = await api.createPartner(name:clientNameController.text??"", mobile:phoneController.text??"", street: addressController.text??"", lat:38.9071929, long: -77.0368727);
    result.fold((l) {
      emit(CreateClientError());
    }, (r) {
      createOrderModel = r;
      successGetBar("update_sucess".tr());
      emit(CreateClientLoaded());
      getAllPartnersForReport();
      Navigator.pop(context);

    }
      //!}
    );}
  //get from search
  void getFromSearch() async {
    emit(SearchLoading());
    final result = await api.searchUsers(page: 1, name: searchController.text.toString()??"");
    result.fold(
          (failure) =>
          emit(SearchError(error: 'Error loading data: $failure')),
          (r) {
            allPartnersModel = r;
        emit(SearchLoaded());
      },
    );
  }
  onChangeSearch(String? value) {
    EasyDebounce.debounce(
        'my-debouncer',                 // <-- An ID for this particular debouncer
        Duration(milliseconds: 100),    // <-- The debounce duration
            () =>  getFromSearch()                // <-- The target method
    );
    emit(SearchLoaded());
  }
}

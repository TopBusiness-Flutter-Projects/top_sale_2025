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
    int pageSize = 20,//num of products at one page
    bool isGetMore = false
  }) async {
     isGetMore ?

    emit(LoadingMorePartnersState()):
    emit(LoadingGetPartnersState());
    final result = await api.getAllPartnersForReport(page, pageSize);
    result.fold(
          (l) => emit(ErrorGetPartnersState()),
          (r) {
            if (isGetMore) {
              allPartnersModel = GetAllPartnersModel(
                count: r.count,
                next: r.next,
                prev: r.prev,
                result: [...allPartnersModel!.result!, ...r.result!],
              );
            }
            else {
              allPartnersModel = r;
            }
            print("loaded");
            emit(SucessGetPartnersState( allPartnersModel: allPartnersModel));
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
    final result = await api.createPartner(name:clientNameController.text??"", mobile:phoneController.text??"", street: addressController.text??"", lat:double.parse(currentLocation?.latitude.toString()??""), long: double.parse(currentLocation?.longitude.toString()??""));
    result.fold((l) {
      emit(CreateClientError());
    }, (r) {

      if (r.result != null) {
        if (r.result!.message != null) {
         // successGetBar(r.result!.message);
          successGetBar("add_client".tr());
          createOrderModel = r;
          getAllPartnersForReport();
          clientNameController.clear();
          phoneController.clear();
          addressController.clear();
          emit(CreateClientLoaded());
          Navigator.pop(context);
        } else {
          emit(CreateClientError());

          errorGetBar("error");
        }
      }
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

// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as perm;
import 'package:top_sale/core/models/defaul_model.dart';
import 'package:top_sale/core/preferences/preferences.dart';
import 'package:top_sale/core/utils/appwidget.dart';
import 'package:top_sale/features/Itinerary/cubit/cubit.dart';
import 'package:top_sale/features/clients/cubit/clients_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/models/all_partners_for_reports_model.dart';
import '../../../core/models/create_order_model.dart';
import '../../../core/models/partner_model.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/dialogs.dart';

enum ClientsRouteEnum { cart, receiptVoucher, details }

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this.api) : super(ClientsInitial());
  ServiceApi api;
  TextEditingController clientNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  File? profileImage;
  String selectedBase64String = "";
  GetAllPartnersModel? allPartnersModel;
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        selectedBase64String = await fileToBase64String(pickedFile.path);
        emit(UpdateProfileImagePicked()); // Emit state for image picked
      }
    } catch (e) {
      // Handle any errors
      emit(UpdateProfileError());
    }
  }

  //photo transfer
  Future<String> fileToBase64String(String filePath) async {
    File file = File(filePath);
    Uint8List bytes = await file.readAsBytes();
    String base64String = base64Encode(bytes);
    return base64String;
  }

  List<String> Images = [
    ImageAssets.addressIcon,
    ImageAssets.invoiceIcon,
    ImageAssets.sellersIcon,
    ImageAssets.buyerIcon,
    ImageAssets.receiptVoucherIcon,
    ImageAssets.waitingMoneyIcon
  ];
  List<String> Texts = [
    "address",
    "invoices",
    "sales",
    "payments_due",
    "unbilled_amounts",
    "overdue_amounts"
  ];
//get partner
  getAllPartnersForReport(
      {int page = 1,
      int pageSize = 20, //num of products at one page
      bool isGetMore = false}) async {
    isGetMore
        ? emit(LoadingMorePartnersState())
        : emit(LoadingGetPartnersState());
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
        } else {
          allPartnersModel = r;
        }
        print("loaded");
        emit(SucessGetPartnersState(allPartnersModel: allPartnersModel));
      },
    );
  }

//location section
  loc.LocationData? currentLocation;

  Future<void> checkAndRequestLocationPermission(BuildContext context) async {
    perm.PermissionStatus permissionStatus =
        await perm.Permission.location.status;
    if (permissionStatus.isDenied) {
      perm.PermissionStatus newPermissionStatus =
          await perm.Permission.location.request();
      if (newPermissionStatus.isGranted) {
        await enableLocationServices(context);
      }
    } else if (permissionStatus.isGranted) {
      await enableLocationServices(context);
    } else if (permissionStatus.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("locationRequired".tr()),
          content: Text("locationDescribtion".tr()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancel".tr()),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await perm.openAppSettings();
              },
              child: Text("openSettings".tr()),
            ),
          ],
        ),
      );
    }
  }

// enable location
  Future<void> enableLocationServices(BuildContext context) async {
    loc.Location location = loc.Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      } else {
        getCurrentLocation(context);
      }
    }

    loc.PermissionStatus permissionStatus =
        await loc.Location().hasPermission();
    if (permissionStatus == loc.PermissionStatus.granted) {
      getCurrentLocation(context);
    }
  }

//get currnet
  Future<void> getCurrentLocation(BuildContext context) async {
    loc.Location location = loc.Location();
    location.getLocation().then(
      (location) async {
        currentLocation = location;
        getAddressFromLatLng(
            location.latitude ?? 0.0, location.longitude ?? 0.0);
        bool isInTrip = await Preferences.instance.getIsInTrip();
        if (isInTrip) {
          startLocationUpdates(context, isStart: false);
        }
        emit(GetCurrentLocationState());
        debugPrint("lat: ${currentLocation?.latitude}");
        debugPrint("long: ${currentLocation?.longitude}");
      },
    );
    // location.onLocationChanged.listen((newLoc) {
    //   currentLocation = newLoc;
    //   // emit(GetCurrentLocationState());
    //   // print(currentLocation);
    // });

    // Update location if distance > 100m
    location.onLocationChanged.listen((newLocationData) async {
      if (currentLocation != null) {
        double distance = Geolocator.distanceBetween(
          currentLocation!.latitude ?? 0.0,
          currentLocation!.longitude ?? 0.0,
          newLocationData.latitude ?? 0.0,
          newLocationData.longitude ?? 0.0,
        );
        //  debugPrint("Movedddd: $distance meters");
        if (distance > 8) {
          currentLocation = newLocationData;
          // getAddressFromLatLng(newLocationData.latitude ?? 0.0, newLocationData.longitude ?? 0.0);
          emit(GetCurrentLocationState());
          debugPrint("Updated lat: ${currentLocation?.latitude}");
          debugPrint("Updated long: ${currentLocation?.longitude}");
          debugPrint("Moved: $distance meters");
        }
        currentLocation = newLocationData;
        updateLocation();
      }
    });
  }

  Timer? timer;
  Future<void> startLocationUpdates(BuildContext context,
      {bool isStart = true}) async {
    // Fetch location immediately and set timer to update every 5 minutes
    print("start time");

    updateLatLong(context, text: isStart ? "(start)" : "");
    await Preferences.instance.setIsInTrip(true);
    // Set up a timer to fetch location every 5 minutes
    timer = Timer.periodic(const Duration(minutes: 30), (timer) {
      print("10 seconds then");
      updateLatLong(context, text: "");
      debugPrint(" lat: ${currentLocation?.latitude}");
      debugPrint(" long: ${currentLocation?.longitude}");
    });
  }

  void stopLocationUpdates(
    BuildContext context,
  ) async {
    updateLatLong(context, text: "(end)");
    await Preferences.instance.setIsInTrip(false);
    if (timer != null && timer!.isActive) {
      timer!.cancel();
      print("Timer cancelled");
    }
  }

  void updateLatLong(BuildContext context, {required String text}) async {
    emit(UpdateProfileUserLoading());
    if (context.read<ItineraryCubit>().getEmployeeDataModel != null) {
      if (context
          .read<ItineraryCubit>()
          .getEmployeeDataModel!
          .carIds!
          .isNotEmpty) {
        await getAddressFromLatLng(currentLocation!.latitude ?? 0.0,
            currentLocation!.longitude ?? 0.0);
        final result = await api.tracking(
            name: text + address,
            carId: context
                .read<ItineraryCubit>()
                .getEmployeeDataModel!
                .carIds!
                .first
                .id,
            date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            lat: currentLocation?.latitude ?? 0.0,
            long: currentLocation?.longitude ?? 0.0);
        result.fold((l) {
          emit(UpdateProfileUserError());
        }, (r) {
          emit(UpdateProfileUserLoaded());
        });
      }
    }
  }

  GoogleMapController? mapController;
  Future<void> updateLocation() async {
    if (mapController != null && currentLocation != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
          ),
        ),
      );
    }
  }

  // Future<void> sendLocation(BuildContext context) async {
  //   perm.PermissionStatus permissionStatus =
  //       await perm.Permission.location.status;

  //   if (permissionStatus.isGranted) {
  //     getCurrentLocation();
  //   } else if (permissionStatus.isPermanentlyDenied) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text("Location Permission Required"),
  //         content: Text(
  //             "Location permission is permanently denied. Please enable it in settings to continue."),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text("Cancel"),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               Navigator.pop(context);
  //               await perm.openAppSettings();
  //             },
  //             child: Text("Open Settings"),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //   //  else {
  //   //   await checkAndRequestLocationPermission();
  //   // }
  // }

  String country = " country ";
  String city = " city ";
  String address = " address ";
  String address2 = " address ";
  Future<void> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      //  await placemarkFromCoordinates(37.4219983, -122.084);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        country = place.country ?? "";
        city = place.locality ?? "";
        address2 =
            "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}, ${place.administrativeArea}, ${place.name}, ${place.subLocality}, ${place.subThoroughfare}";
        address = " ${place.locality}, ${place.administrativeArea}";
        emit(GetCurrentLocationAddressState());
      } else {
        emit(ErrorCurrentLocationAddressState());
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      emit(ErrorCurrentLocationAddressState());
    }
    print(country);
    print(city);
    print(address);
    print(address2);
  }

//create client
  CreateOrderModel? createOrderModel;
  void createClient(BuildContext context) async {
    AppWidget.createProgressDialog(context, "جاري التحميل");
    emit(CreateClientLoading());
    final result = await api.createPartner(
        name: clientNameController.text,
        mobile: phoneController.text,
        street: addressController.text,
        email: emailController.text,
        lat: double.parse(currentLocation?.latitude.toString() ?? ""),
        long: double.parse(currentLocation?.longitude.toString() ?? ""));
    result.fold((l) {
      Navigator.pop(context);
      errorGetBar("حدث خطأ ما");

      emit(CreateClientError());
    }, (r) {
      Navigator.pop(context);
      if (r.result != null) {
        if (r.result!.message != null) {
          // successGetBar(r.result!.message);
          successGetBar("add_client".tr());
          createOrderModel = r;
          getAllPartnersForReport();
          clientNameController.clear();
          phoneController.clear();
          addressController.clear();
          emailController.clear();
          emit(CreateClientLoaded());
          Navigator.pop(context);
        } else {
          emit(CreateClientError());

          errorGetBar("حدث خطأ ما");
        }
      }
    }
        //!}
        );
  }

  // getPartnerDetails
  PartnerModel? partnerModel;
  void getPartenerDetails({required int id}) async {
    emit(ProfileClientLoading());
    final result = await api.getPartnerDetails(partnerId: id);
    result.fold(
      (failure) => emit(ProfileClientError()),
      (r) {
        partnerModel = r;
        debugPrint("the model : ${partnerModel?.name?.toString()}");
        nameController.text = r.name.toString();
        phoneController.text = r.phone.toString();
        selectedBase64String = r.image != null ? r.image.toString() : "";
        emit(ProfileClientLoaded());
      },
    );
  }

  DefaultModel? defaultModel;
  void updatePartenerLocation(
    BuildContext context, {
    required int id,
    required double partnerLattitude,
    required String street,
    required double partnerLangitude,
  }) async {
    emit(ProfileClientLoading());
    final result = await api.updatePartenerLocation(
      id: id,
      partnerLangitude: partnerLangitude,
      partnerLattitude: partnerLattitude,
      street: street,
    );
    result.fold(
      (failure) {
        Navigator.pop(context);
        emit(ProfileClientError());
      },
      (r) {
        Navigator.pop(context);

        if (r.result != null) {
          if (r.result.toString() == "true") {
            successGetBar("تم تحديث الموقع بنجاح");
            getPartenerDetails(id: id);
          }
        }

        emit(ProfileClientLoaded());
      },
    );
  }

  void updatePartenerDetails(
    BuildContext context, {
    required int id,
  }) async {
    emit(ProfileClientLoading());
    final result = await api.updatePartenerDetails(
      image1920: selectedBase64String,
      name: nameController.text,
      phone: phoneController.text,
      id: id,
    );
    result.fold(
      (failure) {
        Navigator.pop(context);
        emit(ProfileClientError());
      },
      (r) {
        Navigator.pop(context);

        if (r.result != null) {
          if (r.result.toString() == "true") {
            successGetBar("تم تحديث البيانات بنجاح");
            getPartenerDetails(id: id);
            nameController.clear();
            phoneController.clear();
          }
        }

        emit(ProfileClientLoaded());
      },
    );
  }
  //location
  // double? lat;
  // double? lang;
  // Future<void> getLatLong() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     lat = position.latitude;
  //     lang = position.longitude;

  //     print('laaaaaaaaaaaaaa : $lat');
  //     print('laaaaaaaaaaaaaa : $lang');
  //     // await getAddress(lat: position.latitude, lang: position.longitude);
  //   } catch (e) {
  //     print('laaaaaaaaaaaaaa Error getting location: $e');
  //   }
  //   emit(GetLatLongSuccess());
  // }

  DateTime convertTimestampToDateTime(int timestamp) {
    //1650265974
    //1713736800000
    if (timestamp.toString().length > 11) {
      var dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return dt;
    } else {
      var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return dt;
    }
  }

  void openGoogleMapsRoute(double originLat, double originLng,
      double destinationLat, double destinationLng) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&origin=$originLat,$originLng&destination=$destinationLat,$destinationLng';

    try {
      launchUrl(Uri.parse(url));
    } catch (e) {
      errorGetBar("error from map");
    }
  }

  //get from search
  void getFromSearch() async {
    emit(SearchLoading());
    final result = await api.searchUsers(
        page: 1, name: searchController.text.toString() ?? "");
    result.fold(
      (failure) => emit(SearchError(error: 'Error loading data: $failure')),
      (r) {
        allPartnersModel = r;
        emit(SearchLoaded());
      },
    );
  }

  onChangeSearch(String? value) {
    EasyDebounce.debounce(
        'my-debouncer', // <-- An ID for this particular debouncer
        Duration(milliseconds: 100), // <-- The debounce duration
        () => getFromSearch() // <-- The target method
        );
    emit(SearchLoaded());
  }
}

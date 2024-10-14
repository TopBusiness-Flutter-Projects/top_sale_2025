import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:top_sale/core/utils/assets_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/get_size.dart';
import '../../../core/widgets/network_image.dart';
import 'list_tile_menu_widget.dart';

class MenuScreenWidget extends StatelessWidget {
  const MenuScreenWidget({Key? key, required this.closeClick})
      : super(key: key);

  final VoidCallback closeClick;

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: lang == 'en' ? Radius.circular(60) : Radius.zero,
        bottomLeft: lang == 'ar' ? Radius.circular(60) : Radius.zero,
      ),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.blue,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: getSize(context) / 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, Routes.profileScreen);
                        },
                        child: ManageNetworkImage(
                          imageUrl:
                              'https://images.pexels.com/photos/28492538/pexels-photo-28492538/free-photo-of-close-up-of-a-purple-aster-in-autumn-bloom.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                          width: 60.w,
                          height: 60.w,
                          borderRadius: getSize(context),
                        ),
                      ),
                      SizedBox(width: getSize(context) / 66),
                      Container(
                        alignment: lang == 'ar'
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        padding: EdgeInsets.only(
                          left: lang == 'ar' ? getSize(context) / 5 : 0,
                        ),
                        child: Text(
                          'ahmed elsapagh',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: getSize(context) / 4),
                    ],
                  ),
                  MenuListTileWidget(
                    iconPath: ImageAssets.profileIcon,
                    onclick: () {
                      Navigator.pushNamed(context, Routes.profileRoute);
                    },
                    title: 'profile'.tr(),
                  ),
                  MenuListTileWidget(
                    iconPath: ImageAssets.shareIcon,
                    onclick: () async {
                      PackageInfo packageInfo =
                          await PackageInfo.fromPlatform();
                      String url = '';
                      String packageName = packageInfo.packageName;
                      if (Platform.isAndroid) {
                        url =
                            "https://play.google.com/store/apps/details?id=$packageName";
                      } else if (Platform.isIOS) {
                        url = 'https://apps.apple.com/us/app/$packageName';
                      }
                      await Share.share(url);
                    },
                    title: 'share_app'.tr(),
                  ),
                  MenuListTileWidget(
                    iconPath: ImageAssets.evaluate,
                    onclick: () async {
                      PackageInfo packageInfo =
                          await PackageInfo.fromPlatform();
                      String url = '';
                      String packageName = packageInfo.packageName;

                      if (Platform.isAndroid) {
                        url =
                            "https://play.google.com/store/apps/details?id=$packageName";
                      } else if (Platform.isIOS) {
                        url = 'https://apps.apple.com/us/app/$packageName';
                      }
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    title: 'evaluate_the_application'.tr(),
                  ),
                  MenuListTileWidget(
                    iconPath: ImageAssets.contactIcon,
                    onclick: () {
                      Navigator.pushNamed(context, Routes.contactRoute);
                    },
                    title: 'contact'.tr(),
                  ),
                  MenuListTileWidget(
                    iconPath: ImageAssets.editIcon,
                    onclick: () {
                      Navigator.pushNamed(context, Routes.updateprofileRoute);
                    },
                    title: 'edit'.tr(),
                  ),
                  MenuListTileWidget(
                    iconPath: ImageAssets.deleteIcon,
                    onclick: () {},
                    title: 'delete'.tr(),
                  ),
                  MenuListTileWidget(
                    iconPath: ImageAssets.logoutIcon,
                    onclick: () {},
                    title: 'logout'.tr(),
                  ),
                ],
              ),
            ),
          ),
          
          Positioned(
            top: MediaQuery.of(context).size.height / 7,
            right: lang == 'en' ? -40 : null,
            left: lang == 'ar' ? -40 : null,
            child: Container(
              width: getSize(context) / 2.8,
              height: getSize(context) / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getSize(context) / 8),
                color: AppColors.white,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: closeClick,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Container(
                          width: getSize(context) / 6.2,
                          height: getSize(context) / 6.2,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(getSize(context) / 6.2),
                            color: AppColors.orangeThirdPrimary,
                          ),
                          child: Center(
                            child: Icon(
                              lang == 'ar'
                                  ? Icons.arrow_back
                                  : Icons.arrow_forward,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}

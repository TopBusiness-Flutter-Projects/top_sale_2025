import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';

import '../../../core/utils/get_size.dart';
import '../../../core/widgets/network_image.dart';

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
            backgroundColor: AppColors.primary,
            body: SafeArea(
              child: Column(
                children: [],
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

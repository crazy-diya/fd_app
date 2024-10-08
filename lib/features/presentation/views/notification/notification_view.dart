import 'package:fd_app/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 16, bottom: 10, right: 16),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    color: AppColors.colorBlack,
                    size: 32,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.notificationIcon,
                      width: 98.w,
                      height: 98.w,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      AppStrings.notificationViewTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                        color: AppColors.notificationTitleFontColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      AppStrings.notificationViewDesc,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.fontColorGray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 48,
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          AppColors.floatingActionButtonColor,
                        ),
                      ),
                      onPressed: () async {
                        await requestNotificationPermissions(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.continueButton,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: AppColors.fontButtonColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> requestNotificationPermissions(BuildContext context) async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      Navigator.pushReplacementNamed(context, Routes.kDashboardView);
    } else if (status.isDenied) {
      await Permission.notification.request();
      print("NO");
    } else if (status.isPermanentlyDenied) {
      print("NOOOOO");
      await openAppSettings();
    }
  }
}

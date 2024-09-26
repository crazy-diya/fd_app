import 'dart:async';

import 'package:fd_app/core/services/dependency_injection.dart';
import 'package:fd_app/core/services/secure_storage.dart';
import 'package:fd_app/utils/app_colors.dart';
import 'package:fd_app/utils/app_images.dart';
import 'package:fd_app/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final secureStorage = injection.call<SecureStorage>();

  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () {
        Navigator.pushReplacementNamed(context, Routes.kUserDetailsView);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBlack,
      body: Center(
        child: SvgPicture.asset(
          AppImages.appLogo,
          width: 134.26.w,
          height: 74.8.h,
        ),
      ),
    );
  }
}

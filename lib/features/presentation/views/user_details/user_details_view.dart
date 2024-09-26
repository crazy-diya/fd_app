import 'package:fd_app/utils/app_colors.dart';
import 'package:fd_app/utils/app_strings.dart';
import 'package:fd_app/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../core/services/secure_storage.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({super.key});

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final _formKey = GlobalKey<FormState>();
  final secureStorage = injection.call<SecureStorage>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.legalName,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30.sp,
                    color: AppColors.colorBlack,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  AppStrings.userDetailDesc,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: AppColors.fontColorGray,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    hintText: AppStrings.firstNameHint,
                    hintStyle: TextStyle(
                      color: AppColors.textFieldHint,
                    ),
                  ),
                  onChanged: (value) {
                    _formKey.currentState?.validate();
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your First Name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    hintText: AppStrings.lastNameHint,
                    hintStyle: TextStyle(
                      color: AppColors.textFieldHint,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Last Name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _formKey.currentState?.validate();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () {
            if (_formKey.currentState?.validate() == true) {
              storeDataLocalStorage();
            }
          },
          child: CircleAvatar(
            backgroundColor: (_formKey.currentState?.validate() == true)
                ? AppColors.floatingActionButtonColor
                : AppColors.floatingActionButtonColor.withOpacity(.2),
            radius: 30.w,
            child: const Icon(
              Icons.navigate_next_rounded,
              color: AppColors.fontColorWhite,
            ),
          ),
        ),
      ),
    );
  }

  storeDataLocalStorage() async {
    await secureStorage.setData(KEY_2, _firstNameController.text);
    await secureStorage.setData(KEY_3, _lastNameController.text);
    Navigator.pushNamed(context, Routes.kNotificationView);
  }
}

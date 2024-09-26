import 'package:fd_app/features/presentation/bloc/dashboard_cubit.dart';
import 'package:fd_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../core/services/secure_storage.dart';
import '../../../../utils/app_strings.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final _bloc = injection.call<DashboardCubit>();
  final secureStorage = injection.call<SecureStorage>();

  String? _firstName;

  @override
  void initState() {
    // TODO: implement initState
    loadLocalData();
    _bloc.getDashBoardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.colorBlack,
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<DashboardCubit, DashboardState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is DashboardSuccessState) {
              print("Success");
            } else if (state is ApiLoadingState) {
              print("LOADING");
            }
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: AppColors.dashboardTopLayerColor,
                  height: 181.w,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 20.h),
                  child: Column(
                    children: [
                      Text(
                        "${AppStrings.hey} $_firstName",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 32.sp,
                          color: AppColors.fontColorWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Expanded(child: Text("data")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadLocalData() async {
    if (await secureStorage.hasData(KEY_2)) {
      _firstName = (await secureStorage.getData(KEY_2))!;
      setState(() {});
    } else {
      _firstName = "Unknown";
      setState(() {});
    }
  }
}

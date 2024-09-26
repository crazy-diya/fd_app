import 'package:fd_app/features/presentation/bloc/dashboard_cubit.dart';
import 'package:fd_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../core/services/secure_storage.dart';
import '../../../../utils/app_extentions.dart';
import '../../../../utils/app_strings.dart';
import '../../../data/model/market_news_response_model.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final _bloc = injection.call<DashboardCubit>();
  final secureStorage = injection.call<SecureStorage>();
  List<MarketNewsResponseModel>? marketNewsList;
  String? _firstName;
  bool? showError = false;

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
      backgroundColor: AppColors.colorBlack,
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<DashboardCubit, DashboardState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is DashboardSuccessState) {
              setState(() {
                marketNewsList = state.marketNewsList;
              });
            }
            // else if (state is ApiLoadingState) {
            //   showProgressBar(context);
            // }
            else if (state is ApiFailureState) {
              setState(() {
                showError = true;
              });
            } else if (state is ServerFailureState) {
              setState(() {
                showError = true;
              });
            } else if (state is ConnectionFailureState) {
              setState(() {
                showError = true;
              });
            } else if (state is DioExceptionFailureState) {
              setState(() {
                showError = true;
              });
            }
          },
          child: Dismissible(
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              Navigator.pop(context);
            },
            key: const Key('seconPage'),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppStrings.hey} $_firstName",
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w900,
                            fontSize: 32.sp,
                            color: AppColors.fontColorWhite,
                          ),
                          // style: TextStyle(
                          //   fontWeight: FontWeight.w900,
                          //   fontSize: 32.sp,
                          //   color: AppColors.fontColorWhite,
                          // ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        marketNewsList != null
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: marketNewsList!.length,
                                  itemBuilder: (context, index) => Container(
                                    padding: EdgeInsets.symmetric(vertical: 16.w),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          marketNewsList![index].image!,
                                          height: 100.w,
                                          width: 100.w,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    marketNewsList![index].source!.toUpperCase(),
                                                    style: GoogleFonts.rubik(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12.sp,
                                                      color: AppColors.fontColorWhite.withOpacity(0.7),
                                                    ),
                                                  ),
                                                  Text(
                                                    marketNewsList![index]
                                                        .datetime!
                                                        .toInt()
                                                        .convertTimestampToData()
                                                        .toUpperCase(),
                                                    style: GoogleFonts.rubik(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12.sp,
                                                      color: AppColors.fontColorWhite.withOpacity(0.7),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.w,
                                              ),
                                              Text(
                                                marketNewsList![index].headline!,
                                                textAlign: TextAlign.start,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20.sp,
                                                  color: AppColors.fontColorWhite,
                                                  height: 1.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : showError != true
                                ? Expanded(
                                    child: Center(
                                      child: SizedBox(
                                        height: 40.w,
                                        width: 40.w,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Text(
                                    AppStrings.somethingWentWrong,
                                    style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: AppColors.fontColorWhite,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showProgressBar(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Center(
        child: SizedBox(
          height: 40.w,
          width: 40.w,
          child: const CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    },
  );
}
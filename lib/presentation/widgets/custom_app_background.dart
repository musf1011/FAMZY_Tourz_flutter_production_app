// created by: FAMZY CodeWorks
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  // final PreferredSizeWidget? appBar; //in case some screens need an AppBar

  const AppBackground({
    super.key,
    required this.child,
    // this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_app.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: child,
      ),
    );
  }
}

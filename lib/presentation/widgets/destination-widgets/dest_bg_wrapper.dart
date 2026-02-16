import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DestinationBackgroundWrapper extends StatelessWidget {
  final String imagePath;
  final Widget? destinationName;
  final String? titleText;
  final Widget child;

  final Future<void> Function()? onRefresh; // If null, no RefreshIndicator
  final List<Widget>? actions; //  For icons like the "Add" button
  final VoidCallback? onBackTap;

  const DestinationBackgroundWrapper({
    super.key,
    required this.imagePath,
    required this.child,
    this.destinationName,
    this.titleText,
    this.onRefresh,
    this.actions,
    this.onBackTap,
  }) : assert(
         destinationName != null || titleText != null,
         'Must provide either destinationName or titleText',
       );

  @override
  Widget build(BuildContext context) {
    // Determine the main content
    final Widget mainContent = Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConstants.primaryTransGColor,
              AppConstants.blackColorP5,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 45.r,
                      color: AppConstants.whiteColorP5,
                    ),
                    onPressed: onBackTap ?? () => NavigationService().pop(),
                  ),
                  // Only render if screen provides actions
                  if (actions != null) Row(children: actions!),
                ],
              ),
              destinationName ??
                  Text(
                    titleText!,
                    style: AppConstants.destNameTextStyle,
                    textAlign: .center, // Using the global theme we set up!
                  ),

              // destinationName,
              Expanded(
                child: child,
              ), // This is where the unique screen content goes
            ],
          ),
        ),
      ),
    );

    // If onRefresh is provided, wrap with RefreshIndicator
    return Scaffold(
      // jumping when the keyboard appears
      // resizeToAvoidBottomInset: false,
      body: onRefresh != null
          ? RefreshIndicator(
              color: AppConstants.primaryColor,
              backgroundColor: AppConstants.whiteColorP5,
              onRefresh: onRefresh!,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: mainContent,
              ),
            )
          : mainContent,
    );
  }
}

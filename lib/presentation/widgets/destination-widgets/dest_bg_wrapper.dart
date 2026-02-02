import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DestinationBackgroundWrapper extends StatelessWidget {
  final String imagePath;
  final String destinationName;
  final Widget child;
  final Future<void> Function()?
  onRefresh; // Optional: If null, no RefreshIndicator
  final List<Widget>? actions; // Optional: For icons like the "Add" button
  final VoidCallback? onBackTap;

  const DestinationBackgroundWrapper({
    super.key,
    required this.imagePath,
    required this.destinationName,
    required this.child,
    this.onRefresh,
    this.actions,
    this.onBackTap,
  });

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
              AppConstants.secondaryTransGColor,
              AppConstants.blackColorP7,
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
                      size: 40.h,
                      color: AppConstants.whiteColorP5,
                    ),
                    onPressed:
                        onBackTap ??
                        () =>
                            NavigationService().pop(), // <--- 3. Use logic here
                  ),
                  // Only render if screen provides actions
                  if (actions != null) Row(children: actions!),
                ],
              ),
              Text(
                destinationName,
                style: AppConstants.destNameTextStyle,
                textAlign: .center, // Using the global theme we set up!
              ),

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

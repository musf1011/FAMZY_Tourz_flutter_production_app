// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/destination_model.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../data/services/navigation_service.dart';

class DestinationsScreen extends StatelessWidget {
  const DestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DestinationsProvider>();
    final destinations = provider.destinations;

    return Scaffold(
      body: PageView.builder(
        // controller: provider.pageController,
        controller: PageController(initialPage: provider.currentIndex),
        scrollDirection: Axis.vertical,
        itemCount: destinations.length,
        onPageChanged: provider.onPageChanged,
        itemBuilder: (_, index) {
          final destination = destinations[index];
          return _DestinationPage(
            destination: destination,
            isActive: provider.currentIndex == index,
            index: index, // Pass the actual page index
            totalCount: destinations.length, // Pass total count for dots
          );
        },
      ),
    );
  }
}

class _DestinationPage extends StatefulWidget {
  final DestinationModel destination;
  final bool isActive;
  final int index;
  final int totalCount;

  const _DestinationPage({
    required this.destination,
    required this.isActive,
    required this.index,
    required this.totalCount,
  });

  @override
  State<_DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<_DestinationPage> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final nav = NavigationService();

    return Container(
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.destination.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
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
        child: Row(
          children: [
            Expanded(
              flex: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.destination.name,
                    style: AppConstants.destNameTextStyle,
                  ),
                  SizedBox(height: 20.h),

                  Text(
                    widget.destination.shortDescription,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppConstants.whiteColorP9,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  AnimatedCrossFade(
                    firstChild: Text(
                      widget.destination.fullDescription,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    ),
                    secondChild: Text(
                      widget.destination.fullDescription,
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    ),
                    crossFadeState: expanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 250),
                  ),

                  GestureDetector(
                    onTap: () => setState(() => expanded = !expanded),
                    child: Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Text(
                        expanded ? 'Show less' : 'Read more',
                        style: TextStyle(
                          color: expanded
                              ? AppConstants.famzyGold
                              : AppConstants.googleBlue,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  CustomLoadingButton(
                    onPressed: () {
                      nav.navigateTo(AppRoutes.packages);
                    },
                    text: 'View Packages',
                  ),
                ],
              ),
            ),
            const Spacer(),
            //page slider dots
            Padding(
              padding: EdgeInsets.only(top: 0.05.sh, right: 0.05.sw),
              child: Column(
                children: List.generate(
                  widget.totalCount,
                  (indexDots) => Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    height: widget.index == indexDots ? 25.h : 7.h,
                    width: 7.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: widget.index != indexDots
                          ? AppConstants.tertiaryColor
                          : AppConstants.whiteColorP5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

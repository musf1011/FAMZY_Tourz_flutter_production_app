// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/destination_model.dart';
import 'package:famzy_tourz_v2/presentation/providers/desstinations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/services/navigation_service.dart';
import '../../../routes/app_routes.dart';

class DestinationsScreen extends StatelessWidget {
  const DestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DestinationsProvider>();
    final destinations = provider.destinations;

    return Scaffold(
      body: PageView.builder(
        controller: provider.pageController,
        scrollDirection: Axis.vertical,
        itemCount: destinations.length,
        onPageChanged: provider.onPageChanged,
        itemBuilder: (_, index) {
          final destination = destinations[index];
          return _DestinationPage(
            destination: destination,
            isActive: provider.currentIndex == index,
          );
        },
      ),
    );
  }
}

class _DestinationPage extends StatefulWidget {
  final DestinationModel destination;
  final bool isActive;

  const _DestinationPage({required this.destination, required this.isActive});

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
            colors: [AppConstants.blackColorP5, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.destination.name,
              style: TextStyle(
                fontSize: 38.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),

            Text(
              widget.destination.shortHighlight,
              style: TextStyle(fontSize: 14.sp, color: Colors.white70),
            ),

            SizedBox(height: 12.h),

            AnimatedCrossFade(
              firstChild: Text(
                widget.destination.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
              secondChild: Text(
                widget.destination.description,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
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
                    color: AppConstants.primaryColor,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  // nav.navigate(
                  //   AppRoutes.packages,
                  //   arguments: widget.destination,
                  // );
                },
                child: const Text('View Packages'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

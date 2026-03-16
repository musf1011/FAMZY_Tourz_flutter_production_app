import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SeatCountContainer extends StatelessWidget {
  const SeatCountContainer({super.key, required this.bookingProvider});

  final BookingProvider bookingProvider;
  // final isMaxReached =
  //   provider.seatCount >= provider.package!.availableSeats ||
  //   provider.seatCount >= 5;

  @override
  Widget build(BuildContext context) {
    final availableSeats = bookingProvider.package?.availableSeats ?? 0;
    final isMaxReached =
        bookingProvider.seatCount >= availableSeats ||
        bookingProvider.seatCount >= 5;
    if (bookingProvider.package == null) return const SizedBox.shrink();
    return Container(
      width: 0.6.sw,
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      decoration: BoxDecoration(
        color: AppConstants.primaryTransGColor,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Colors.white, width: .5.w),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            'Seats:',
            style: GoogleFonts.roboto(
              fontSize: 18.sp,
              color: AppConstants.famzyGold,
            ),
          ),
          SizedBox(width: 10.w),
          IconButton(
            onPressed: () {
              debugPrint('****seat decreased  ');
              bookingProvider.decreaseSeat();
            },
            icon: const Icon(Icons.remove_circle, color: AppConstants.lightRed),
          ),
          Text(
            '${bookingProvider.seatCount}',
            style: GoogleFonts.roboto(fontSize: 20.sp, color: Colors.white),
          ),
          IconButton(
            onPressed: isMaxReached
                ? null
                : () {
                    bookingProvider.increaseSeat();
                  },
            icon: const Icon(Icons.add_circle, color: AppConstants.lightGreen),
          ),
        ],
      ),
    );
  }
}

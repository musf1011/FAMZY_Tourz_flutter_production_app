import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/company_model.dart';
import 'package:famzy_tourz_v2/presentation/providers/company_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_background_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/package_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompanyDetailScreen extends StatefulWidget {
  final CompanyModel company;

  const CompanyDetailScreen({super.key, required this.company});

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CompanyProvider>().listenToCompanyPackages(
        widget.company.companyId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.company.companyName,
          style: AppConstants.appBarTextStyle,
        ),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: CustomBackgroundWrapper(
        imagePath:
            'assets/images/bg-mainscreen.jpg', // Or company specific background if you have one
        child: Column(
          children: [
            // Company Info Header
            Container(
              padding: EdgeInsets.all(16.w),
              color: AppConstants.primaryTransGColor,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundImage:
                        widget.company.companyLogoUrl != null &&
                            widget.company.companyLogoUrl!.isNotEmpty
                        ? NetworkImage(widget.company.companyLogoUrl!)
                        : null,
                    backgroundColor: AppConstants.secondaryColor,
                    child:
                        widget.company.companyLogoUrl == null ||
                            widget.company.companyLogoUrl!.isEmpty
                        ? Icon(Icons.business, color: Colors.white, size: 40.sp)
                        : null,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.company.companyName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        if (widget.company.phone.isNotEmpty)
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.white70,
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                widget.company.phone,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        if (widget.company.email.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.white70,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Text(
                                    widget.company.email,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12.sp,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Description
            if (widget.company.companyDescription.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  widget.company.companyDescription,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.justify,
                ),
              ),

            Divider(color: Colors.white24, thickness: 1.h, height: 1.h),

            // Packages List
            Expanded(
              child: Consumer<CompanyProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoadingPackages) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final packages = provider.companyPackages;

                  if (packages.isEmpty) {
                    return Center(
                      child: Text(
                        'No packages available from this company yet.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(8.w),
                    itemCount: packages.length,
                    itemBuilder: (context, index) {
                      return PackageCard(packages[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/company_model.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/company_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_background_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_app_confirm_dialog.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<CompanyProvider>();
      if (provider.companies.isEmpty) {
        provider.listenToActiveCompanies();
        if (context.read<UserProvider>().isAdmin ?? false) {
          provider.listenToInActiveCompanies();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.read<UserProvider>().isAdmin ?? false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Partners', style: AppConstants.appBarTextStyle),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: CustomBackgroundWrapper(
        imagePath: AppConstants.mainScreenBgImage,
        child: Consumer<CompanyProvider>(
          builder: (context, provider, child) {
            final companies = provider.companies;
            if (companies.isEmpty) {
              return const Center(
                child: Text(
                  'No companies available yet.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: companies.length,
              itemBuilder: (context, index) {
                final company = companies[index];
                return _CompanyCard(company: company, isAdmin: isAdmin);
              },
            );
          },
        ),
      ),
    );
  }
}

class _CompanyCard extends StatelessWidget {
  final CompanyModel company;
  final bool isAdmin;
  const _CompanyCard({required this.company, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    final bool isActive = company.isActive;
    final companyProvider = context.read<CompanyProvider>();
    return Card(
      color: AppConstants.primaryTransGColor,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: ListTile(
        contentPadding: EdgeInsets.all(12.w),
        leading: CircleAvatar(
          radius: 30.r,
          backgroundImage:
              company.companyLogoUrl != null &&
                  company.companyLogoUrl!.isNotEmpty
              ? NetworkImage(company.companyLogoUrl!)
              : null,
          backgroundColor: AppConstants.secondaryColor,
          child:
              company.companyLogoUrl == null || company.companyLogoUrl!.isEmpty
              ? Icon(Icons.business, color: Colors.white, size: 30.sp)
              : null,
        ),
        title: Row(
          mainAxisAlignment: .spaceBetween,
          // crossAxisAlignment: .start,
          children: [
            SizedBox(
              width: 170.w,
              child: Text(
                company.companyName,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            isAdmin
                ?
                  // ? SizedBox(
                  //     height: 40.h,
                  //     width: 120.w,
                  //     child: SwitchListTile(
                  //       title: const Text(
                  //         'Active',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       value: isActive,
                  //       activeThumbColor: AppConstants.tertiaryColor,
                  //       activeTrackColor: AppConstants.secondaryColor,
                  //       inactiveThumbColor: AppConstants.transGrey,
                  //       inactiveTrackColor: AppConstants.transGrey,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         side: BorderSide(
                  //           color: AppConstants.tertiaryColor,
                  //           width: 1.w,
                  //         ),
                  //       ),
                  //       // onChanged: (val) => setState(() => isActive = val),
                  //       onChanged: (v) {},
                  //     ),
                  //   )
                  Row(
                    children: [
                      Text(
                        'Active',
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                      Switch(
                        value: isActive,
                        onChanged: (value) {
                          //pop up to confirm status change, then call provider method to update status in firestore
                          AppConfirmDialog.show(
                            context,
                            title: 'Update Status',
                            message:
                                'Are you sure you want to ${value ? 'activate' : 'deactivate'} this company?',
                            confirmText: value ? 'Activate' : 'Deactivate',
                            cancelText: 'Cancel',
                            icon: Icons.warning_amber_rounded,
                            iconColor: AppConstants.transRColor,
                          ).then((confirmed) {
                            if (confirmed == true) {
                              companyProvider.updateCompanyStatus(
                                company.companyId,
                                value,
                              );
                            }
                          });
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
        subtitle: Text(
          company.companyDescription,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white70, fontSize: 13.sp),
        ),
        // trailing: Icon(
        //   Icons.arrow_forward_ios,
        //   color: Colors.white,
        //   size: 16.sp,
        // ),
        horizontalTitleGap: 4.w,

        // focusColor: AppConstants.tertiaryColor,
        // selectedColor: AppConstants.tertiaryColor,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CompanyDetailScreen(company: company),
          //   ),
          // );
          NavigationService().navigateTo(
            AppRoutes.companyDetailScreen,
            arguments: company,
          );
        },
      ),
    );
  }
}

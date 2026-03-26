import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/company_model.dart';
import 'package:famzy_tourz_v2/presentation/providers/company_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_background_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/company_detail_screen.dart';
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
        provider.listenToCompanies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Partners', style: AppConstants.appBarTextStyle),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: CustomBackgroundWrapper(
        imagePath: 'assets/images/bg-mainscreen.jpg',
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
                return _CompanyCard(company: company);
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

  const _CompanyCard({required this.company});

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          company.companyName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          company.companyDescription,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white70, fontSize: 13.sp),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 16.sp,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompanyDetailScreen(company: company),
            ),
          );
        },
      ),
    );
  }
}

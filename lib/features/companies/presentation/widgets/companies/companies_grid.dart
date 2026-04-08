import 'package:flutter/material.dart';
import 'package:pharmacist/features/companies/domain/models/company_model.dart';
import 'package:pharmacist/features/companies/presentation/screens/company_products_screen.dart';
import 'package:pharmacist/features/companies/presentation/widgets/company_card.dart';

class CompaniesGrid extends StatelessWidget {
  final List<CompanyModel> companies;

  const CompaniesGrid({super.key, required this.companies});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        int crossAxisCount;
        if (width >= 1200) {
          crossAxisCount = 5;
        } else if (width >= 900) {
          crossAxisCount = 4;
        } else if (width >= 600) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 2;
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.9,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: companies.length,
          itemBuilder: (context, index) {
            final company = companies[index];

            return CompanyCard(
              company: company,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CompanyProductsScreen(
                      companyId: company.id,
                      companyName: company.name,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

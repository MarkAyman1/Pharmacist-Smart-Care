import 'package:flutter/material.dart';
import 'package:pharmacist/features/companies/domain/models/company_model.dart';
import 'package:pharmacist/features/companies/presentation/widgets/company_card.dart';
import 'package:pharmacist/features/companies/presentation/screens/company_products_screen.dart';

class CompaniesGrid extends StatelessWidget {
  final List<Company> companies;

  const CompaniesGrid({super.key, required this.companies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies[index];
        return CompanyCard(
          name: company.name,
          imageUrl: company.imageUrl,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CompanyProductsScreen(
                  companyName: company.name,
                  products: company.products,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
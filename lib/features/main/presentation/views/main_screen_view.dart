import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/features/categories/presentation/screens/categories_screen.dart';
import 'package:pharmacist/features/companies/presentation/screens/companies_screen.dart';
import 'package:pharmacist/features/main/presentation/cubits/navigationcubit%20.dart';
import 'package:pharmacist/main.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = const [
      CategoriesScreen(),
      CompaniesScreen(),
      MyHomePage(title: 'home'),
    ];

    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: IndexedStack(index: currentIndex, children: _screens),
            bottomNavigationBar: ConvexAppBar(
              style: TabStyle.reactCircle,
              backgroundColor: AppColors.primaryblue,
              color: AppColors.white,
              elevation: 12,
              curveSize: 90,
              height: 65,
              initialActiveIndex: currentIndex,
              onTap: (index) =>
                  context.read<NavigationCubit>().changeIndex(index),
              activeColor: Colors.white,
              gradient: LinearGradient(
                colors: [AppColors.accentGreen, AppColors.primaryLightColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              items: const [
                TabItem(icon: LineIcons.box, title: 'categories'),
                TabItem(icon: LineIcons.productHunt, title: 'products'),
                TabItem(icon: LineIcons.plusCircle, title: 'Add product'),
                TabItem(icon: LineIcons.receipt, title: 'Orders'),
              ],
            ),
          );
        },
      ),
    );
  }
}

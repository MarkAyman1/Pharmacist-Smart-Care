import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dio/dio.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pharmacist/core/api/dio_consumer.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/core/features/profile_drawer/blocs/profile_bloc.dart';
import 'package:pharmacist/core/features/profile_drawer/repositories/profile_repository.dart';
import 'package:pharmacist/core/widgets/profile_drawer.dart';
import 'package:pharmacist/features/Search/presentation/screen/search_screen.dart';
import 'package:pharmacist/features/categories/presentation/screens/categories_screen.dart';
import 'package:pharmacist/features/companies/presentation/screens/companies_screen.dart';
import 'package:pharmacist/features/main/presentation/cubits/navigationcubit%20.dart';
import 'package:pharmacist/features/orders/presentation/screens/orders_screen.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screens = const [
      OrdersScreen(),
      CategoriesScreen(),
      CompaniesScreen(),
      SearchScreen(),
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(
          create: (_) => ProfileBloc(ProfileRepository(DioConsumer(Dio()))),
        ),
      ],
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return ProfileDrawer(
            child: Scaffold(
              body: IndexedStack(index: currentIndex, children: screens),
              bottomNavigationBar: ConvexAppBar(
                style: TabStyle.reactCircle,
                backgroundColor: !isDark
                    ? AppColors.primaryblue
                    : AppColors.darkBackground,
                color: AppColors.white,
                elevation: 12,
                curveSize: 90,
                height: 65,
                initialActiveIndex: currentIndex,
                onTap: (index) =>
                    context.read<NavigationCubit>().changeIndex(index),
                activeColor: !isDark
                    ? AppColors.white
                    : AppColors.primaryLightColor,
                gradient: LinearGradient(
                  colors: !isDark
                      ? [AppColors.accentGreen, AppColors.primaryLightColor]
                      : [
                          AppColors.secondaryDarkColor,
                          AppColors.primaryLightColor,
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                items: const [
                  TabItem(icon: LineIcons.receipt, title: 'Orders'),
                  TabItem(icon: LineIcons.box, title: 'categories'),
                  TabItem(icon: LineIcons.building, title: 'companies'),
                  TabItem(icon: LineIcons.search, title: 'Search'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

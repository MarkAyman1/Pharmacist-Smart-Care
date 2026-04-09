import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/Search/presentation/widgets/search_bar_widget.dart';
import 'package:pharmacist/features/Search/presentation/widgets/search_products_listener.dart';
import 'package:pharmacist/features/Search/presentation/widgets/search_results_widget.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_bloc.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_state.dart';

class ProductsSearchScreen extends StatefulWidget {
  const ProductsSearchScreen({super.key});

  @override
  State<ProductsSearchScreen> createState() =>
      _ProductsSearchScreenState();
}

class _ProductsSearchScreenState extends State<ProductsSearchScreen> {
  final TextEditingController controller = TextEditingController();

 // Inside _ProductsSearchScreenState in products_search_screen.dart

@override
Widget build(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Scaffold(
    appBar: AppThemes.customAppBar(
      title: "Search Products",
      isDarkMode: isDark,
    ),
    body: Container(
      decoration: AppBackground.decoration(isDark: isDark),
      child: Column(
        children: [
          SearchBarWidget(controller: controller),
          const SizedBox(height: 10),
          Expanded(
            // Use BlocListener to handle side-effects like SnackBar and refreshing
            child: BlocListener<ProductsBloc, ProductsState>(
              listener: (context, state) {
                // Pass the current text from the controller to refresh the search
                handleSearchProductsListener(context, state, controller.text);
              },
              child: BlocBuilder<ProductsBloc, ProductsState>(
                // We keep the builder for the UI logic
                buildWhen: (previous, current) => current is! StockUpdated, 
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductsSearchLoaded) {
                    return SearchResultsWidget(products: state.products);
                  }
                  if (state is ProductsError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(
                    child: Text("Start typing to search 🔍"),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
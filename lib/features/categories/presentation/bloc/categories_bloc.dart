import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/categories/domain/repo/categories_repository.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_event.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository repository;

  CategoriesBloc(this.repository) : super(CategoriesInitial()) {
    on<FetchCategoriesEvent>((event, emit) async {
      emit(CategoriesLoading());
      try {
        final categories = await repository.getCategories();
        emit(CategoriesLoaded(categories: categories));
      } catch (e) {
        emit(CategoriesError(message: e.toString()));
      }
    });
  }
}
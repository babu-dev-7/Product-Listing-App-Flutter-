import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/hive/hive_service.dart';
import '../../domain/usecases/get_products.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc(this.getProducts) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      final products = await getProducts();
      emit(ProductLoaded(products));
    });

    on<ToggleFavoriteEvent>((event, emit) {
      HiveService.toggleFavorite(event.id);

      if (state is ProductLoaded) {
        emit(ProductLoaded((state as ProductLoaded).products));
      }
    });
  }
}
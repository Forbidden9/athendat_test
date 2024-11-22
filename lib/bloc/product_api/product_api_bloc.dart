import 'package:athendat_test/database/product_dao.dart';
import 'package:athendat_test/models/product.dart';
import 'package:athendat_test/services/product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_api_event.dart';
part 'product_api_state.dart';

class ProductApiBloc extends Bloc<ProductApiEvent, ProductApiState> {
  final ProductDao productRepository;
  ProductApiBloc(this.productRepository) : super(ProductApiInitialState()) {
    on<GetProductApiEvent>((event, emit) async {
      emit(ProductApiLoadingState());
      try {
        final productInDB = await productRepository.getProducts();
        final productAPI = await ProductApiAdapter().fetchProducts();
        productAPI.removeWhere((prod) => productInDB.any((rev) => rev.id == prod.id));
        emit(ProductApiLoadedState(productAPI));
      } catch (e) {
        emit(ProductApiErrorState(e.toString()));
      }
    });

    on<CreateProductInDBEvent>((event, emit) async {
      try {
        await productRepository.createProduct(event.product);
        emit(ProductApiSuccessState());
        add(const GetProductApiEvent());
      } catch (e) {
        emit(ProductApiErrorState(e.toString()));
      }
    });
  }
}

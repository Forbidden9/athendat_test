import 'package:athendat_test/database/product_dao.dart';
import 'package:athendat_test/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_db_event.dart';
part 'product_db_state.dart';

class ProductDbBloc extends Bloc<ProductDbEvent, ProductDbState> {

  final ProductDao productRepository;
  ProductDbBloc(this.productRepository) : super(ProductDbInitial()) {
    on<GetProductDbEvent>((event, emit) async {
      try {
        emit(ProductDbLoadingState());
        List<Product> products = await productRepository.getProducts();
        emit(ProductDbLoadedState(products));
      } catch (e) {
        emit(ProductDbErrorState(e.toString()));
      }
    });
      
    on<DeleteProductDbEvent>((event, emit) async {
      try {
        await productRepository.deleteProduct(event.product.id!);
        emit(ProductDbSuccessState());        
        add(const GetProductDbEvent());
      } catch (e) {
        emit(ProductDbErrorState(e.toString()));
      }
    });
  }
}

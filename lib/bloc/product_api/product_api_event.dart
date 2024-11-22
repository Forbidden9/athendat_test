part of 'product_api_bloc.dart';

sealed class ProductApiEvent extends Equatable {
  const ProductApiEvent();

  @override
  List<Object> get props => [];
}

class GetProductApiEvent extends ProductApiEvent {
  const GetProductApiEvent();
  @override
  List<Object> get props => [];
}

class CreateProductInDBEvent extends ProductApiEvent {
  final Product product;
  const CreateProductInDBEvent(this.product);
  @override
  List<Object> get props => [product];
}

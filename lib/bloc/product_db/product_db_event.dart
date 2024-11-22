part of 'product_db_bloc.dart';

sealed class ProductDbEvent extends Equatable {
  const ProductDbEvent();

  @override
  List<Object> get props => [];
}

class GetProductDbEvent extends ProductDbEvent {
  const GetProductDbEvent();
  @override
  List<Object> get props => [];
}

class DeleteProductDbEvent extends ProductDbEvent {
  final Product product;
  const DeleteProductDbEvent(this.product);
  @override
  List<Object> get props => [product];
}
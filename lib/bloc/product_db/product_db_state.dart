part of 'product_db_bloc.dart';

sealed class ProductDbState extends Equatable {
  const ProductDbState();
  
  @override
  List<Object> get props => [];
}

final class ProductDbInitial extends ProductDbState {}

final class ProductDbLoadingState extends ProductDbState {}

final class ProductDbLoadedState extends ProductDbState {
  final List<Product> products;
  const ProductDbLoadedState(this.products);
  @override
  List<Object> get props => [products];
}

final class ProductDbSuccessState extends ProductDbState {
  @override
  List<Object> get props => [];
}

final class ProductDbErrorState extends ProductDbState {
  final String errorMessage;
  const ProductDbErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
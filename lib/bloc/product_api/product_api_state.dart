part of 'product_api_bloc.dart';

sealed class ProductApiState extends Equatable {
  const ProductApiState();
  
  @override
  List<Object> get props => [];
}

final class ProductApiInitialState extends ProductApiState {}

final class ProductApiLoadingState extends ProductApiState {
  @override
  List<Object> get props => [];
}

final class ProductApiLoadedState extends ProductApiState {
  final List products;
  const ProductApiLoadedState(this.products);
  @override
  List<Object> get props => [products];
}

final class ProductApiSuccessState extends ProductApiState {
  @override
  List<Object> get props => [];
}

final class ProductApiErrorState extends ProductApiState {
  final String errorMessage;
  const ProductApiErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
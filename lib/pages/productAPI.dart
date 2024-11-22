import 'package:athendat_test/bloc/product_api/product_api_bloc.dart';
import 'package:athendat_test/bloc/product_db/product_db_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductAPIScreen extends StatelessWidget {
  const ProductAPIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductApiBloc, ProductApiState>(
      listener: (context, state) async {
        if (state is ProductApiSuccessState) {
          context.read<ProductDbBloc>().add(const GetProductDbEvent());
        }
      },
      builder: (context, state) {
        if (state is ProductApiLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductApiLoadedState) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.products[index].title),
                subtitle: Text('\$${state.products[index].price.toStringAsFixed(2)}'),
                leading: Checkbox(
                  value: false, onChanged: (bool? value) {
                    if (value == true) {
                      context.read<ProductApiBloc>().add(CreateProductInDBEvent(state.products[index]));
                    }
                  },
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Error al cargar los productos en api'));
        }
      }
    );
  }
}
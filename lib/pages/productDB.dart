
import 'package:athendat_test/bloc/product_api/product_api_bloc.dart';
import 'package:athendat_test/bloc/product_db/product_db_bloc.dart';
import 'package:athendat_test/database/product_dao.dart';
import 'package:athendat_test/models/product.dart';
import 'package:athendat_test/utils/funct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductInDBScreen extends StatefulWidget {
  const ProductInDBScreen({super.key});

  @override
  State<ProductInDBScreen> createState() => _ProductInDBScreenState();
}

class _ProductInDBScreenState extends State<ProductInDBScreen> {
  static const _pageSize = 7;
  final PagingController<int, Product> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((_fetchPage));
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ProductDao().fetchProducts(pageKey, limit: _pageSize);
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDbBloc, ProductDbState>(
      listener: (context, state) {
        if (state is ProductDbSuccessState) {
          context.read<ProductApiBloc>().add(const GetProductApiEvent());
        }
      },
      builder: (context, state) {
        if (state is ProductDbLoadingState) {
          _pagingController.refresh();
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductDbLoadedState) {
          return PagedListView<int, Product>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Product>(
              animateTransitions: true,
              itemBuilder: (context, item, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      _showProductDialog(item, context);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(item.title!),
                        subtitle: Text('\$${item.price!.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          onPressed: (){
                            context.read<ProductDbBloc>().add(DeleteProductDbEvent(item));
                          },
                          icon: const Icon(Icons.delete)
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          );
        } else {
          return Container();
        }
      }
    );
  }

  void _showProductDialog(Product productosRevisado, context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(productosRevisado.title!),
          content: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 240,
                    width: 240,
                    child: Image.network(
                      productosRevisado.thumbnail!,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                          ),
                        );
                      }
                    ),
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      const Text("Category:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      const Gap(5),
                      Text(capitalize(productosRevisado.category!), style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      const Text("Price:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      const Gap(5),
                      Text('\$${productosRevisado.price!.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const Gap(5),
                  const Text("Description:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(productosRevisado.description!, style: const TextStyle(fontSize: 16))
                ],
              ),
            ]
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
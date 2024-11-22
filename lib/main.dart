import 'package:athendat_test/bloc/product_api/product_api_bloc.dart';
import 'package:athendat_test/bloc/product_db/product_db_bloc.dart';
import 'package:athendat_test/database/database_helper.dart';
import 'package:athendat_test/database/product_dao.dart';
import 'package:athendat_test/pages/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductApiBloc>(
          create: (BuildContext context) => ProductApiBloc(ProductDao())..add(const GetProductApiEvent())
        ),
        BlocProvider<ProductDbBloc>(
          create: (BuildContext context) => ProductDbBloc(ProductDao())..add(const GetProductDbEvent()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ATHENDAT',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, background: Colors.white),
          useMaterial3: true,
        ),
        home: const ProductPage()
      ),
    );
  }
}

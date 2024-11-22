import 'package:athendat_test/pages/productAPI.dart';
import 'package:athendat_test/pages/productDB.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pending Product'),
            Tab(text: 'Checked Product')
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ProductAPIScreen(),
          ProductInDBScreen()
        ]
      )
    );
  }
}

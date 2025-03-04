import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/fake_store_in_product.dart';

class FakeStoreInProductsScreen extends StatefulWidget {
  const FakeStoreInProductsScreen({super.key});

  @override
  State<FakeStoreInProductsScreen> createState() => _FakeStoreInProductsScreenState();
}

class _FakeStoreInProductsScreenState extends State<FakeStoreInProductsScreen> {
  late Future<List<FakeStoreInProduct>> _productsFuture;
  List<FakeStoreInProduct> _allProducts = [];
  List<FakeStoreInProduct> _filteredProducts = [];
  String _searchQuery = '';
  String? _selectedCategory;
  String _sortOption = 'Default';

  final List<String> _categories = [
    'All',
    'audio',
    'gaming',
    'mobile',
    'tv',
  ];

  final List<String> _sortOptions = [
    'Default',
    'Price: Low to High',
    'Price: High to Low',
    'Name: A-Z',
    'Name: Z-A',
  ];

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProducts();
  }

  Future<List<FakeStoreInProduct>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.in/api/products'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List productsJson = jsonResponse['products'];
      _allProducts = productsJson.map((product) => FakeStoreInProduct.fromJson(product)).toList();
      _filteredProducts = List.from(_allProducts);
      return _allProducts;
    } else {
      throw Exception('Failed to load products');
    }
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final matchesSearch = product.title.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesCategory = _selectedCategory == null || _selectedCategory == 'All' || product.category == _selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();

      switch (_sortOption) {
        case 'Price: Low to High':
          _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'Price: High to Low':
          _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'Name: A-Z':
          _filteredProducts.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'Name: Z-A':
          _filteredProducts.sort((a, b) => b.title.compareTo(a.title));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fake Store IN',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    _searchQuery = value;
                    _filterProducts();
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedCategory ?? 'All',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: _categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _selectedCategory = value;
                          _filterProducts();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _sortOption,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: _sortOptions.map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _sortOption = value!;
                          _filterProducts();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<FakeStoreInProduct>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredProducts.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      FakeStoreInProduct product = _filteredProducts[index];
                      return GestureDetector(
                        onTap: () => _showProductDialog(context, product),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const SizedBox();
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      product.category,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something went wrong: ${snapshot.error}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black87,
                    strokeWidth: 2,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showProductDialog(BuildContext context, FakeStoreInProduct product) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox();
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(product.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text('\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
                const SizedBox(height: 4),
                Text('Category: ${product.category}', style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 4),
                Text('Brand: ${product.brand}', style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 12),
                Text(product.description, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
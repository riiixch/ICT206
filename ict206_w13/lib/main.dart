import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'update_product.dart'; 
import 'add_product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Good SHOP',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List products = [];
  List filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // ดึงข้อมูลสินค้า
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/flutter_shop_v2/show_data.php'),
      );
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
          filteredProducts = products;
        });
      } else {
        print('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  // ฟังก์ชันลบสินค้า
  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.post(
        Uri.parse(
          'http://localhost/flutter_shop_v2/delete_product.php',
        ),
        body: {'id': id.toString()},
      );

      if (response.statusCode == 200) {
        setState(() {
          products.removeWhere((product) => product['id'].toString() == id);
          filteredProducts = List.from(products);
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('ลบสินค้าสำเร็จ ✅')));
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      print('Error deleting product: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('เกิดข้อผิดพลาด ❌')));
    }
  }

  // ฟังก์ชันยืนยันการลบสินค้า
  void confirmDeleteProduct(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this product?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                deleteProduct(id); // Call the deleteProduct function
              },
            ),
          ],
        );
      },
    );
  }

  // ฟังก์ชันค้นหาสินค้า
  void filterProducts(String query) {
    setState(() {
      filteredProducts =
          products.where((product) {
            final name = product['name']?.toLowerCase() ?? '';
            return name.contains(query.toLowerCase());
          }).toList();
    });
  }

 // ฟังก์ชันเปิดหน้าจอเพิ่มข้อมูลสินค้า
void navigateToAddProduct() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddProduct(),
    ),
  );

  // ถ้าผลลัพธ์เป็น true ให้รีเฟรชข้อมูล
  if (result == true) {
    fetchProducts();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: navigateToAddProduct, // เพิ่มปุ่มเพิ่มสินค้า
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search by product name',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: filterProducts,
            ),
          ),
          Expanded(
            child:
                filteredProducts.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        String imageUrl =
                            product['image'] ?? 'https://via.placeholder.com/150';

                        return Card(
                          child: ListTile(
                            leading: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            title: Text(product['name'] ?? 'No Name'),
                            subtitle: Text(
                              product['price'].toString() ?? '',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    confirmDeleteProduct(product['id'].toString());
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    showUpdateDialog(
                                      product['id'].toString(),
                                      product['name'] ?? '',
                                      product['description'] ?? '',
                                      product['price'] ?? '',
                                      product['image'] ?? '',
                                      product['amount'].toString() ?? '',
                                      context,
                                      products,
                                      setState,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

// หน้าจอสำหรับเพิ่มสินค้า
class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: const Text('Add Product')),

      body: AddProduct(), // Removed the 'const' keyword
    );
  }
}

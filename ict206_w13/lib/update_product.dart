import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> updateProduct(
  String id,
  String name,
  String description,
  String price,
  String image,
  String amount,
  BuildContext context,
  List products,
  Function setState,
) async {
  try {
    Object dataReq = {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'amount': amount,
    };

    final response = await http.post(
      Uri.parse('http://localhost/flutter_shop_v2/update_product.php'),
      body: jsonEncode(dataReq),
    );

    if (response.statusCode == 200) {
      setState(() {
        // อัปเดตข้อมูลสินค้าในรายการ
        var updatedProduct = products.firstWhere((product) => product['id'].toString() == id);
        updatedProduct['name'] = name;
        updatedProduct['description'] = description;
        updatedProduct['price'] = price;
        updatedProduct['image'] = image;
        updatedProduct['amount'] = amount;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('อัปเดตสินค้าสำเร็จ ✅')));
    } else {
      throw Exception('Failed to update product');
    }
  } catch (e) {
    print('Error updating product: $e');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('เกิดข้อผิดพลาดในการอัปเดต ❌')));
  }
}

void showUpdateDialog(
  String id,
  String currentName,
  String currentDescription,
  String currentPrice,
  String currentImage,
  String currentAmount,
  BuildContext context,
  List products,
  Function setState,
) {
  TextEditingController nameController = TextEditingController(text: currentName);
  TextEditingController descriptionController = TextEditingController(text: currentDescription);
  TextEditingController priceController = TextEditingController(text: currentPrice);
  TextEditingController imageController = TextEditingController(text: currentImage);
  TextEditingController amountController = TextEditingController(text: currentAmount);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Update Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              updateProduct(
                id,
                nameController.text,
                descriptionController.text,
                priceController.text,
                imageController.text,
                amountController.text,
                context,
                products,
                setState,
              );
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

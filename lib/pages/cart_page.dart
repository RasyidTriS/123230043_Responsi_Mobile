import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latihan_responsi/models/product.dart';
import 'package:latihan_responsi/pages/detail_page.dart';
import 'package:latihan_responsi/services/cart_service.dart';
import 'package:latihan_responsi/widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Keranjang'),
      ),
      body: ValueListenableBuilder<Box<Map<dynamic, dynamic>>>(
        valueListenable: CartService.box.listenable(),
        builder: (context, box, _) {
          final products = box.values.map(Product.fromHive).toList();

          if (products.isEmpty) {
            return const Center(
              child: Text(
                'Keranjang masih kosong.',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final product = products[index];
              return CartItemCard(
                product: product,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetailPage(productId: product.id),
                    ),
                  );
                },
                onDelete: () => CartService.remove(product.id),
              );
            },
          );
        },
      ),
    );
  }
}

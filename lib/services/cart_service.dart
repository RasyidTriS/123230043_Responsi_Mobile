import 'package:hive/hive.dart';
import 'package:latihan_responsi/models/product.dart';

class CartService {
  static const String boxName = 'cart_products';

  static Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<Map<dynamic, dynamic>>(boxName);
    }
  }

  static Box<Map<dynamic, dynamic>> get box {
    return Hive.box<Map<dynamic, dynamic>>(boxName);
  }

  static List<Product> getProducts() {
    return box.values.map(Product.fromHive).toList();
  }

  static bool contains(int productId) {
    return box.containsKey(productId.toString());
  }

  static Future<void> add(Product product) async {
    await box.put(product.id.toString(), product.toJson());
  }

  static Future<void> remove(int productId) async {
    await box.delete(productId.toString());
  }

  static int count() {
    return box.length;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:latihan_responsi/models/product.dart';

void main() {
  test('Product parses nullable API fields safely', () {
    final product = Product.fromJson({
      'id': 1,
      'title': 'Sample Product',
      'price': '12.5',
      'description': null,
      'category': 'sample',
      'image': null,
      'rating': {'rate': null, 'count': '4'},
    });

    expect(product.id, 1);
    expect(product.title, 'Sample Product');
    expect(product.price, 12.5);
    expect(product.description, '');
    expect(product.image, '');
    expect(product.rating, 0);
    expect(product.ratingCount, 4);
  });
}

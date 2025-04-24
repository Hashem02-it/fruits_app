import 'package:flutter/material.dart';
import 'package:fruits_app/core/widgets/item_product.dart';

class BestSellingGridview extends StatelessWidget {
  const BestSellingGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 163 / 214,
        mainAxisSpacing: 8,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return const ItemProduct();
      },
    );
  }
}

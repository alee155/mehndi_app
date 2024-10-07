import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridView extends StatelessWidget {
  const ShimmerGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => Container(
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}

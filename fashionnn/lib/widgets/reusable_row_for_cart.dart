import 'package:fashionnn/widgets/reusable_text.dart';
import 'package:flutter/material.dart';

class ReusableRowForCart extends StatelessWidget {
  final double price;
  final String text;

  ReusableRowForCart({
    required this.text,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: textTheme.headlineSmall?.copyWith(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          ReusableTextForDetails(
            text: price.toString(),
          )
        ],
      ),
    );
  }
}

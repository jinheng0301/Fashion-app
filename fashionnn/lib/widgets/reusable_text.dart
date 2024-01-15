import 'package:fashionnn/utils/constants.dart';
import 'package:flutter/material.dart';

class ReusableTextForDetails extends StatelessWidget {
  const ReusableTextForDetails({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
        text: 'USD',
        style: textTheme.titleSmall?.copyWith(
          color: primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: ' ${text}',
            style: textTheme.titleSmall?.copyWith(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

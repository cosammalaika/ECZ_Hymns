import 'package:flutter/material.dart';

class BrandWordmark extends StatelessWidget {
  final double size;
  final Color color;
  final TextAlign textAlign;

  const BrandWordmark({
    super.key,
    this.size = 20,
    this.color = const Color(0xFF163042),
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: 'Hymns',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w800,
              color: color,
              height: 1.0,
            ),
          ),
          TextSpan(
            text: ' Alive',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w300,
              color: color.withOpacity(0.92),
              height: 1.0,
            ),
          ),
        ],
      ),
      textAlign: textAlign,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class SymbolWidget extends StatelessWidget {
  final String label;
  final Color color;

  const SymbolWidget({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          label,
          style: getTextTheme(context).c3m.copyWith(
                color: color,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

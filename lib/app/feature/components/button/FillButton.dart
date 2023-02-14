import 'package:flutter/material.dart';

class FillButton extends StatefulWidget {
  final double height;
  final Widget child;
  final Function onTap;

  FillButton({
    Key? key,
    this.height = 80.0,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  State<FillButton> createState() => _FillButtonState();
}

class _FillButtonState extends State<FillButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.9);
            } else if (states.contains(MaterialState.disabled)) {
              return Colors.grey;
            } else {
              return Theme.of(context).colorScheme.primary;
            }
          }),
        ),
        child: Center(child: widget.child),
        onPressed: () => widget.onTap(),
      ),
    );
  }
}

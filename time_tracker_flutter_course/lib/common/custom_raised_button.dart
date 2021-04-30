import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color disabledColor;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  const CustomRaisedButton({
    Key key,
    this.color,
    this.borderRadius: 4.0,
    this.height: 50.0,
    this.onPressed,
    this.child,
    this.disabledColor,
  }) : assert(borderRadius != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: child,
        disabledColor: disabledColor ?? color,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../commons/theme_helper.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        padding: const EdgeInsets.only(right: 30),
        onPressed: () => onPressed(),
        icon: Icon(
          icon,
          color: ThemeHelper.color5A5A5A,
          size: 40,
        ),
      ),
    );
  }
}

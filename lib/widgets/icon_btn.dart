import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({Key? key, required this.onPress, required this.iconData})
      : super(key: key);
  final VoidCallback onPress;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPress, icon: Icon(iconData));
  }
}

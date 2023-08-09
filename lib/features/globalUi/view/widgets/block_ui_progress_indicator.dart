import 'package:flutter/material.dart';
import 'package:usos/styles/colors.dart';

class BlockUiProgressIndicator extends StatelessWidget {
  const BlockUiProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(color: UsosColors.primaryColor),
    );
  }
}

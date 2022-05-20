import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuantityButtonWidget extends StatelessWidget {
  final int quantity;
  final void Function(int) onChange;

  const QuantityButtonWidget(
      {required this.quantity, required this.onChange, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      padding: const EdgeInsets.all(5),
      shape: const CircleBorder(),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
            style: outlineButtonStyle,
            onPressed: () {
              if (quantity > 1) {
                onChange(quantity - 1);
              }
            },
            child: const Icon(Iconsax.minus)),
        const SizedBox(width: 5),
        Text('$quantity'),
        const SizedBox(width: 5),
        OutlinedButton(
            style: outlineButtonStyle,
            onPressed: () {
              onChange(quantity + 1);
            },
            child: const Icon(Iconsax.add)),
      ],
    );
  }
}

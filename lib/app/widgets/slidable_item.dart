import 'package:flutter/material.dart';

class SlidableItem extends StatelessWidget {
  final Color backgroundColor;
  final VoidCallback onTap;
  final Icon icon;

  const SlidableItem(
      {required this.backgroundColor, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Material(
            color: backgroundColor,
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

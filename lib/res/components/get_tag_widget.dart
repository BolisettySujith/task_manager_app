import 'package:flutter/material.dart';

Widget getTag(String tagName, Color tagBackgroundColor) {
  return FittedBox(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
          color: tagBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
      child: Center(
          child: Text(
            tagName,
            style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 12,
                fontWeight: FontWeight.w500
            ),
          )
      ),
    ),
  );
}
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content, [int? sec]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      duration: sec == null ? const Duration(milliseconds: 4000) : Duration(seconds: sec),
    ),
  );
}

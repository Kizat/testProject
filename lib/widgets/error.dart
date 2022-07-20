import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    Key? key,
    required this.error,
    required this.onRefresh,
  }) : super(key: key);

  final String? error;
  final Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(error ?? ""),
        IconButton(
          onPressed: onRefresh,
          icon: const Icon(
            Icons.refresh,
          ),
        ),
      ],
    );
  }
}

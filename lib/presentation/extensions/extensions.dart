import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  T getArguments<T>() {
    return ModalRoute.of(this)!.settings.arguments as T;
  }
}

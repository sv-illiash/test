import 'package:flutter/material.dart';
import 'package:test_app/presentation/resources/text_resources.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: Center(child: Text(AppTextResources.emptyState)));
  }
}

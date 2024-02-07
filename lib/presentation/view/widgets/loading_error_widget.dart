import 'package:flutter/material.dart';
import 'package:test_app/presentation/resources/text_resources.dart';

class LoadingErrorWidget extends StatelessWidget {
  const LoadingErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: Center(child: Text(AppTextResources.loadingError)));
  }
}

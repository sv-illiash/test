import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/constants/contants.dart';
import 'package:test_app/presentation/resources/text_resources.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String? url;

  const CachedNetworkImageWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '$imageApiUrl$url',
      placeholder: (context, url) => Container(),
      errorWidget: (context, url, error) => const Center(child: Text(AppTextResources.notLoaded)),
    );
  }
}

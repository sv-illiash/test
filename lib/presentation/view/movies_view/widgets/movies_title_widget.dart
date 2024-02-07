import 'package:flutter/material.dart';
import 'package:test_app/presentation/resources/text_resources.dart';
import 'package:test_app/presentation/ui_constants/ui_constants.dart';

class TitleWidget extends StatelessWidget {
  static const double titleHeight = 120;
  final String? title;
  final String? description;

  const TitleWidget({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(space8),
        child: SizedBox(
            height: titleHeight,
            child: Column(
              children: [
                Center(
                    child: Text(
                  '${AppTextResources.title} : ${title ?? AppTextResources.no}',
                  maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                )),
                const SizedBox(height: space10),
                Expanded(
                    child: Text(
                  description ?? AppTextResources.no,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            )),
      ),
    );
  }
}

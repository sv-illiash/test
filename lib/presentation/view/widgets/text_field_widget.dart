import 'package:flutter/material.dart';
import 'package:test_app/core/constants/contants.dart';

class TextFiledWidget extends StatefulWidget {
  final Function(String search) onSearch;

  const TextFiledWidget({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<TextFiledWidget> createState() => _TextFiledWidgetState();
}

class _TextFiledWidgetState extends State<TextFiledWidget> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      onChanged: (search) {
        if (search.length >= validSearchLength) widget.onSearch(search);
      },
    );
  }
}

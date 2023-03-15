import 'package:flutter/material.dart';

class EditableCartItem extends StatelessWidget {
  const EditableCartItem({
    Key? key,
    required this.item,
    required this.onSubmitted,
  }) : super(key: key);

  final String item;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: TextEditingController(text: item),
        onSubmitted: onSubmitted,
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
        ),
      ),
    );
  }
}

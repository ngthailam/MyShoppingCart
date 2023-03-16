import 'package:flutter/material.dart';
import 'package:my_shopping_cart/data/cart/entity/cart_item.dart';

class EditableCartItem extends StatefulWidget {
  const EditableCartItem({
    Key? key,
    required this.item,
    required this.onSubmitted,
    required this.onChanged,
    required this.onFocusChange,
  }) : super(key: key);

  final CartItem item;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;
  final Function(bool hasFocus) onFocusChange;

  @override
  State<EditableCartItem> createState() => _EditableCartItemState();
}

class _EditableCartItemState extends State<EditableCartItem> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (mounted) {
        widget.onFocusChange(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: TextEditingController(text: widget.item.text),
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        autocorrect: false,
        autofocus: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: 'Shopping Item',
          contentPadding: EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
        ),
      ),
    );
  }
}

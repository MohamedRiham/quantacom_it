import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final String hiddenText;
  final Function(String) onChange;
  bool? enabled;
   SearchBox({
    super.key,
    required this.hiddenText,
this.enabled,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              enabled: enabled,
              onChanged: onChange,
              autofocus: false,
              decoration: InputDecoration(
                hintText: hiddenText,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ],
      
    );
  }
}

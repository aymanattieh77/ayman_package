import "package:flutter/material.dart";
import "package:flutter/services.dart";

extension ONTextEx on Text {
  Widget withCopy(BuildContext context) {
    return InkWell(
      onLongPress: () {
        final String textCopy = data ?? "";
        Clipboard.setData(ClipboardData(text: textCopy));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Copied to clipboard'),
          ),
        );
      },
      child: this,
    );
  }
}

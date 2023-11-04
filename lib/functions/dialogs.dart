import 'package:flutter/material.dart';

/// A dialog box is a UI element that displays information to the user and allows the user to enter information
/// or select an option.

/// There are different types of dialogs such as:
///
/// 1. Popup dialog: It appears in front of the main scaffold and blocks any interaction with the main scaffold.
///    Popup dialogs are typically used to display error messages, warnings, or confirmation messages.
///
/// 2. Alert dialog: It asks the user to confirm an action or to make a choice between several options.
///    It is also a modal dialog, which means that it blocks the rest of the screen until the user dismisses it.

void showPopupDialog(BuildContext context, {required Widget child}) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: child,
      );
    },
  );
}

void showAlertDialog(
  BuildContext context, {
  required String title,
  required String message,
  Widget? icon,
  String cancelText = "Cancel",
  String confirmText = "Confirm",
  void Function()? cancelPress,
  void Function()? confirmPress,
}) {
  showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(title),
          content: Text(message),
          icon: icon,
          actions: [
            OutlinedButton(onPressed: cancelPress, child: Text(cancelText)),
            ElevatedButton(onPressed: confirmPress, child: Text(confirmText)),
          ],
        );
      });
}

void showFullScreenDialog(BuildContext context, Widget child) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return Dialog.fullscreen(
        child: child,
      );
    },
  );
}

void dismissDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

bool _isCurrentDialogShowing(BuildContext context) {
  return ModalRoute.of(context)?.isCurrent != true;
}

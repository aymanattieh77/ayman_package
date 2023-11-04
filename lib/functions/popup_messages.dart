import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

/// Flutter apps can provide quick and simple feedback about any operation to a user in the following ways:

/// Snackbars: They provide brief messages about app processes at the bottom of the screen.
/// Toasts or Notifications: They appear in the middle of the lower half of the screen as a small alert with translucent background.
/// Tooltips: They provide brief messages about the function of a button or other element when the user hovers over it.

// Show Snack Bar Message
void showSnackBarMessage(BuildContext context,
    {required String message,
    Color? bgColor,
    SnackBarAction? action,
    EdgeInsetsGeometry? margin}) {
  final SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor: bgColor ?? Colors.white,
    action: action,
    behavior:
        margin == null ? SnackBarBehavior.fixed : SnackBarBehavior.floating,
    margin: margin,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Toast with No Build Context (Android & iOS)
void showToastMessage(
    {required String message,
    Color? bgColor,
    double? fontsize,
    Color? textColor,
    ToastGravity? gravity,
    bool longToast = false}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: bgColor,
    fontSize: fontsize,
    gravity: gravity ?? ToastGravity.CENTER,
    textColor: textColor,
    toastLength: longToast ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
  );
}

// Toast with No Build Context (Android & iOS)
void showPopupMessage(
    {required String message, required PopupState popupState}) {
  showToastMessage(
    message: message,
    bgColor: popupState == PopupState.success
        ? Colors.green
        : popupState == PopupState.error
            ? Colors.red
            : Colors.black87,
    fontsize: 16,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    longToast: false,
  );
}

enum PopupState { success, error, loading, alert }

/// the default of behavior: SnackBarBehavior.fixed
/// you can change it to SnackBarBehavior.floating to make it floating
/// I have added example of floating snackbar in the code you can try it
class CustomSnackBar {
  /// simple snackbar
  static void showSimpleSnackBar(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// show snackbar with action
  static void showSnackBarWithAction(
    BuildContext context, {
    required String message,
    required String actionLabel,
    required VoidCallback action,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: actionLabel,
        onPressed: () {
          action();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Show floating snackbar
  static void showFloatingSnackBar(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// show snackbar with custom icon
  static void showErrorSnackBar(
    BuildContext context, {
    required String errorMessage,
  }) {
    final snackBar = SnackBar(
      content: Text(
        errorMessage,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// snackbar with error icon and action
  static void showErrorSnackBarWithAction(
    BuildContext context, {
    required String errorMessage,
    required String actionLabel,
    required VoidCallback action,
  }) {
    final snackBar = SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        textColor: Colors.white,
        label: actionLabel,
        onPressed: () {
          action();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// snackbar with success icon and action
  static void showSuccessSnackBarWithAction(
    BuildContext context, {
    required String successMessage,
    required String actionLabel,
    required VoidCallback action,
  }) {
    final snackBar = SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              successMessage,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green,
      action: SnackBarAction(
        textColor: Colors.white,
        label: actionLabel,
        onPressed: () {
          action();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// snackbar with warning icon and action
  static void showWarningSnackBarWithAction(
    BuildContext context, {
    required String warningMessage,
    required String actionLabel,
    required VoidCallback action,
  }) {
    final snackBar = SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              warningMessage,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.orange,
      action: SnackBarAction(
        textColor: Colors.white,
        label: actionLabel,
        onPressed: () {
          action();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// snackbar with info icon and action
  static void showInfoSnackBarWithAction(
    BuildContext context, {
    required String infoMessage,
    required String actionLabel,
    required VoidCallback action,
  }) {
    final snackBar = SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              infoMessage,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue,
      action: SnackBarAction(
        textColor: Colors.white,
        label: actionLabel,
        onPressed: () {
          action();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // snackbar with custom icon and action
  static void showCustomSnackBarWithAction(
    BuildContext context, {
    required String message,
    required String actionLabel,
    required VoidCallback action,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    final snackBar = SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      action: SnackBarAction(
        textColor: Colors.white,
        label: actionLabel,
        onPressed: () {
          action();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

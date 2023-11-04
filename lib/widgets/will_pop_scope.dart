import 'dart:developer';

import 'package:ayman_package/extensions/on_check_internet.dart';
import 'package:ayman_package/extensions/on_strings.dart';
import 'package:ayman_package/functions/popup_messages.dart';
import 'package:ayman_package/logs/logs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WillPopScopeExample extends StatelessWidget {
  const WillPopScopeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        log("weill");
        // MostUsedFunctions.showSnackBarFun(context, 'On Will Pop Scope Works!');
        // if you want to prevent the user from going back to the previous page make it return false;
        showPopupMessage(message: "message", popupState: PopupState.loading);
        final bool isConnceted = await Container().checkInternet();
        logSuccess(isConnceted.toString());
        // showToastMessage(
        //   message: "Press Again To Exit",
        //   gravity: ToastGravity.BOTTOM,
        //   bgColor: Colors.black87,
        // );
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child:
              'WillPopScope is a widget that works when you back to the previous page.'
                  .txt,
        ),
      ),
    );
  }
}

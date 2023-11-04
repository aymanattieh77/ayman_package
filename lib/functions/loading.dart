import 'package:ayman_package/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ShowStateRenderer {
  ShowStateRenderer._private();
  static showLoading(StateType stateRenderderType, [String? status]) {
    switch (stateRenderderType) {
      case StateType.loading:
        EasyLoading.show(status: status ?? 'loading...');
        return;
      case StateType.success:
        EasyLoading.showSuccess(status ?? 'Great Success!');
        return;
      case StateType.error:
        EasyLoading.showError(status ?? 'Failed with Error');
        return;
      case StateType.info:
        EasyLoading.showInfo(status ?? 'Useful Information.');
        return;
    }
  }

  showToast() {
    EasyLoading.showToast('Toast');
  }

  dismiss() {
    EasyLoading.dismiss();
  }
}

enum StateType { loading, success, error, info }

void showLoadingDialog(BuildContext context) {
  showAdaptiveDialog(
    context: context,
    builder: (context) => const LoadingWidget(),
  );
}

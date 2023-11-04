import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeController {
  final StreamController<bool> _streamController = StreamController<bool>();

  static final _instance = ThemeController._internal();
  factory ThemeController() => _instance;
  ThemeController._internal() {
    _streamController.add(isDark);
  }

  Stream<bool> get output => _streamController.stream;

  bool isDark = false;

  changeTheme() {
    _streamController.add(!isDark);
    isDark = !isDark;
  }

  dispose() {
    _streamController.close();
  }
}

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;

  changeTheme() async {
    isDark = !isDark;
    notifyListeners();
  }
}

class ThemeCubit extends Cubit<bool> {
  ThemeCubit(super.initialState);

  bool isDark = false;

  changeTheme() {
    isDark = !isDark;
    emit(isDark);
  }
}

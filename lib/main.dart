import 'dart:async';
import 'dart:developer';

import 'package:ayman_package/data/api/data_source/remote_data_source.dart';
import 'package:ayman_package/data/api/dio/dio_controller.dart';
import 'package:ayman_package/data/api/http/http_controller.dart';
import 'package:ayman_package/data/api/response/response.dart';
import 'package:ayman_package/data/api/retorfit/rest_client.dart';
import 'package:ayman_package/data/errors/error_handler.dart';
import 'package:ayman_package/data/errors/exceptions.dart';
import 'package:ayman_package/data/repo/place_repo.dart';
import 'package:ayman_package/domain/models/news/article.dart';
import 'package:ayman_package/extensions/on_widgets.dart';
import 'package:ayman_package/logs/logs.dart';
import 'package:ayman_package/widgets/data_table.dart';
import 'package:ayman_package/widgets/interactive_viewer.dart';
import 'package:ayman_package/widgets/reorderable_list.dart';
import 'package:ayman_package/widgets/segement_button.dart';
import 'package:ayman_package/widgets/swipe_to_dismiss.dart';
import 'package:ayman_package/widgets/will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';

import 'package:ayman_package/core/routes/routes.dart';
import 'package:ayman_package/extensions/on_theme.dart';
import 'package:ayman_package/theme/theme_controller.dart';
import 'package:ayman_package/theme/themes.dart';
import 'package:ayman_package/widgets/loading/loading_widget.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  // PlaceRepo(BaseRemoteDataSource(APIServiceImpl(DioController())))
  //     .getPosts()
  //     .then((value) {
  //   log(value.toString(), name: "result");
  // });

  final dio = DioController().dio;

  PlaceRepo(BaseRemoteDataSource(RestClient(dio)))
      .getNewsBySearch("messi")
      .then((value) {
    value.fold(
      (left) {
        log(left.message, name: "Left");
      },
      (right) {
        log(right.toString(), name: "Right");
      },
    );
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeController = ThemeController();

  @override
  void dispose() {
    themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (ctx, _) {
          return StreamBuilder<bool>(
              stream: themeController.output,
              builder: (context, snapshot) {
                return MaterialApp.router(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  themeAnimationCurve: Curves.ease,
                  themeAnimationDuration: const Duration(milliseconds: 500),
                  routerDelegate: goRouter.routerDelegate,
                  routeInformationProvider: goRouter.routeInformationProvider,
                  routeInformationParser: goRouter.routeInformationParser,
                  backButtonDispatcher: goRouter.backButtonDispatcher,
                  darkTheme: darkTheme,
                  theme: lightTheme,
                  themeMode: (snapshot.data ?? false)
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  builder: EasyLoading.init(),
                );
              });
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const path = "/home";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        setState(() {
          loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: loading ? const LoadingWidget() : const Body(),
      body: WillPopScopeExample(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("there are you", style: TextStyle(fontSize: 20.sp)),
          SizedBox(height: 10.h),
          10.sizedHeight,
          Container(
            color: Colors.red,
            width: 500.w,
            height: 100.w,
          ),
          const CupertinoSlidingSegmentedControlWidgets(),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  static const path = "/dashboard";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: Text('Go Back', style: context.bodyLarge),
        ),
      ),
    );
  }
}

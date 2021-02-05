import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rx_stream/screens/authentication/login/login.dart';
import 'package:flutter_rx_stream/screens/main/main_bloc.dart';
import 'package:flutter_rx_stream/service/network_util.dart';
import 'package:flutter_rx_stream/utils/app_helper.dart';
import 'package:flutter_rx_stream/utils/app_theme.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'generated/l10n.dart';

void main() async {
  await initMyApp();
}

Future<void> initMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final globalScaffoldKey = GlobalKey<NavigatorState>();
  final mainBloc = MainBloc.instance;
  StreamSubscription networkSubscription;


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => postBuild(context));
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(ui.window.locale?.languageCode),
      supportedLocales: S.delegate.supportedLocales,
      navigatorKey: globalScaffoldKey,
      debugShowCheckedModeBanner: false,
      title: 'Hunting Journal',
      theme: appLightTheme(context),
      home: LoginScreen(),
    );
  }


  void postBuild(BuildContext context) {
    mainBloc.initContext(context, globalScaffoldKey);
    checkNetworkResult();
  }

  void checkNetworkResult() {
    networkSubscription?.cancel();
    networkSubscription = NetworkingUtil().networkStatus.stream.distinct().listen((network){
      Logging.log('connect network: $network');
      if(!network){
        AppHelper.showNetworkDialog(
            'Network',
            'Network disconnect');
      }
    });
  }

}



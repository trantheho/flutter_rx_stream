/*
 * Developed by Ti Ti on 11/16/20 11:03 AM.
 * Last modified 11/16/20 11:03 AM.
 * Copyright (c) 2020. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_rx_stream/base/bloc.dart';

class MainBloc extends AppBloc{
  MainBloc._private() {
    initLogic();
  }
  static final instance = MainBloc._private();

  GlobalKey<NavigatorState> _globalKey;

  BuildContext _context;

  void initContext(BuildContext context, GlobalKey globalKey) {
    _context = context;
    _globalKey = globalKey;
  }

  GlobalKey<NavigatorState> getKey(){
    return _globalKey;
  }

  BuildContext getContext() {
    if (_context == null)
      throw Exception(
          'You need to init context after root widget initialized.');
    return _context;
  }

  BuildContext getOverLayContext(){
    if (_globalKey == null)
      throw Exception(
          'You need to init context after root widget initialized.');
    return _globalKey.currentState.overlay.context;
  }

  final pageIndex = BlocDefault<int>();

  PageController _pageController;
  AnimationController _bottomAppBarController;

  void initPageController(PageController controller, AnimationController bottomAppBarController){
    _pageController = controller;
    _bottomAppBarController = bottomAppBarController;
  }

  @override
  void dispose() {
    _pageController.dispose();
    pageIndex.dispose();
  }

  @override
  void initLogic() {
    pageIndex.logic = (input) => input.map((input) {
      _pageController.jumpToPage(input);
      return input;
    });
  }

  void hideBottomBar(){
    _bottomAppBarController.reverse();
  }

  void showBottomBar(){
    _bottomAppBarController.forward();
  }


}
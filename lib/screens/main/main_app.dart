/*
 * Developed by Ti Ti on 11/17/20 3:51 PM.
 * Last modified 11/17/20 3:51 PM.
 * Copyright (c) 2020. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_rx_stream/generated/l10n.dart';
import 'package:flutter_rx_stream/screens/empty.dart';
import 'package:flutter_rx_stream/screens/main/main_bloc.dart';
import 'package:flutter_rx_stream/utils/app_assets.dart';
import 'package:flutter_rx_stream/utils/app_colors.dart';
import 'package:flutter_rx_stream/utils/app_helper.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final mainAppBloc = MainBloc.instance;
  AnimationController bottomAppBarController;
  Animation<double> bottomAppBarCurve;
  PageController controller;
  List<Widget> _pages;
  int indexTab = 0;

  @override
  void initState() {
    _pages = [EmptyScreen(), EmptyScreen(), EmptyScreen(), EmptyScreen()];
    controller = PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    indexTab = 0;
    bottomAppBarController = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 250),
    )..forward();
    bottomAppBarCurve = CurvedAnimation(
      parent: bottomAppBarController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );
    mainAppBloc.initPageController(controller, bottomAppBarController);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // call api
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    mainAppBloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        backgroundColor: AppColors.terraCotta,
        body: Container(
          height: AppHelper.screenHeight(context),
          width: AppHelper.screenWidth(context),
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: constraints.maxHeight
                      ),
                      child: IntrinsicHeight(
                        child: PageView(
                          controller: controller,
                          physics: NeverScrollableScrollPhysics(),
                          children: _pages,
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildBottomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(){
    return SizeTransition(
      sizeFactor: bottomAppBarCurve,
      axisAlignment: -1,
      child: Container(
        height: kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom,
        child: StreamBuilder(
            stream: mainAppBloc.pageIndex.stream,
            initialData: 0,
            builder: (context,AsyncSnapshot<int> pageIndex) {
              indexTab = pageIndex.data;
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBottomNavigationBarItem(
                      AppColors.darkTerraCotta,
                      Icons.home,
                      S.of(context).home.toUpperCase(),
                      0,
                    ),

                    _buildBottomNavigationBarItem(
                      AppColors.terraCotta,
                      Icons.store,
                      S.of(context).store.toUpperCase(),
                      1,
                    ),

                    _buildBottomNavigationBarItem(
                      AppColors.terraCotta,
                      Icons.shopping_bag,
                      S.of(context).myBag.toUpperCase(),
                      2,
                    ),

                    _buildBottomNavigationBarItem(
                      AppColors.terraCotta,
                      Icons.person,
                      S.of(context).profile.toUpperCase(),
                      3,
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(Color color, IconData icon, String title, int index) {
    return RawMaterialButton(
      onPressed: () => tapBottomBar(index),
      child: Container(
        width: AppHelper.screenWidth(context)/4,
        height: kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom,
        color: indexTab == index ? AppColors.darkTerraCotta : AppColors.terraCotta,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: 24,
              ),
            ),
            Text(
              '$title',
              style: AppTextStyle.textRegular13.copyWith(
                fontFamily: AppFonts.OpenSans,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }


  void tapBottomBar(int index) {
    AppHelper.monkeyTapping(
        durationTapping: Duration(milliseconds: 100),
        action: () {
          mainAppBloc.pageIndex.push(index);
        });
  }
}
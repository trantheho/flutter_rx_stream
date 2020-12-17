import 'package:flutter/material.dart';
import 'package:flutter_rx_stream/generated/l10n.dart';
import 'package:flutter_rx_stream/screens/empty.dart';
import 'package:flutter_rx_stream/utils/app_assets.dart';
import 'package:flutter_rx_stream/utils/app_colors.dart';
import 'package:flutter_rx_stream/utils/app_helper.dart';
import 'package:flutter_rx_stream/utils/app_screen_name.dart';
import 'package:flutter_rx_stream/widget/button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'login_bloc.dart';
import 'widget_build/password_input_build.dart';
import 'widget_build/username_input_build.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = LoginBloc();
  FocusNode userNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  TextEditingController emailController;
  TextEditingController passwordController;


  @override
  void initState() {
    bloc.initContext(context);
    emailController = TextEditingController();
    passwordController = TextEditingController();
    bloc.initTextController(emailController, passwordController);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppHelper.statusBarOverlayUI(Brightness.light),
      child: GestureDetector(
        onTap: (){
          AppHelper.hideKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: WillPopScope(
            onWillPop: () => null,
            child: Stack(
              children: [
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.only(left: 23, right: 23),
                    width: AppHelper.screenWidth(context),
                    height: AppHelper.screenHeight(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UserNameInputBuild(
                          loginBloc: bloc,
                          textEditingController: emailController,
                          focusNode: userNameFocus,
                          onSubmitted: (text) {
                            FocusScope.of(context)
                                .requestFocus(passwordFocus);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        PasswordInputBuild(
                          loginBloc: bloc,
                          textEditingController: passwordController,
                          focusNode: passwordFocus,
                          onSubmitted: (text) {
                            print(text);
                          },
                        ),
                        SizedBox(
                          height: 14.5,
                        ),
                        _buildButton(),

                        ButtonWithHighlightText(
                            color: AppColors.white.withOpacity(0.5),
                            highlightedColor: AppColors.white,
                            padding: EdgeInsets.zero,
                            text: S.of(context).textForgotPassword + '?',
                            textStyle: AppTextStyle.textWhiteRegular13.copyWith(
                              color: AppColors.white.withOpacity(0.5),
                              fontSize: 11,
                            ),
                            function: () {
                              AppHelper.navigatePush(context, AppScreenName.empty, EmptyScreen());
                            }),

                        BuildBottomOption(),

                        SizedBox(height: 8,),
                      ],
                    ),
                  ),
                ),
                StreamBuilder(
                  initialData: false,
                  stream: bloc.loading.stream,
                  builder: (context, snapshot) {
                    if(snapshot.data){
                      return Container(
                        color: Colors.white.withOpacity(0.3),
                        child: SpinKitFadingCircle(color: AppColors.white),
                        alignment: Alignment.center,
                      );
                    }
                    else{
                      return SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(){
    return Container(
      height: 55,
      color: Theme.of(context).buttonColor,
      child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Text(
              S.of(context).textLogin.toUpperCase(),
              style: AppTextStyle.textWhiteBold.copyWith(
                fontSize: 13,
                letterSpacing: 1.3,
              ),
            ),
          ),
          onPressed: () {
            AppHelper.hideKeyboard(context);
            bloc.login();
          }),
    );
  }

}

class BuildBottomOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonWithHighlightText(
            color: AppColors.white.withOpacity(0.5),
            highlightedColor: AppColors.white,
            padding: EdgeInsets.zero,
            text: S.of(context).createAccount,
            textStyle: AppTextStyle.textWhiteRegular13.copyWith(
              color: AppColors.white.withOpacity(0.5),
              fontSize: 11,
            ),
            function: () {
              AppHelper.hideKeyboard(context);
              AppHelper.navigatePush(
                  context, AppScreenName.empty, EmptyScreen());
            }),

        Container(
          key: key,
          child: ButtonWithHighlightText(
              color: AppColors.white.withOpacity(0.5),
              highlightedColor: AppColors.white,
              padding: EdgeInsets.zero,
              text: S.of(context).textNeedHelp,
              textStyle: AppTextStyle.textWhiteRegular13.copyWith(
                color: AppColors.white.withOpacity(0.5),
                fontSize: 11,
              ),
              function: () {

              }),
        ),
      ],
    );
  }

}



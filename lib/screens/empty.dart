import 'package:flutter/material.dart';
import 'package:flutter_rx_stream/generated/l10n.dart';
import 'package:flutter_rx_stream/utils/app_assets.dart';
import 'package:flutter_rx_stream/utils/app_colors.dart';

class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.verdigris,
      appBar: AppBar(
        backgroundColor: AppColors.verdigris,
        title: Text(
          S.of(context).emptyScreen.toUpperCase(),
          style: AppTextStyle.textWhiteBold.copyWith(
            fontSize: 25,
          ),
        ),
      ),
      body: Container(

      ),
    );
  }
}

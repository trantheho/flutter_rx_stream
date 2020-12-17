import 'package:flutter/material.dart';
import 'package:flutter_rx_stream/generated/l10n.dart';
import 'package:flutter_rx_stream/utils/app_assets.dart';
import 'package:flutter_rx_stream/extension/app_extension.dart';
import '../login_bloc.dart';

class PasswordInputBuild extends StatefulWidget {
  final LoginBloc loginBloc;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
  final TextEditingController textEditingController;

  PasswordInputBuild({
    this.loginBloc,
    this.focusNode,
    this.onSubmitted,
    this.textEditingController,
  });

  @override
  _PasswordInputBuildState createState() => _PasswordInputBuildState();
}

class _PasswordInputBuildState extends State<PasswordInputBuild> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //LabelHeaderText(text: '',),
          //SizedBox(height: 10),
          StreamBuilder(
              stream: widget.loginBloc.passwordWarning.stream,
              initialData: '',
              builder: (context,AsyncSnapshot<String> warning) {
                return Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: warning.data.isEmpty ? Colors.transparent : Theme.of(context).colorScheme.error),
                    color: Theme.of(context).colorScheme.primaryVariant,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.lock,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10),
                          child: TextField(
                            maxLines: 1,
                            controller: widget.textEditingController,
                            onChanged: (value){
                              widget.loginBloc.password = value;
                              widget.loginBloc.passwordWarning.push('');
                            },
                            focusNode: widget.focusNode,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: false,
                              border: InputBorder.none,
                              hintText: S.of(context).password.toUpperCaseFirst(),
                              hintStyle: AppTextStyle.textWhiteRegular13,
                              hintMaxLines: 1,
                            ),
                            style: AppTextStyle.textWhiteRegular13,
                            onSubmitted: (text) {
                              widget.onSubmitted(text);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          ),
          Container(
            width: double.infinity,
            child: StreamBuilder(
                stream: widget.loginBloc.passwordWarning.stream,
                initialData: '',
                builder: (context,AsyncSnapshot<String> snapshot) {
                  if(snapshot.hasData && snapshot.data.isNotEmpty){
                    return Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      child: Text(
                        snapshot.data,
                        style: AppTextStyle.textWarning,
                        maxLines: 2,
                      ),
                    );
                  }
                  else{
                    return Container();
                  }

                }
            ),
          ),
        ],
      ),
    );
  }
}

class LabelHeaderText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  LabelHeaderText({this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle,);
  }
}
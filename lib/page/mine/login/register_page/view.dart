import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app_config.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    RegisterPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    //避免软键盘弹出把控件顶上去
    resizeToAvoidBottomInset: false,
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      titleSpacing: 0,
      centerTitle: false,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 56, 0, 0),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                Container(
                  color: AppTheme.colors.themeColor,
                  width: 60,
                  height: 6,
                  margin: EdgeInsets.only(bottom: 4),
                ),
                Text(
                  S.current.hello,
                  style: TextStyle(
                      fontSize: HuoTextSizes.login_title,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
            child: Text(
              S.current.welcomeRegister,
              style: TextStyle(
                fontSize: HuoTextSizes.second_title,
                color: AppTheme.colors.textColor,
              ),
            ),
          ),
          state.isPhone
              ? Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffeeeeee), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  margin: EdgeInsets.fromLTRB(20, 38, 20, 0),
                  child: TextField(
                    controller: state.mobileController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d+')),
                      LengthLimitingTextInputFormatter(11)
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: S.current.mobileInputHint,
                      hintStyle: TextStyle(
                        color: AppTheme.colors.hintTextColor,
                      ),
                      contentPadding: EdgeInsets.only(left: 15),
                      counterText: "",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      color: AppTheme.colors.textColor,
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffeeeeee), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  margin: EdgeInsets.fromLTRB(20, 38, 20, 0),
                  child: TextField(
                    controller: state.userNameController,

//                    inputFormatters: [
////                      WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
////                      LengthLimitingTextInputFormatter(12)
////                    ],
                    maxLength: 16,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: S.of(viewService.context).textInputUsername,
                      hintStyle: TextStyle(
                        color: AppTheme.colors.hintTextColor,
                      ),
                      contentPadding: EdgeInsets.only(left: 15),
                      counterText: "",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      color: AppTheme.colors.textColor,
                    ),
                  ),
                ),
          state.isPhone
              ? Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffeeeeee), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  margin: EdgeInsets.fromLTRB(20, 9, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: state.authcodeController,
                          maxLength: 16,
                          decoration: InputDecoration(
                            hintText: S.current.authInputHint,
                            hintStyle: TextStyle(
                              color: AppTheme.colors.hintTextColor,
                            ),
                            contentPadding: EdgeInsets.only(left: 15),
                            counterText: "",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: TextStyle(
                            color: AppTheme.colors.textColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 25,
                        color: AppTheme.colors.themeColor,
                        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (state.countdownTime == 120)
                            dispatch(RegisterPageActionCreator.sendSMS());
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Text(
                            state.countdownTime == 120
                                ? S.current.authGetCode
                                : '${state.countdownTime} ${S.of(viewService.context).textSecond}',
                            style: TextStyle(
                                color: AppTheme.colors.themeColor,
                                fontSize: HuoTextSizes.content),
                          ),
                        ),
                      ),
                    ],
                  ))
              : Container(),
          Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffeeeeee), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              margin: EdgeInsets.fromLTRB(20, 9, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      obscureText: true,
                      controller: state.passwordController,
//                      inputFormatters: [
//                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
//                        LengthLimitingTextInputFormatter(8)
//                      ],
                      maxLength: 16,
                      decoration: InputDecoration(
                        hintText: S.of(viewService.context).textPleaseInputPsd,
                        hintStyle: TextStyle(
                          color: AppTheme.colors.hintTextColor,
                        ),
                        contentPadding: EdgeInsets.only(left: 15),
                        counterText: "",
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: TextStyle(
                        color: AppTheme.colors.textColor,
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.only(top: 20, right: 20),
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  dispatch(RegisterPageActionCreator.switchRegisterType());
                },
                child: Text(
                  state.isPhone
                      ? S.of(viewService.context).textAccountRegister
                      : S.of(viewService.context).textPhoneRegister,
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor),
                ),
              )),
          Container(
              height: 40,
              margin: EdgeInsets.all(30),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: new MaterialButton(
                      color: AppTheme.colors.themeColor,
                      textColor: Colors.white,
                      child:
                          new Text(S.of(viewService.context).textRegisterNow),
                      height: 40,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      onPressed: () {
                        state.isPhone
                            ? dispatch(
                                RegisterPageActionCreator.mobileRegister())
                            : dispatch(
                                RegisterPageActionCreator.usernameRegister());
                      },
                    ),
                  ),
                ],
              )),
          // Container(
          //   alignment: Alignment.center,
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       Text(
          //         S.of(viewService.context).textRegisterWasAgree,
          //         style: TextStyle(
          //             fontSize: HuoTextSizes.third_title,
          //             color: AppTheme.colors.textSubColor2),
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           dispatch(RegisterPageActionCreator.gotoRegisterAgreement());
          //         },
          //         child: Text(
          //           S.of(viewService.context).textRegisterAgree,
          //           style: TextStyle(
          //               fontSize: HuoTextSizes.third_title,
          //               color: AppTheme.colors.themeColor),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Checkbox(
                  value: state.checkState,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  activeColor: AppTheme.colors.themeColor,
                  onChanged: (bool value) {
                    dispatch(RegisterPageActionCreator.setCheckState(value));
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text: S.of(viewService.context).textAgree,
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff838383)),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                S.of(viewService.context).textUserAgreementMore,
                            style: TextStyle(color: Color(0xffF35A58)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AppUtil.gotoWebView(1, viewService.context);
                                //    launch(AppConfig.baseUrl + "app/user/agreement",forceWebView: true);
                              },
                          ),
                          TextSpan(
                            text: S.of(viewService.context).textAnd,
                          ),
                          TextSpan(
                            text:
                                S.of(viewService.context).textPrivacyPolicyMore,
                            style: TextStyle(color: Color(0xffF35A58)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AppUtil.gotoWebView(4, viewService.context);
                                //        launch(AppConfig.baseUrl + "app/app/userprivacy",forceWebView: true);
                              },
                          ),
                          TextSpan(
                            text:
                                S.of(viewService.context).textAgreementDescribe,
                          ),
                        ]),
                    maxLines: 2,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';
import 'package:flutter_huoshu_app/widget/multi_click_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app_config.dart';
import 'state.dart';

Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
//  double softKeyboardHeight =
//      MediaQuery.of(viewService.context).viewInsets.bottom;
//  print("softKeyboardHeight---123:${softKeyboardHeight}");
//  if (softKeyboardHeight > 0) {
//    //软键盘弹出的时候暂停所有视频
//    HuoVideoManager.pauseByType(
//        HuoVideoManager.type_video);
//  }

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
//      physics: new NeverScrollableScrollPhysics(),
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
                  S.current.login,
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
              S.current.welcomeLogin,
              style: TextStyle(
                fontSize: HuoTextSizes.second_title,
                color: AppTheme.colors.textColor,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffeeeeee), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            margin: EdgeInsets.fromLTRB(20, 38, 20, 0),
            child: TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                LengthLimitingTextInputFormatter(20)
              ],
              keyboardType: TextInputType.text,
              controller: state.mobileController,
              decoration: InputDecoration(
                hintText: S.of(viewService.context).toastInputUsernameAndPhone,
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
//                      inputFormatters: [
//                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
//                        LengthLimitingTextInputFormatter(8)
//                      ],
                      maxLength: 16,
                      controller: state.passwordController,
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
                  dispatch(LoginActionCreator.gotoFindPassword());
                },
                child: Text(
                  S.of(viewService.context).textForgetPassword,
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.colors.textSubColor),
                )),
          ),
          Container(
              height: 40,
              margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ClickButton(
                    onClick: () {
                      dispatch(LoginActionCreator.onLogin());
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppTheme.colors.value(state.loginColor),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Text(
                        S.current.login,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
//                    child:  MaterialButton(
//                      color: AppTheme.colors.value(state.loginColor),
//                      textColor: Colors.white,
//                      child: new Text(S.current.login),
//                      height: 40,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(4))),
//                      onPressed: () {
//                        dispatch(LoginActionCreator.onLogin());
//                      },
//                    ),
                      ),
                ],
              )),
          Container(
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: () {
                    dispatch(LoginActionCreator.gotoRegister());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        S.of(viewService.context).textRegisterAccount,
                        style: TextStyle(
                            color: AppTheme.colors.textSubColor, fontSize: 14),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      )
                    ],
                  ))),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Checkbox(
                  value: state.checkState,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  activeColor: AppTheme.colors.value(state.loginColor),
                  onChanged: (bool value) {
                    dispatch(LoginActionCreator.setCheckState(value));
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
                                // launch(AppConfig.baseUrl + "app/user/agreement",forceWebView: true);
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
                                //         launch(AppConfig.baseUrl + "app/app/userprivacy",forceWebView: true);
                              },
                          ),
                          TextSpan(
                            text:
                                S.of(viewService.context).textAgreementDescribe,
                          ),
                        ]),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

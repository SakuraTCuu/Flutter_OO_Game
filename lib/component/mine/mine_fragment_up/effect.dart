import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/vip_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/message/message_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_account_management/page.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/page/update/page.dart';
import 'package:flutter_huoshu_app/page/vip/member_center/page.dart';
import 'package:flutter_huoshu_app/page/vip/vip_center/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/SignDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<MineFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<MineFragmentState>>{
    MineFragmentAction.action: _onAction,
    MineFragmentAction.getUserInfo: _getUserInfo,
    MineFragmentAction.getMemInfo: _getMemInfo,
    MineFragmentAction.showSign: _showSign,
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    Lifecycle.appear: _appear,
    Lifecycle.disappear: _disappear,
    Lifecycle.didUpdateWidget: _didUpdateWidget,
    Lifecycle.didChangeAppLifecycleState: _didChangeAppLifecycleState,
    MineFragmentAction.gotoMessage: _gotoMessage,
    MineFragmentAction.gotoMemberCenter: _gotoMemberCenter,
  });
}

//刷新用户数据
void _didChangeAppLifecycleState(
    Action action, Context<MineFragmentState> ctx) {
  UserService.getUserInfo().then((UserInfo userInfo) {
    ctx.dispatch(MineFragmentActionCreator.updateUserInfo(userInfo));
  }).catchError((err) {
    print(err);
  });
}

//界面销毁的时候会调用这个方法
void _didUpdateWidget(Action action, Context<MineFragmentState> ctx) {
  print("_didUpdateWidget");
}

//界面销毁的时候会调用这个方法
void _disappear(Action action, Context<MineFragmentState> ctx) {
  print("_disappear");
}

//界面销毁的时候会调用这个方法
void _appear(Action action, Context<MineFragmentState> ctx) {
  print("_appear");
}

//界面销毁的时候会调用这个方法
void _dispose(Action action, Context<MineFragmentState> ctx) {}

void _init(Action action, Context<MineFragmentState> ctx) {
  print("MineFragmentState _initState");
  UserService.getUserInfo().then((UserInfo userInfo) {
    ctx.dispatch(MineFragmentActionCreator.updateUserInfo(userInfo));
  }).catchError((err) {
    print(err);
  });
//  //获取vip用户信息
//  VIPService.getMemInfo().then((data) {
//    if (data.code == 200) {
//      ctx.dispatch(MineFragmentActionCreator.updateMemberData(data.data));
//    }
//  });

  ctx.dispatch(MineFragmentActionCreator.getMemInfo());
  UserService.getMsgCount().then((data) {
    if (data['code'] == 200) {
      ctx.dispatch(
          MineFragmentActionCreator.updateMsgCount(data['data']['count']));
    }
  });
}

void _gotoMemberCenter(Action action, Context<MineFragmentState> ctx) {
//  AppUtil.gotoPageByName(ctx.context, MemberCenterPage.pageName)
//      .then((data) {
//  });
  AppUtil.gotoPageByName(ctx.context, VipOpenPage.pageName).then((data) {});
}

void _getMemInfo(Action action, Context<MineFragmentState> ctx) {
  //获取vip用户信息
  VIPService.getMemInfo().then((data) {
    if (data.code == 200) {
      ctx.dispatch(MineFragmentActionCreator.updateMemberData(data.data));
    }
  });
}

void _gotoMessage(Action action, Context<MineFragmentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, MessageListPage.pageName).then((data) {
    UserService.getMsgCount().then((data) {
      if (data['code'] == 200) {
        ctx.dispatch(
            MineFragmentActionCreator.updateMsgCount(data['data']['count']));
      }
    });
  });
}

void _onAction(Action action, Context<MineFragmentState> ctx) {
  if (LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, AccountManagePage.pageName,
            arguments: null)
        .then((result) {
      ctx.dispatch(MineFragmentActionCreator.getUserInfo());
    });
  } else {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName).then((data) {
      //刷新页面
      ctx.dispatch(MineFragmentActionCreator.getUserInfo());
    });
  }
}

void _showSign(Action action, Context<MineFragmentState> ctx) {
  if (LoginControl.isLogin()) {
    UserService.getSignList().then((data) {
      if (data.code == 200) {
        showDialog<Null>(
          context: ctx.context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, state) {
              return SignDialog(data.data, () {
                UserService.addSign().then((data) {
                  if (data['code'] == 200) {
                    showToast(getText(name: 'textSignSuccessful'));
                    Navigator.of(context).pop();
                    //更新用户积分
//                    UserInfo userInfo = LoginControl.getUserInfo();
//                    userInfo.data.myIntegral = data['data']['my_integral'];
//                    LoginControl.saveUserInfo(json.encode(userInfo));
                    //通知个人中心更新
                    ctx.dispatch(MineFragmentActionCreator.getUserInfo());
                  }
                });
              });
            });
          },
        );
      }
    });
  } else {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
  }
}

void _getUserInfo(Action action, Context<MineFragmentState> ctx) {
  UserService.getUserInfo().then((UserInfo userInfo) {
    ctx.dispatch(MineFragmentActionCreator.updateUserInfo(userInfo));
  });
}

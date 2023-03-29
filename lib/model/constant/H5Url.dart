import 'package:flutter_huoshu_app/app_config.dart';

class H5Url {
  static final String base_url = AppConfig.baseUrl + "app/post/view/";
  //用户协议
  static final String url_agreement = AppConfig.baseUrl + "app/user/agreement";
  //隐私协议
  static final String url_privacy = AppConfig.baseUrl + "app/app/userprivacy";
  //防沉迷系统说明
  static final String url_Anti_addiction_system = base_url + "2";
  //家长监护
  static final String url_Anti_fraud_instructions = base_url + "17";
  //注销说明
  static final String url_logout_describe = AppConfig.baseUrl + "app/user/accountDestroyText";
}

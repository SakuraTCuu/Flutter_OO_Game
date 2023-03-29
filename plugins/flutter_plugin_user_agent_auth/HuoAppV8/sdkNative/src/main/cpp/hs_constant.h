//
// Created by liu hong liang on 2016/11/11.
//

#ifndef HUOSUSO_HS_CONSTANT_H
#define HUOSUSO_HS_CONSTANT_H

static char *RSA_HS_PUBLIC_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDihk0eBdpiW/HWpWUvwN+OkL4C4a/vC+P9SQap7lZFf9plKFNaMoMVI4VGtjkpTKmdz+vr0g11/Z5V/Ehs9xeft1quw4/gblWR2gK7qAJSs9K2vRBcyiD7V3kEoAd0QVzpyNLmInZ+Mi03WNXUonGqEshEdzfODlwa8V6DBuld9QIDAQAB";
static char *HS_URL_INSTALL2 = "https://hv.huosdk.com/v7/install";
static char *HS_URL_INSTALL = "https://ha.huosdk.com:8443/v7/install";

static char *RSA_CUSTOM_PUBLIC_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDbS65A0j73zyBSDn5aI1yzSGlfJTPW00xHndZmefzo43Hg9D1l74O3BHmObzadWJ4iqBtDFzBpoUyLWdHzm7kkApuw76oYRhJMFlt3GL6GpVgG5Z5I7DjJwxCvs2xg5OgJJPmB9zaUHJkV6qfPEfoFsKaREDkoeNqOvZObQ+Tc+wIDAQAB";//客户公钥
static char *auth_type = "1";//1.不认证，2不强制认证，3强制认证


static char *schema = "http://";
static char *config_pre_url = "testapi.";
static char *config_url = "lekoy.com";
static char *config_suffix_url = "/";
static char *config_ip = "8.134.147.87";

static char *appPackageName = "com.lekoy.huosuapp";

static char *agent_game = "#{agentgame}";

static char *ecagentgame = "#{ecagentgame}";

//渠道编号
static char *config_project_code = "611";

//使用请求地址方式
static char *config_use_url_type = "1";//1域名，2ip

#endif //HUOSUSO_HS_CONSTANT_H


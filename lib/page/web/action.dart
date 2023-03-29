import 'package:fish_redux/fish_redux.dart';
import 'package:webview_flutter/webview_flutter.dart';

//TODO replace with your own action
enum WebPageAction {
  action,
  onWebViewCreated,
  onPageFinished,
  updateUserAgent,
  showPopPageDialog,
}

class WebPageActionCreator {
  static Action onAction() {
    return const Action(WebPageAction.action);
  }

  static Action updateUserAgent(String userAgent) {
    return Action(WebPageAction.updateUserAgent, payload: userAgent);
  }

  static Action onWebViewCreated(WebViewController webViewController) {
    return Action(WebPageAction.onWebViewCreated, payload: webViewController);
  }

  static Action onPageFinished(url) {
    return Action(WebPageAction.onPageFinished, payload: url);
  }

  static Action showPopPageDialog() {
    return const Action(WebPageAction.showPopPageDialog);
  }
}

import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DealListAction { action }

class DealListActionCreator {
  static Action onAction() {
    return const Action(DealListAction.action);
  }
}

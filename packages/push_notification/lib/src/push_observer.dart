import 'package:flutter/widgets.dart';
import 'package:push_notification/src/push_navigator_holder.dart';

/// mixin to get navigator context
class PushObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    PushNavigatorHolder().navigator = this.navigator;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    PushNavigatorHolder().navigator = this.navigator;
  }
}

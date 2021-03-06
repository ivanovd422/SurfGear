import 'dart:collection';

import 'package:push_notification/src/base/push_handle_strategy.dart';
import 'package:push_notification/src/notification/notificator/android/android_notiffication_specifics.dart';
import 'package:push_notification/src/notification/notificator/notification_specifics.dart';
import 'package:push_notification/src/notification/notificator/notificator.dart';

typedef NotificationCallback = void Function(Map<String, dynamic> payload);

const String pushIdParam = 'localPushId';

/// Wrapper over surf notifications
class NotificationController {
  Notificator _notificator;

  Map<int, NotificationCallback> callbackMap =
      HashMap<int, NotificationCallback>();

  NotificationController(OnPemissionDeclineCallback onPermissionDecline) {
    _notificator = Notificator(
      onNotificationTapCallback: _internalOnSelectNotification,
      onPermissionDecline: onPermissionDecline,
    );
  }

  /// Request notification permissions (iOS only)
  Future<bool> requestPermissions() {
    return _notificator.requestPermissions(
      requestSoundPermission: true,
      requestAlertPermission: true,
    );
  }

  /// displaying notification from the strategy
  Future<dynamic> show(PushHandleStrategy strategy,
      NotificationCallback onSelectNotification,) {
    final androidSpecifics = AndroidNotificationSpecifics(
      channelId: strategy.notificationChannelId,
      channelName: strategy.notificationChannelName,
      autoCancelable: strategy.autoCancelable,
      color: strategy.color,
      icon: strategy.icon,
    );

    final platformSpecifics = NotificationSpecifics(androidSpecifics);

    print(
        "DEV_INFO receive for show push : ${strategy.payload.title}, ${strategy
            .payload.body}");

    int pushId = DateTime
        .now()
        .millisecondsSinceEpoch;

    Map<String, String> tmpPayload = strategy.payload.messageData.map(
          (key, value) =>
          MapEntry(
            key.toString(),
            value.toString(),
          ),
    );

    tmpPayload[pushIdParam] = "$pushId";
    callbackMap[pushId] = onSelectNotification;

    return _notificator.show(
      strategy.pushId,
      strategy.payload.title,
      strategy.payload.body,
      data: tmpPayload,
      notificationSpecifics: platformSpecifics,
    );
  }

  Future<dynamic> _internalOnSelectNotification(Map payload) async {
    print('DEV_INFO onSelectNotification, payload: $payload');

    Map<String, dynamic> tmpPayload = payload;
    int pushId = int.parse(tmpPayload[pushIdParam]);
    var onSelectNotification = callbackMap[pushId];
    callbackMap.remove(pushId);

    return onSelectNotification?.call(tmpPayload);
  }
}

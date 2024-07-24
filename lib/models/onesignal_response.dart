import 'dart:convert';

class OneSignalResponse {
  final bool hasNotificationPermission;
  final bool isPushDisabled;
  final bool isSubscribed;
  final String userId;
  final String pushToken;
  final bool isEmailSubscribed;
  final dynamic emailUserId;
  final dynamic emailAddress;
  final bool isSmsSubscribed;
  final dynamic smsUserId;
  final dynamic smsNumber;
  final dynamic notificationPermissionStatus;

  OneSignalResponse({
    required this.hasNotificationPermission,
    required this.isPushDisabled,
    required this.isSubscribed,
    required this.userId,
    required this.pushToken,
    required this.isEmailSubscribed,
    required this.emailUserId,
    required this.emailAddress,
    required this.isSmsSubscribed,
    required this.smsUserId,
    required this.smsNumber,
    required this.notificationPermissionStatus,
  });

  OneSignalResponse copyWith({
    bool? hasNotificationPermission,
    bool? isPushDisabled,
    bool? isSubscribed,
    String? userId,
    String? pushToken,
    bool? isEmailSubscribed,
    dynamic emailUserId,
    dynamic emailAddress,
    bool? isSmsSubscribed,
    dynamic smsUserId,
    dynamic smsNumber,
    dynamic notificationPermissionStatus,
  }) =>
      OneSignalResponse(
        hasNotificationPermission:
            hasNotificationPermission ?? this.hasNotificationPermission,
        isPushDisabled: isPushDisabled ?? this.isPushDisabled,
        isSubscribed: isSubscribed ?? this.isSubscribed,
        userId: userId ?? this.userId,
        pushToken: pushToken ?? this.pushToken,
        isEmailSubscribed: isEmailSubscribed ?? this.isEmailSubscribed,
        emailUserId: emailUserId ?? this.emailUserId,
        emailAddress: emailAddress ?? this.emailAddress,
        isSmsSubscribed: isSmsSubscribed ?? this.isSmsSubscribed,
        smsUserId: smsUserId ?? this.smsUserId,
        smsNumber: smsNumber ?? this.smsNumber,
        notificationPermissionStatus:
            notificationPermissionStatus ?? this.notificationPermissionStatus,
      );

  factory OneSignalResponse.fromRawJson(String str) =>
      OneSignalResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OneSignalResponse.fromJson(Map<String, dynamic> json) =>
      OneSignalResponse(
        hasNotificationPermission: json["hasNotificationPermission"],
        isPushDisabled: json["isPushDisabled"],
        isSubscribed: json["isSubscribed"],
        userId: json["userId"],
        pushToken: json["pushToken"],
        isEmailSubscribed: json["isEmailSubscribed"],
        emailUserId: json["emailUserId"],
        emailAddress: json["emailAddress"],
        isSmsSubscribed: json["isSMSSubscribed"],
        smsUserId: json["smsUserId"],
        smsNumber: json["smsNumber"],
        notificationPermissionStatus: json["notificationPermissionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "hasNotificationPermission": hasNotificationPermission,
        "isPushDisabled": isPushDisabled,
        "isSubscribed": isSubscribed,
        "userId": userId,
        "pushToken": pushToken,
        "isEmailSubscribed": isEmailSubscribed,
        "emailUserId": emailUserId,
        "emailAddress": emailAddress,
        "isSMSSubscribed": isSmsSubscribed,
        "smsUserId": smsUserId,
        "smsNumber": smsNumber,
        "notificationPermissionStatus": notificationPermissionStatus,
      };
}

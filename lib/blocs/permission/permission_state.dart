part of 'permission_bloc.dart';

class PermissionState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;
  final bool isCameraPermissionGranted;
  final bool isPhonePermissionGranted;
  final bool isBackgroundLocationGranted;
  final bool isNotificationGranted;

  bool get isAllGranted =>
      isGpsEnabled &&
      isGpsPermissionGranted &&
      isPhonePermissionGranted &&
      isCameraPermissionGranted &&
      isNotificationGranted &&
      isBackgroundLocationGranted;

  const PermissionState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted,
    required this.isPhonePermissionGranted,
    required this.isCameraPermissionGranted,
    required this.isBackgroundLocationGranted,
    required this.isNotificationGranted,
  });

  PermissionState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
    bool? isPhonePermissionGranted,
    bool? isBackgroundLocationEnabled,
    bool? isDataEnabled,
    bool? isSetPhone,
    bool? isCameraPermissionGranted,
    bool? isBackgroundLocationGranted,
    bool? isNotificationGranted,
    Widget? destinationPage,
  }) =>
      PermissionState(
        isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
        isGpsPermissionGranted:
            isGpsPermissionGranted ?? this.isGpsPermissionGranted,
        isPhonePermissionGranted:
            isPhonePermissionGranted ?? this.isPhonePermissionGranted,
        isCameraPermissionGranted:
            isCameraPermissionGranted ?? this.isCameraPermissionGranted,
        isBackgroundLocationGranted:
            isBackgroundLocationGranted ?? this.isBackgroundLocationGranted,
        isNotificationGranted:
            isNotificationGranted ?? this.isNotificationGranted,
      );

  @override
  List<Object> get props => [
        isGpsEnabled,
        isGpsPermissionGranted,
        isPhonePermissionGranted,
        isCameraPermissionGranted,
        isBackgroundLocationGranted,
        isNotificationGranted,
      ];

  @override
  String toString() {
    return '{ isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted }';
  }
}

part of 'permission_bloc.dart';

abstract class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => [];
}

class GpsAndPermissionEvent extends PermissionEvent {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;
  final bool isPhonePermissionGranted;
  final bool isCameraPermissionGranted;
  final bool isBackgroundLocationGranted;
  final bool isNotificationGranted;

  const GpsAndPermissionEvent({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted,
    required this.isPhonePermissionGranted,
    required this.isCameraPermissionGranted,
    required this.isBackgroundLocationGranted,
    required this.isNotificationGranted,
  });
}

class OnAddPhoneEvent extends PermissionEvent {
  final bool isSetPhone;

  const OnAddPhoneEvent({
    required this.isSetPhone,
  });
}

class OnChangeDestinationPageEvent extends PermissionEvent {
  final Widget destinationPage;

  const OnChangeDestinationPageEvent({
    required this.destinationPage,
  });
}

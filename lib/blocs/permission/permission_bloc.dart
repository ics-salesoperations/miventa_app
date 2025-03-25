import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  StreamSubscription? gpsServiceSubscription;
  StreamSubscription? dataServiceSubscription;

  PermissionBloc()
      : super(const PermissionState(
          isGpsEnabled: false,
          isGpsPermissionGranted: false,
          isPhonePermissionGranted: false,
          isCameraPermissionGranted: false,
          isBackgroundLocationGranted: false,
          isNotificationGranted: false,
        )) {
    on<GpsAndPermissionEvent>((event, emit) {
      return emit(
        state.copyWith(
          isGpsEnabled: event.isGpsEnabled,
          isGpsPermissionGranted: event.isGpsPermissionGranted,
          isPhonePermissionGranted: event.isPhonePermissionGranted,
          isCameraPermissionGranted: event.isCameraPermissionGranted,
          isBackgroundLocationGranted: event.isBackgroundLocationGranted,
          isNotificationGranted: event.isNotificationGranted,
        ),
      );
    });
    on<OnAddPhoneEvent>((event, emit) {
      return emit(
        state.copyWith(
          isSetPhone: event.isSetPhone,
        ),
      );
    });
    on<OnChangeDestinationPageEvent>((event, emit) {
      return emit(
        state.copyWith(
          destinationPage: event.destinationPage,
        ),
      );
    });

    _init();
  }

  Future<void> _init() async {
    //llamar multiples futures simultaneos
    final permissionInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
      _isPhonePermissionGranted(),
      _checkLocBackgroundGranted(),
      _isCameraPermissionGranted(),
      _isNotificationPermissionGranted(),
    ]);

    add(
      GpsAndPermissionEvent(
        isGpsEnabled: permissionInitStatus[0],
        isGpsPermissionGranted: permissionInitStatus[1],
        isPhonePermissionGranted: permissionInitStatus[2],
        isBackgroundLocationGranted: permissionInitStatus[3],
        isCameraPermissionGranted: permissionInitStatus[4],
        isNotificationGranted: permissionInitStatus[5],
      ),
    );
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _isCameraPermissionGranted() async {
    final isGranted = await Permission.camera.isGranted;
    return isGranted;
  }

  Future<bool> _isNotificationPermissionGranted() async {
    final isGranted = await Permission.notification.isGranted;
    return isGranted;
  }

  Future<bool> _checkLocBackgroundGranted() async {
    final isGranted = await Permission.locationAlways.isGranted;
    return isGranted;
  }

  Future<bool> _isPhonePermissionGranted() async {
    final isGranted = await Permission.phone.isGranted;
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();

    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;
      add(
        GpsAndPermissionEvent(
          isGpsEnabled: isEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted,
          isPhonePermissionGranted: state.isPhonePermissionGranted,
          isCameraPermissionGranted: state.isCameraPermissionGranted,
          isBackgroundLocationGranted: state.isBackgroundLocationGranted,
          isNotificationGranted: state.isNotificationGranted,
        ),
      );
    });
    return isEnabled;
  }

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        add(
          GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled,
            isGpsPermissionGranted: true,
            isPhonePermissionGranted: state.isPhonePermissionGranted,
            isCameraPermissionGranted: state.isCameraPermissionGranted,
            isBackgroundLocationGranted: state.isBackgroundLocationGranted,
            isNotificationGranted: state.isNotificationGranted,
          ),
        );
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
          isGpsEnabled: state.isGpsEnabled,
          isGpsPermissionGranted: false,
          isPhonePermissionGranted: state.isPhonePermissionGranted,
          isCameraPermissionGranted: state.isCameraPermissionGranted,
          isBackgroundLocationGranted: state.isBackgroundLocationGranted,
          isNotificationGranted: state.isNotificationGranted,
        ));
        openAppSettings();
    }
  }

  Future<void> askNotificationAccess() async {
    final status = await Permission.notification.request();
    switch (status) {
      case PermissionStatus.granted:
        add(
          GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled,
            isGpsPermissionGranted: state.isGpsPermissionGranted,
            isPhonePermissionGranted: state.isPhonePermissionGranted,
            isCameraPermissionGranted: state.isCameraPermissionGranted,
            isBackgroundLocationGranted: state.isBackgroundLocationGranted,
            isNotificationGranted: true,
          ),
        );
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
          isGpsEnabled: state.isGpsEnabled,
          isNotificationGranted: false,
          isPhonePermissionGranted: state.isPhonePermissionGranted,
          isCameraPermissionGranted: state.isCameraPermissionGranted,
          isBackgroundLocationGranted: state.isBackgroundLocationGranted,
          isGpsPermissionGranted: state.isGpsPermissionGranted,
        ));
        openAppSettings();
    }
  }

  Future<void> askCameraAccess() async {
    final status = await Permission.camera.request();
    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
          isGpsEnabled: state.isGpsEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted,
          isPhonePermissionGranted: state.isPhonePermissionGranted,
          isCameraPermissionGranted: true,
          isBackgroundLocationGranted: state.isBackgroundLocationGranted,
          isNotificationGranted: state.isNotificationGranted,
        ));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(
          GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled,
            isGpsPermissionGranted: state.isGpsPermissionGranted,
            isPhonePermissionGranted: state.isPhonePermissionGranted,
            isCameraPermissionGranted: false,
            isBackgroundLocationGranted: state.isBackgroundLocationGranted,
            isNotificationGranted: state.isNotificationGranted,
          ),
        );
        openAppSettings();
    }
  }

  Future<void> askPhoneAccess() async {
    final status = await Permission.phone.request();
    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
          isPhonePermissionGranted: true,
          isGpsEnabled: state.isGpsEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted,
          isCameraPermissionGranted: state.isCameraPermissionGranted,
          isBackgroundLocationGranted: state.isBackgroundLocationGranted,
          isNotificationGranted: state.isNotificationGranted,
        ));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
          isPhonePermissionGranted: false,
          isGpsEnabled: state.isGpsEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted,
          isCameraPermissionGranted: state.isCameraPermissionGranted,
          isBackgroundLocationGranted: state.isBackgroundLocationGranted,
          isNotificationGranted: state.isNotificationGranted,
        ));
        openAppSettings();
    }
  }

  Future<void> askBackgroundLocation() async {
    final status = await Permission.locationAlways.request();
    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
          isPhonePermissionGranted: state.isPhonePermissionGranted,
          isGpsEnabled: state.isGpsEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted,
          isCameraPermissionGranted: state.isCameraPermissionGranted,
          isNotificationGranted: state.isNotificationGranted,
          isBackgroundLocationGranted: true,
        ));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
          isPhonePermissionGranted: state.isPhonePermissionGranted,
          isGpsEnabled: state.isGpsEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted,
          isCameraPermissionGranted: state.isCameraPermissionGranted,
          isNotificationGranted: state.isNotificationGranted,
          isBackgroundLocationGranted: false,
        ));
        openAppSettings();
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    dataServiceSubscription?.cancel();
    return super.close();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/screens/screens.dart';
import 'package:miventa_app/services/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class CargaInicialScreen extends StatefulWidget {
  const CargaInicialScreen({super.key});

  @override
  State<CargaInicialScreen> createState() => _CargaInicialScreenState();
}

class _CargaInicialScreenState extends State<CargaInicialScreen> {
  late AuthBloc authBloc;
  final _storage = const FlutterSecureStorage();

  AuthService _auth = AuthService();

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(
      const OnCheckLoginEvent(
        checkLoginFinish: false,
      ),
    );

    initPlatform();
    super.initState();
  }

  Future<void> initPlatform() async {
    //Remove this method to stop OneSignal Debugging

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId("3e2e02ee-9589-44b2-8eba-c03f11a6d25a");
    OneSignal.shared.setLanguage('English');

    // You will supply the external user id to the OneSignal SDK
    OneSignal.shared.setExternalUserId("321971");

    await OneSignal.shared.sendTag("App", "MiVenta");
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});

    await OneSignal.shared.getDeviceState().then((deviceState) async {
      if (deviceState != null) {
        final respuesta = OneSignalResponse.fromJson(
            jsonDecode(deviceState.jsonRepresentation()));

        _auth.guardarTokenOS(respuesta.userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<PermissionBloc, PermissionState>(
      builder: (context, permissionState) {
        if (permissionState.isAllGranted) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              // if (!state.checkLoginFinish) {
              //   return Container();
              // }

              if (state.autenticado) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, 'home');
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, '/');
                });
              }
              return Container();
            },
          );
        } else {
          return const PermisosAccessScreen();
        }
      },
    ));
  }
}

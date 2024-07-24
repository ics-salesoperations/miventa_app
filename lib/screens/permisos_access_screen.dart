import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';

class PermisosAccessScreen extends StatefulWidget {
  const PermisosAccessScreen({Key? key}) : super(key: key);

  @override
  State<PermisosAccessScreen> createState() => _PermisosAccessScreenState();
}

class _PermisosAccessScreenState extends State<PermisosAccessScreen> {
  @override
  Widget build(BuildContext context2) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<PermissionBloc, PermissionState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Permisos necesarios para utilizar esta aplicación",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 24,
                            fontFamily: 'CronosSPro',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      !state.isGpsEnabled
                          ? const _EnableGpsMessage()
                          : Container(),
                      !state.isGpsPermissionGranted
                          ? const Divider()
                          : Container(),
                      !state.isGpsPermissionGranted
                          ? const _AccessButton()
                          : Container(),
                      !state.isBackgroundLocationGranted
                          ? const Divider()
                          : Container(),
                      !state.isBackgroundLocationGranted
                          ? const _AccessBackLocationButton()
                          : Container(),
                      !state.isPhonePermissionGranted
                          ? const Divider()
                          : Container(),
                      !state.isPhonePermissionGranted
                          ? const _AccessPhoneStateButton()
                          : Container(),
                      !state.isCameraPermissionGranted
                          ? const Divider(
                              height: 50,
                            )
                          : Container(),
                      !state.isCameraPermissionGranted
                          ? const _AccessCameraButton()
                          : Container(),
                      !state.isNotificationGranted
                          ? const Divider()
                          : Container(),
                      !state.isNotificationGranted
                          ? const _AccessNotificationButton()
                          : Container(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AccessButton extends StatefulWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_AccessButton> createState() => _AccessButtonState();
}

class _AccessButtonState extends State<_AccessButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: Text(
            "Es necesario el acceso al GPS",
            style: TextStyle(fontSize: 18, fontFamily: 'CronosLPro'),
          ),
        ),
        MaterialButton(
            color: kPrimaryColor,
            shape: const StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            onPressed: () async {
              final permissionBloc = BlocProvider.of<PermissionBloc>(context);
              await permissionBloc.askGpsAccess();
            },
            child: const Text(
              "Solicitar Acceso",
              style: TextStyle(color: Colors.white, fontFamily: 'CronosLPro'),
            ))
      ],
    );
  }
}

class _AccessBackLocationButton extends StatefulWidget {
  const _AccessBackLocationButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_AccessBackLocationButton> createState() =>
      _AccessBackLocationButtonState();
}

class _AccessBackLocationButtonState extends State<_AccessBackLocationButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: Text(
            "Es necesario Acceso a la localización en Background.",
            style: TextStyle(fontSize: 18, fontFamily: 'CronosLPro'),
          ),
        ),
        MaterialButton(
          color: kPrimaryColor,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const BackgroundPolicy(),
            );
          },
          child: const Text(
            "Solicitar Acceso ",
            style: TextStyle(color: Colors.white, fontFamily: 'CronosLPro'),
          ),
        )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Debe habilitar el GPS',
      style: TextStyle(fontSize: 18, fontFamily: 'CronosLPro'),
    );
  }
}

class _AccessPhoneStateButton extends StatelessWidget {
  const _AccessPhoneStateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: Text(
            "Es necesario Acceso a Datos del Teléfono",
            style: TextStyle(fontSize: 18, fontFamily: 'CronosLPro'),
          ),
        ),
        MaterialButton(
          color: kPrimaryColor,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: () {
            final permissionBloc = BlocProvider.of<PermissionBloc>(context);
            permissionBloc.askPhoneAccess();
          },
          child: const Text(
            "Solicitar Acceso ",
            style: TextStyle(color: Colors.white, fontFamily: 'CronosLPro'),
          ),
        )
      ],
    );
  }
}

class _AccessCameraButton extends StatelessWidget {
  const _AccessCameraButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: Text(
            "Es necesario Acceso a la cámara",
            style: TextStyle(fontSize: 18, fontFamily: 'CronosLPro'),
          ),
        ),
        MaterialButton(
          color: kPrimaryColor,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: () {
            final permissionBloc = BlocProvider.of<PermissionBloc>(context);
            permissionBloc.askCameraAccess();
          },
          child: const Text(
            "Solicitar Acceso ",
            style: TextStyle(color: Colors.white, fontFamily: 'CronosLPro'),
          ),
        )
      ],
    );
  }
}

class _AccessNotificationButton extends StatelessWidget {
  const _AccessNotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: Text(
            "Es necesario Acceso a las notificaciones",
            style: TextStyle(fontSize: 18, fontFamily: 'CronosLPro'),
          ),
        ),
        MaterialButton(
          color: kPrimaryColor,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: () async {
            final permissionBloc = BlocProvider.of<PermissionBloc>(context);
            await permissionBloc.askNotificationAccess();
          },
          child: const Text(
            "Solicitar Acceso ",
            style: TextStyle(color: Colors.white, fontFamily: 'CronosLPro'),
          ),
        )
      ],
    );
  }
}

class BackgroundPolicy extends StatelessWidget {
  const BackgroundPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionBloc = BlocProvider.of<PermissionBloc>(context);

    return AlertDialog(
      title: const Text(
        "Localización en Background",
        style: TextStyle(
          fontFamily: 'CronosSPro',
          fontSize: 18,
          color: kSecondaryColor,
        ),
      ),
      content: const Text(
        "Esta aplicación utiliza la localización en background para poder capturar la localización de cada una de las tomas del Nivel de Señal incluso cuando no estes usando la aplicación.",
        style: TextStyle(
          fontFamily: 'CronosLPro',
          fontSize: 16,
          color: kSecondaryColor,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancelar",
            style: TextStyle(
              fontFamily: 'CronosLPro',
              fontSize: 16,
              color: kPrimaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            permissionBloc.askBackgroundLocation();
            Navigator.pop(context);
          },
          child: const Text(
            "Aceptar",
            style: TextStyle(
              fontFamily: 'CronosLPro',
              fontSize: 16,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

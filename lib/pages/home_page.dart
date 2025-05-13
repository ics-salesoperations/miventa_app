import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/pages/pages.dart';
import 'package:miventa_app/pages/tracking_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';
import '../services/services.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;
  final List<Circuito> circuitos;
  final DateTime? fecha;

  const HomePage({
    super.key,
    this.selectedIndex = 1,
    this.circuitos = const [],
    this.fecha,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  DBService db = DBService();
  late NavigationBloc navBloc;
  late AuthBloc authBloc;
  late MapBloc mapBloc;
  late AnimationController animationController;
  late TabController ctrlTab;

  @override
  void initState() {
    mapBloc = BlocProvider.of<MapBloc>(context);
    inicializarMapa();

    navBloc = BlocProvider.of<NavigationBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    ctrlTab = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );

    selecionarMenu();

    super.initState();
    //Inicio de One Signal
    //initPlatform();
  }

  Future<void> inicializarMapa() async {
    if (widget.circuitos.isNotEmpty) {
      await mapBloc.drawMarkersCircuito(
        circuitos: widget.circuitos,
        context2: context,
        fecha: widget.fecha,
      );
    } else {
      UsuarioService usr = UsuarioService();
      Usuario usuario = await usr.getInfoUsuario();
      if (usuario.perfil == 89) {
        final circuitos = await db.leerPlanningCircuitos(
          fecha: DateTime.now(),
        );

        await mapBloc.drawMarkersCircuito(
          circuitos: circuitos,
          context2: context,
          fecha: DateTime.now(),
        );
      } else {
        await mapBloc.drawMarkers(
          context2: context,
        );
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    ctrlTab.dispose();
    super.dispose();
  }

  void selecionarMenu() {
    switch (widget.selectedIndex) {
      case 0:
        navBloc.add(
          OnChangePageEvent(
            selectedPage: TrackingPage(
              controlador: animationController,
            ),
          ),
        );
        break;
      case 1:
        navBloc.add(
          const OnChangePageEvent(
            selectedPage: InicioPage(),
          ),
        );
        break;
      case 2:
        navBloc.add(
          const OnChangePageEvent(
            selectedPage: MapaPage(),
          ),
        );
        break;
      default:
    }
  }

  void showUPdateAvailable(
    BuildContext context,
    String current,
    String newVersion,
    String packageUrl,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          padding: const EdgeInsets.all(16),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Nueva Actualización",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'CronosSPro',
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Tienes una versión de Mi Venta desactualizada. ¡Hay una nueva versión disponible!",
                style: TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'CronosLPro',
                  fontSize: 16,
                ),
              ),
              Text(
                "Versión anterior: " + current,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'CronosLPro',
                  fontSize: 16,
                ),
              ),
              Text(
                "Versión disponible: " + newVersion,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'CronosLPro',
                  fontSize: 16,
                ),
              ),
            ],
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
            onPressed: () async {
              await launchUrl(
                Uri.parse(packageUrl),
                mode: LaunchMode.externalNonBrowserApplication,
              );
            },
            child: const Text(
              "Actualizar",
              style: TextStyle(
                fontFamily: 'CronosLPro',
                fontSize: 16,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(245, 245, 245, 252),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          toolbarHeight: 40,
          elevation: 0,
          leading: Container(),
          title: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  authBloc.state.usuario.nombre.toString(),
                  style: const TextStyle(
                    fontFamily: 'CronosLPro',
                    fontSize: 18,
                    color: kSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const VerticalDivider(),
                  GestureDetector(
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 26,
                    ),
                    onTap: () {
                      authBloc.add(
                        OnLogoutEvent(),
                      );
                      Navigator.pushNamed(
                        context,
                        'login',
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: state.selectedPage,
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.react,
          backgroundColor: kSecondaryColor,
          activeColor: kPrimaryColor,
          controller: ctrlTab,
          items: const [
            TabItem(
              icon: FontAwesomeIcons.towerCell,
              title: "Mi Señal",
            ),
            TabItem(
              icon: FontAwesomeIcons.house,
              title: "Inicio",
            ),
            TabItem(
              icon: FontAwesomeIcons.mapLocationDot,
              title: "Mapa",
            ),
          ],
          onTap: (int i) {
            switch (i) {
              case 0:
                navBloc.add(
                  OnChangePageEvent(
                    selectedPage: TrackingPage(
                      controlador: animationController,
                    ),
                  ),
                );
                break;
              case 1:
                navBloc.add(
                  const OnChangePageEvent(
                    selectedPage: InicioPage(),
                  ),
                );
                break;
              case 2:
                final circuitos = mapBloc.state.circuitosSeleccionados;
                mapBloc.drawMarkersCircuito(
                    circuitos: circuitos, context2: context);
                navBloc.add(
                  const OnChangePageEvent(
                    selectedPage: MapaPage(),
                  ),
                );
                break;
              default:
            }
          },
        ),
      ),
    );
  }

  Future<void> initPlatform() async {
    //Remove this method to stop OneSignal Debugging
    /*OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId("3e2e02ee-9589-44b2-8eba-c03f11a6d25a");
    OneSignal.shared.setLanguage('English');

    // You will supply the external user id to the OneSignal SDK
    OneSignal.shared
        .setExternalUserId(authBloc.state.usuario.usuario.toString());

    await OneSignal.shared.sendTag("App", "MiVenta");
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
    await OneSignal.shared.getDeviceState().then((deviceState) {
      print("DeviceState: ${deviceState?.jsonRepresentation()}");
    });*/
  }
}

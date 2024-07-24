//aqui definimos todas las rutas que tendra nuestra aplicacion
import 'package:flutter/material.dart';
import 'package:miventa_app/pages/pages.dart';
import 'package:miventa_app/screens/screens.dart';
import 'package:miventa_app/views/views.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  '/': (_) => const OnBoardingPage(),
  'home': (_) => const HomePage(),
  'login': (_) => const LoginPage(),
  'perfil': (_) => const MiPerfilPage(),
  'inicial': (_) => const CargaInicialScreen(),
  'permisos': (_) => const PermisosAccessScreen(),
  'actualizar': (_) => const ActualizarPage(),
  'modificaciones': (_) => const BusquedaPage(),
  'sincronizar': (_) => const SincronizarPage(),
  'planificacion': (_) => const PlanificacionPage(),
  'reportes': (_) => const ReportesPage(),
  'inventario': (_) => const InventarioPage(),
};

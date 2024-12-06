import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/routes/routes.dart';

bool? seenOnboard;
// !Levantar uvicorn... 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
          create: (context) => LocationBloc(),
        ),
        BlocProvider(
          create: (context) => FilterBloc(),
        ),
        BlocProvider(
          create: (context) => PermissionBloc(),
        ),
        BlocProvider(
          create: (context) => SyncBloc(),
        ),
        BlocProvider(
          create: (context) => ActualizarBloc(),
        ),
        BlocProvider(
          create: (context) => PlanningBloc(),
        ),
        BlocProvider(
          create: (context) => VisitaBloc(),
        ),
        BlocProvider(
          create: (context) => FormularioBloc(),
        ),
        BlocProvider(
          create: (context) => CarritoBloc(),
        ),
        BlocProvider(
          create: (context) => CarritoReasignacionBloc(),
        ),
        BlocProvider(
          create: (context) => NetworkInfoBloc(),
        ),
        BlocProvider(
          create: (context) => SpeedTestBloc(),
        ),
        BlocProvider(
          create: (context) => InventarioBloc(),
        ),
        BlocProvider(
          create: (context) => InventarioReasignadoBloc(),
        ),
        BlocProvider(
          create: (context) => MapBloc(
            locationBloc: BlocProvider.of<LocationBloc>(context),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

//prueba
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Venta',
      initialRoute: 'inicial',
      routes: appRoutes,
      theme: ThemeData(fontFamily: 'Cronos-Pro'),
    );
  }
}

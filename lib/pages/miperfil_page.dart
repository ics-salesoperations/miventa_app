import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/auth/auth_bloc.dart';
import 'package:miventa_app/screens/cambiar_foto_screen.dart';

class MiPerfilPage extends StatefulWidget {
  const MiPerfilPage({super.key});

  @override
  State<MiPerfilPage> createState() => _MiPerfilPageState();
}

class _MiPerfilPageState extends State<MiPerfilPage> {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    Size screenSize = MediaQuery.of(context).size;
    EdgeInsets screenPadding = MediaQuery.of(context).padding;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              25,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(253, 253, 252, 251),
              blurRadius: 1,
              offset: Offset(1, 1),
            )
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  top: MediaQuery.of(context).padding.top + 12,
                ),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    //bottomRight: Radius.circular(85),
                    bottomLeft: Radius.circular(85),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(
                        253,
                        250,
                        250,
                        250,
                      ),
                      offset: Offset(1, 1),
                      blurRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_outlined,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Stack(
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: const Color(0xff1BB5FD),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                backgroundImage: state.usuario.foto == "null"
                                    ? const AssetImage(
                                        "assets/user_icon_cyan.png",
                                      )
                                    : Image.memory(
                                        base64.decode(
                                          state.usuario.foto!,
                                        ),
                                      ).image,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CambiarFotoScreen(),
                                  );
                                },
                                child: const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircleAvatar(
                                    backgroundColor: Color.fromARGB(
                                      218,
                                      252,
                                      252,
                                      251,
                                    ),
                                    radius: 10,
                                    child: Center(
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Text(
                              authBloc.state.usuario.nombre!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: kSecondaryColor,
                                fontFamily: 'Cronos-Pro',
                              ),
                            ),
                            const Text(
                              "Versión 3.6.0",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: kFourColor,
                                fontFamily: 'Cronos-Pro',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: screenSize.height -
                    screenPadding.top -
                    screenPadding.bottom -
                    333,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                  children: <Widget>[
                    buildUserInfoDisplay(
                      authBloc.state.usuario.usuario!.toLowerCase(),
                      "Usuario",
                      screenSize.width,
                    ),
                    buildUserInfoDisplay(
                      authBloc.state.usuario.correo!.toLowerCase(),
                      "Correo",
                      screenSize.width,
                    ),
                    buildUserInfoDisplay(
                      authBloc.state.usuario.perfil.toString(),
                      "Perfil",
                      screenSize.width,
                    ),
                    buildUserInfoDisplay(
                      authBloc.state.usuario.idDms.toString(),
                      "Id DMS",
                      screenSize.width,
                    ),
                    buildUserInfoDisplay(
                      authBloc.state.usuario.telefono.toString(),
                      "Telefono",
                      screenSize.width,
                    ),
                    buildUserInfoDisplay(
                      authBloc.state.usuario.identidad.toString(),
                      "Identidad",
                      screenSize.width,
                    ),
                    buildUserInfoDisplay(
                      authBloc.state.usuario.territorio.toString(),
                      "Territorio",
                      screenSize.width,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserInfoDisplay(
    String getValue,
    String title,
    double screenWidth,
  ) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: screenWidth * 0.8,
              height: 65,
              padding: const EdgeInsets.only(
                top: 20,
                left: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  getValue,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: 30,
                width: 90,
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.08),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(45),
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

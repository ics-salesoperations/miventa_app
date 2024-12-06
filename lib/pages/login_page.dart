import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/routes/logo.dart';
import 'package:miventa_app/widgets/boton_azul.dart';
import 'package:miventa_app/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final usuarioCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  void validarLogin() {
    authBloc.add(
      OnLoginEvent(
        usuario: usuarioCtrl.text.trim(),
        password: passCtrl.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.autenticado) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(context, 'home');
              });
            }

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.black12,
                          )
                        ],
                      ),
                      margin: const EdgeInsets.only(bottom: 27),
                      padding: const EdgeInsets.all(2),
                      child: Image.asset(
                        'assets/images/iconoLogin.png',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: <Widget>[
                          CustomInput(
                            icon: Icons.person,
                            placeholder: 'Usuario',
                            keyboardtype: TextInputType.text,
                            textController: usuarioCtrl,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomInput(
                            icon: Icons.lock_outline,
                            placeholder: 'Contraseña',
                            keyboardtype: TextInputType.text,
                            textController: passCtrl,
                            isPassword: true,
                          ),
                          state.fallido
                              ? const SizedBox(
                                  height: 5,
                                )
                              : Container(),
                          state.fallido
                              ? Container(
                                  height: 50,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.info_sharp,
                                        color: kThirdColor,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                150,
                                        child: Text(
                                          "${state.intentos} intentos fallidos.",
                                          maxLines: 3,
                                          style: const TextStyle(
                                              color: kSecondaryColor,
                                              fontSize: 14,
                                              fontFamily: 'CronosLPro'),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(
                                  height: 10,
                                ),
                          BotonAzul(
                            text: 'Iniciar Sesión',
                            onPressed: () => validarLogin(),
                            procesando: state.procesando,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      "Powered by",
                      style: TextStyle(
                        color: kFourColor,
                        fontFamily: 'CronosLPro',
                        fontSize: 16,
                      ),
                    ),
                    const Logo(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/db_service.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class CambiarFotoScreen extends StatefulWidget {
  @override
  State<CambiarFotoScreen> createState() => _CambiarFotoScreenState();
}

class _CambiarFotoScreenState extends State<CambiarFotoScreen> {
  late AuthBloc authBloc;
  DBService _db = DBService();

  final formFoto = FormGroup({
    'userFoto': FormControl<ImageFile>(),
  });

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 600,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/change_photo.json',
                    width: 200,
                    height: 200,
                    animate: true,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    //height: 100,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffcccaaa),
                          blurRadius: 5,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ReactiveForm(
                      formGroup: formFoto,
                      child: ReactiveImagePicker(
                        formControlName: "userFoto",
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          floatingLabelStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: 'CronosSPro',
                            color: kSecondaryColor,
                          ),
                          filled: false,
                          border: InputBorder.none,
                        ),
                        inputBuilder: (onPressed) => GestureDetector(
                          onTap: onPressed,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.camera,
                                color: kThirdColor,
                                size: 40,
                              ),
                              VerticalDivider(),
                              Text(
                                "Tomar foto",
                                style: TextStyle(
                                  fontFamily: 'CronosLPro',
                                  color: kSecondaryColor,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        maxHeight: 800,
                        maxWidth: 800,
                        popupDialogBuilder: obtenerImagen,
                        errorPickBuilder: (source, {BuildContext? context}) {
                          print(source.name);
                        },
                        imageViewBuilder: (imagen) {
                          return Image.file(
                            imagen.image!,
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        elevation: 1,
                        disabledColor: Colors.grey,
                        color: kSecondaryColor,
                        onPressed: () async {
                          final imageFile = File((formFoto
                                  .controls["userFoto"]!.value as ImageFile)
                              .image!
                              .path);

                          Uint8List imagebytes =
                              await imageFile.readAsBytes(); //convert to bytes
                          final imagen = base64.encode(imagebytes);

                          Usuario usuario = authBloc.state.usuario;
                          usuario = usuario.copyWith(foto: imagen);

                          await _db.updateUsuario(usuario);
                          authBloc.add(
                            OnActualizarFotoEvent(
                              foto: imagen,
                            ),
                          );
                          Navigator.pop(context, true);
                        },
                        child: const Text(
                          "Confirmar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'CronosLPro',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      MaterialButton(
                        elevation: 1,
                        color: kSecondaryColor,
                        onPressed: () async {
                          Navigator.pop(context, false);
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'CronosLPro',
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

void obtenerImagen(
  BuildContext context,
  ImagePickCallback pickImage,
) {
  pickImage.call(context, ImageSource.camera);
}

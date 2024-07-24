import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class SOPhotoCustom extends StatelessWidget {
  final String campo;
  final String label;

  const SOPhotoCustom({
    Key? key,
    required this.campo,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveImagePicker(
      formControlName: campo,
      validationMessages: {
        ValidationMessage.required: (error) => '$label es requerido',
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontFamily: 'CronosLPro',
          color: kSecondaryColor,
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 16,
          fontFamily: 'CronosSPro',
          color: kSecondaryColor,
        ),
        filled: false,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        disabledBorder: InputBorder.none,
        helperText: '',
      ),
      inputBuilder: (onPressed) => TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.camera_alt_rounded),
        label: const Text(
          'Subir Foto',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'CronosLPro',
          ),
        ),
      ),
      maxHeight: 480,
      maxWidth: 480,
      popupDialogBuilder: obtenerImg,
      imageViewBuilder: (imagen) {
        return Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(20),
          child: Image.file(imagen.image!),
        );
      },
    );
  }
}

void obtenerImg(
  BuildContext context,
  ImagePickCallback pickImage,
) {
  pickImage.call(context, ImageSource.camera);
}

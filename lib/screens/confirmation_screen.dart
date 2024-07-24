import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';

class ConfirmationScreen extends StatefulWidget {
  final String mensaje;
  const ConfirmationScreen({Key? key, required this.mensaje}) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/thinking.json',
              width: 250,
              height: 250,
              animate: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                widget.mensaje,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 16,
                  fontFamily: 'CronosLPro',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  elevation: 4,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    "Si",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontFamily: 'CronosSPro',
                      fontSize: 16,
                    ),
                  ),
                ),
                MaterialButton(
                  elevation: 4,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontFamily: 'CronosSPro',
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

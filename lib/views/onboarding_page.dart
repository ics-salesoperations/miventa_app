import 'package:flutter/material.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/main.dart';
import 'package:miventa_app/models/onboard_data.dart';
import 'package:miventa_app/size_configs.dart';
import 'package:miventa_app/widgets/buttons/my_text_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final _checker = AppVersionChecker();

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kSecondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Future setSeenonboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seenOnboard = await prefs.setBool('seenOnboard', true);
    // this will set seenOnboard to true when running onboard page for first time.
  }

  @override
  void initState() {
    super.initState();
    setSeenonboard();
    checkVersion();
  }

  void checkVersion() async {
    _checker.checkUpdate().then((value) {
      if (value.canUpdate) {
        showUPdateAvailable(
          context,
          value.currentVersion,
          value.newVersion.toString(),
          value.appURL.toString(),
        );
      }
    });
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
    // initialize size config
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 9,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: onboardingContents.length,
              itemBuilder: (context, index) => Column(
                children: [
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  Text(
                    onboardingContents[index].title,
                    style: kTitle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  SizedBox(
                    height: sizeV * 50,
                    child: Image.asset(
                      onboardingContents[index].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: kBodyText1,
                      children: const [
                        TextSpan(text: 'RECUERDA SIEMPRE '),
                        TextSpan(
                          text: 'SER CORDIAL ',
                          style: TextStyle(
                            color: kPrimaryColor,
                          ),
                        ),
                        TextSpan(text: 'CON NUESTROS PUNTOS DE VENTA '),
                        TextSpan(text: 'PARA TRANSMITIR NUESTRA '),
                        TextSpan(
                          text: 'SANGRE TIGO',
                          style: TextStyle(
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  currentPage == onboardingContents.length - 1
                      ? Expanded(
                          child: MyTextButton(
                            buttonName: 'COMENCEMOS',
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, 'login');
                            },
                            bgColor: kPrimaryColor,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: List.generate(
                                onboardingContents.length,
                                (index) => dotIndicator(index),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

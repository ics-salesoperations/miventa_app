class OnBoarding {
  final String title;
  final String image;

  OnBoarding({
    required this.title,
    required this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'Bienvenido a \n Mi Venta',
    image: 'assets/images/onboarding_image_1.png',
  ),
  OnBoarding(
    title: 'SÉ PUNTUAL EN TU PLAN DE RUTA',
    image: 'assets/images/onboarding_image_2.png',
  ),
  OnBoarding(
    title: 'ES PARTE DE TU RENDIMIENTO SEMANAL',
    image: 'assets/images/onboarding_image_3.png',
  ),
  OnBoarding(
    title: 'DISFRUTA DE TU APP MI VENTA',
    image: 'assets/images/onboarding_image_4.png',
  ),
];

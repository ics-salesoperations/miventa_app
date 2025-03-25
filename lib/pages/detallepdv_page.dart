import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/pages/detallepdv_info_page.dart';
import 'package:miventa_app/pages/detallepdv_prepago_page.dart';
import 'package:miventa_app/pages/detallepdv_tmy_page.dart';
import 'package:miventa_app/pages/detallepdv_ejecucion_page.dart';
import 'package:miventa_app/widgets/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetallePdvPage extends StatefulWidget {
  final Planning detallePdv;

  const DetallePdvPage({super.key, required this.detallePdv});

  @override
  State<DetallePdvPage> createState() =>
      _DetallePdvPageState(detallePdv: detallePdv);
}

class _DetallePdvPageState extends State<DetallePdvPage> {
  Planning detallePdv;
  final _controller = PageController();
  _DetallePdvPageState({required this.detallePdv});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      body: CustomPaint(
        painter: HeaderPicoPainter(),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              child: InkWell(
                splashColor: kPrimaryColor,
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetallePDVHeader(
                  detalle: detallePdv,
                  titulo: 'Información del PDV',
                ),

                Expanded(
                  child: PageView(
                    controller: _controller,
                    children: [
                      DetallePdvInfo(detallePdv: detallePdv),
                      DetallePdvPre(detallePdv: detallePdv),
                      DetallePdvEjecucion(detallePdv: detallePdv),
                      DetallePdvTmy(detallePdv: detallePdv),
                      //DetallePdvAct(detallePdv: detallePdv),
                    ],
                  ),
                ),

                // dot indicators
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const JumpingDotEffect(
                    activeDotColor: kSecondaryColor,
                    dotColor: kFourColor,
                    dotHeight: 12,
                    dotWidth: 12,
                    spacing: 16,
                    //verticalOffset: 50,
                    jumpScale: 3,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';

class ProcessingScreenSenal extends StatefulWidget {
  const ProcessingScreenSenal({Key? key}) : super(key: key);

  @override
  State<ProcessingScreenSenal> createState() => _ProcessingScreenSenalState();
}

class _ProcessingScreenSenalState extends State<ProcessingScreenSenal>
    with TickerProviderStateMixin {
  late Animation<double> agrandar;
  late AnimationController btnController;

  @override
  void initState() {
    super.initState();
    btnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    agrandar = Tween(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: btnController,
        curve: Curves.easeOut,
      ),
    );

    //Agregamos un listener
    btnController.addListener(() {
      if (btnController.status == AnimationStatus.completed) {
        btnController.repeat();
      }
    });
  }

  @override
  void dispose() {
    btnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      //padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white.withOpacity(0.95),
      ),
      child: BlocBuilder<NetworkInfoBloc, NetworkInfoState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -9,
                right: -9,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  color: kThirdColor,
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*LoadingAnimationWidget.stretchedDots(
                      color: kThirdColor,
                      size: 60.0,
                    ),*/
                    Text(
                      state.mensaje,
                      style: const TextStyle(
                        fontFamily: 'CronosLPro',
                        fontSize: 18,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

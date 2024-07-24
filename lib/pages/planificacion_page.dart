import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/pages/pages.dart';
import 'package:miventa_app/widgets/widgets.dart';

class PlanificacionPage extends StatefulWidget {
  const PlanificacionPage({Key? key}) : super(key: key);

  @override
  _PlanificacionPageState createState() => _PlanificacionPageState();
}

class _PlanificacionPageState extends State<PlanificacionPage> {
  DateTime _selectedDate = DateTime.now();
  DatePickerController controlador = DatePickerController();
  late PlanningBloc planningBloc;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_Es', null);
    planningBloc = BlocProvider.of<PlanningBloc>(context);
    planningBloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(
          255,
          253,
          251,
          251,
        ),
        child: CustomPaint(
          painter: HeaderPicoPainter(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              _addTaskBar(),
              _addDateBar(),
              const SizedBox(
                height: 10,
              ),
              _showCircuitos(),
            ],
          ),
        ),
      ),
    );
  }

  _showCircuitos() {
    return Expanded(
      child: BlocBuilder<PlanningBloc, PlanningState>(
        builder: (context, state) {
          if (!state.circuitosActualizados) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: state.circuitos.length,
              itemBuilder: (_, index) {
                final circuito = state.circuitos[index];

                if (DateFormat('dd-MM-yyyy').format(circuito.fecha!) ==
                    DateFormat('dd-MM-yyyy').format(_selectedDate)) {
                  final segmentado = state.segmentado
                      .where(
                        (element) =>
                            element.codigoCircuito == circuito.codigoCircuito,
                      )
                      .toList();

                  return GestureDetector(
                    child: TaskTile(
                      circuito: circuito,
                      segmentado: segmentado,
                    ),
                    onTap: () async {
                      /*final mapBloc = BlocProvider.of<MapBloc>(context);

                      await mapBloc.drawMarkersCircuito(
                        circuitos: [circuito],
                        context2: context,
                        fecha: circuito.fecha
                      );*/

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            selectedIndex: 2,
                            circuitos: [circuito],
                            fecha: circuito.fecha,
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              });
        },
      ),
    );
  }

  _addDateBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controlador.animateToDate(
        _selectedDate,
        curve: Curves.easeInOut,
      );
    });

    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        //left: 20,
      ),
      child: DatePicker(
        DateTime(DateTime.now().year, DateTime.now().month),
        height: 100,
        width: 80,
        controller: controlador,
        initialSelectedDate: _selectedDate,
        locale: 'es_ES',
        daysCount: 40,
        selectionColor: kPrimaryColor,
        selectedTextColor: kSecondaryColor,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: kPrimaryColor,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat.yMMMd('es_Es').format(DateTime.now()),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'CronosLPro',
                  fontSize: 24,
                ),
              ),
              const Text(
                "Hoy",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'CronosSPro',
                  fontSize: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

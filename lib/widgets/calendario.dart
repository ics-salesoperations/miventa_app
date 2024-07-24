import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class Calendario extends StatefulWidget {
  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  @override
  Widget build(BuildContext context) {
    //late CalendarBloc blcCalendario;

    @override
    void initState() {
      super.initState();
      //blcCalendario = BlocProvider.of<CalendarBloc>(context);
      //blcCalendario.add(OnNuevaCitaEvent(const Cita('Prueba')));
    }

    return Expanded(
      child: WeekView(
        controller: EventController(),
        eventTileBuilder: (date, events, boundry, start, end) {
          // Return your widget to display as event tile.
          return Container();
        },
        minDay: DateTime.now(),
        width: MediaQuery.of(context).size.width, // width of week view.
        heightPerMinute: 1, // height occupied by 1 minute time span.
        eventArranger:
            const SideEventArranger(), // To define how simultaneous events will be arranged.
        onEventTap: (events, date) => print(events),
        onDateLongPress: (date) => print(date),
        //timeLineBuilder: DateTime.utc(1989, 11, 9),
      ),
    );
  }
}

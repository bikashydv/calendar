import 'package:calendar/screens/meeting.dart';
import 'package:calendar/screens/meeting_data_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime StartTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = StartTime.add(Duration(hours: 2));
    meetings.add(
        Meeting('Confrance', StartTime, endTime, Color(0xFF0f8644), false));
    meetings.add(Meeting('Confrance1', StartTime.add(Duration(hours: 3)),
        endTime.add(Duration(hours: 3)), Color(0xFF0f8644), false));

    return meetings;
  }

  CalendarController calendarController = CalendarController();
  CalendarView calendarView = CalendarView.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      calendarView = CalendarView.month;
                      calendarController.view = calendarView;
                    });
                  },
                  child: Text("Month View")),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      calendarView = CalendarView.week;
                      calendarController.view = calendarView;
                    });
                  },
                  child: Text("Week View")),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      calendarView = CalendarView.day;
                      calendarController.view = calendarView;
                    });
                  },
                  child: Text("Day View")),
            ],
          ),
          Expanded(
            child: SfCalendar(
              ///before i use this
              // view: CalendarView.month,
              //// Than after this
              view: calendarView,

              //pop 
              initialSelectedDate: DateTime.now(),
              controller: calendarController,
              cellBorderColor: Colors.transparent,
              dataSource: MeetingDataSource(_getDataSource()),
              selectionDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  shape: BoxShape.rectangle),
              //To display the events inside the box of date //
              // monthViewSettings: MonthViewSettings(
              //     appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
              monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                  showAgenda: true),
              blackoutDates: [
                DateTime.now().subtract(Duration(hours: 48)),
                DateTime.now().subtract(Duration(hours: 34))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

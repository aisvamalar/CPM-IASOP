import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shimmer/shimmer.dart';

class PCalendarScreen extends StatefulWidget {
  @override
  _PCalendarScreenState createState() => _PCalendarScreenState();
}

class _PCalendarScreenState extends State<PCalendarScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Example events with doctor descriptions
    return [
      Event('Appointment with Dr. Smith', 'General Practitioner'),
      Event('Yoga Session', 'Yoga Instructor'),
      Event('Medication Reminder', 'Pharmacist'),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);

      // Show the animated popup
      _showEventsPopup(context, selectedDay, _selectedEvents.value);
    }
  }

  void _showEventsPopup(BuildContext context, DateTime day, List<Event> events) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimatedDialog(
          day: day,
          events: events,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment & Health Calendar',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: TableCalendar<Event>(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2040, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                eventLoader: _getEventsForDay,
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(color: Colors.teal, fontSize: 20),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.teal),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Colors.teal),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.teal.shade300,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  markerDecoration: BoxDecoration(), // Remove the dots
                  markersMaxCount: 0, // Ensure no markers (dots) are shown
                  defaultTextStyle: TextStyle(color: Colors.teal),
                  weekendTextStyle: TextStyle(color: Colors.teal.shade700),
                  outsideTextStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            // Additional content or buttons below the calendar can go here
          ],
        ),
      ),
    );
  }
}

class AnimatedDialog extends StatelessWidget {
  final DateTime day;
  final List<Event> events;

  const AnimatedDialog({
    Key? key,
    required this.day,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Events on ${day.toLocal()}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            ...events.map((event) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Shimmer.fromColors(
                baseColor: Colors.teal.shade500,
                highlightColor: Colors.teal.shade500,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.event_note, color: Colors.white),
                          SizedBox(width: 10),
                          Text(event.title),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Doctor Type: ${event.description}',
                        style: TextStyle(
                            color: Colors.teal.shade600, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close',style: TextStyle(color:Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final String description;

  Event(this.title, this.description);
}

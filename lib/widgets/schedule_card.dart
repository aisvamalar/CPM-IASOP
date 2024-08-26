import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScheduleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.all(10),
      width: 290,
      decoration: BoxDecoration(
        color: Colors.teal[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('images/img.png'),
            radius: 30,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Dr. Nirmala',

                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                'Dentist',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(FontAwesomeIcons.envelope, color: Colors.white),
                  SizedBox(width: 10),
                  Icon(FontAwesomeIcons.ellipsisV, color: Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

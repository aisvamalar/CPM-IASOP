import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class DoctorToolCard extends StatelessWidget {
  final String toolName;
  final IconData icon;

  const DoctorToolCard({
    Key? key,
    required this.toolName,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 2),
      interval: Duration(seconds: 2),
      color: Colors.white,
      colorOpacity: 0.3,
      enabled: true,
      direction: ShimmerDirection.fromLTRB(),
      child: Container(
        width: 150, // Set appropriate width for the card
        height: 100, // Set appropriate height for the card
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(
              toolName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

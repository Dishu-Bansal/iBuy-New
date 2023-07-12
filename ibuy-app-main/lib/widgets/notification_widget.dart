import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  final String text;
  final String date;
  const NotificationWidget({super.key, required this.text, required this.date});

  @override
  Widget build(BuildContext context) {
    final dateDifference =
        DateTime.now().difference(DateTime.parse(date)).inDays;
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,

      //box decoration with border radius and shadow
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // notification text and icon with date and time
            Row(
              children: [
                const Icon(Icons.notifications),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // date and time
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 40),
                Text(
                  dateDifference == 0
                      ? "Today"
                      : dateDifference == 1
                          ? "Yesterday"
                          : "$dateDifference days ago",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

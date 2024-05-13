import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/*class ActivityInProgress extends StatelessWidget {
  final String activityName;
  final bool isKilometers;
  final Function onStop;
  final Function onReset;

  ActivityInProgress({
    required this.activityName,
    this.isKilometers = false,
    required this.onStop,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFFFE4C7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(activityName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Spacer(),
            IconButton(
              icon: Icon(CupertinoIcons.check_mark_circled_solid),
              color: Colors.green,
              onPressed: () => onStop(),
            ),
            IconButton(
              icon: Icon(CupertinoIcons.xmark_circle_fill),
              color: Colors.red,
              onPressed: () => onReset(),
            ),
          ],
        ),
      ),
    );
  }
}
*/
class ActivityInProgress extends StatelessWidget {
  final String activityName;
  final bool isKilometers;
  final Function onStop;
  final Function onReset;

  const ActivityInProgress({super.key, 
    required this.activityName,
    this.isKilometers = false,
    required this.onStop,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4C7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(activityName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const Spacer(),
            IconButton(
              icon: const Icon(CupertinoIcons.check_mark_circled_solid),
              color: Colors.green,
              onPressed: () => onStop(),
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.xmark_circle_fill),
              color: Colors.red,
              onPressed: () => onReset(),
            ),
          ],
        ),
      ),
    );
  }
}

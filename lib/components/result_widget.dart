import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  const ResultWidget({super.key, required this.winned, required this.onRestart});

  final bool? winned;
  final Function? onRestart;

  Color _getColor() {
    if (winned == null) {
      return Colors.yellow;
    } else if (winned == true) {
      return Colors.lightGreen;
    } else {
      return Colors.red;
    }
  }

  IconData _getIcon() {
    if (winned == null) {
      return Icons.sentiment_satisfied;
    } else if (winned == true) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () => onRestart!(),
              icon: Icon(_getIcon()),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}

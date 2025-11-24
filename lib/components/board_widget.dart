import 'package:flutter/material.dart';
import 'package:minesweeper/components/field_widget.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/field.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({
    super.key,
    required this.board,
    required this.onOpen,
    required this.onToggleMark,
  });

  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onToggleMark;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((f) {
          return FieldWidget(
            field: f,
            onOpen: onOpen,
            onToggleMark: onToggleMark,
          );
        }).toList(),
      ),
    );
  }
}

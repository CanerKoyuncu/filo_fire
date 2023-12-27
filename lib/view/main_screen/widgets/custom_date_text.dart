import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget customDateText(DateTime dateTime) {
  final result = DateFormat("d.M.y").format(dateTime);
  return Text(result.toString());
}

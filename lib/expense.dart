import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

final categoryname = {
  Category.work: 'Work',
  Category.food: 'Food',
  Category.leisure: 'Leisure',
  Category.travel: 'Travel',
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  String id;
  String title;
  double amount;
  DateTime date;
  Category category;
  String get formatdate {
    return DateFormat('yMd').format(date);
  }
}



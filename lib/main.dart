import 'package:expense_tracker/newdata.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/expense.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterDemo',
      theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true),
      home: const Expenses(),
    );
  }
}

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> registeredExpenses = [];

  void addbottomoverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return (NewData(onAddExpense: addExpense));
      },
    );
  }

  void addExpense(Expense exp) {
    setState(() {
      registeredExpenses.add(exp);
    });
  }

  void removeExpense(Expense exp) {
    setState(() {
      registeredExpenses.remove(exp);
    });
  }

  void popup(Expense exp, int idx) {
    setState(() {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Expenses deleted!!!'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
            onPressed: () {
              setState(() {
                registeredExpenses.insert(idx, exp);
              });
            },
            label: 'undo'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense History',
              style: TextStyle(fontSize: 30, color: Colors.black)),
          backgroundColor: Colors.orange[300],
          actions: [
            IconButton(
                onPressed: addbottomoverlay, icon: const Icon(Icons.add)),
          ],
        ),
        body: registeredExpenses.isEmpty
            ? Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                        radius: 5,
                        center: Alignment.topCenter,
                        colors: [
                          Colors.red,
                          Colors.blue,
                          Colors.redAccent,
                          Colors.deepOrange,
                          Colors.pink,
                          Colors.white
                        ])),
                  child: Center(
                    child: Text(
                    'No Expenses!!',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
              ),
                  ),
                ))
            : Container(
                decoration: BoxDecoration(
                    gradient: RadialGradient(
                        radius: 5,
                        center: Alignment.topCenter,
                        colors: [
                      Colors.red,
                      Colors.blue,
                      Colors.redAccent,
                      Colors.deepOrange,
                      Colors.pink,
                      Colors.white
                    ])),
                child: Column(
                  children: [

                    SizedBox(
                      height: 1,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Dismissible(
                            background: Container(
                              color: Colors.red,
                            ),
                            onDismissed: (direction) {
                              popup(registeredExpenses[index], index);
                              removeExpense(registeredExpenses[index]);
                            },
                            key: ValueKey(registeredExpenses[index]),
                            child: Card(
                                color: Colors.teal,
                                elevation: 20,
                                child: ListTile(
                                  leading: Text(
                                      '\$${registeredExpenses[index].amount.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                  title: Text(registeredExpenses[index].title,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                  subtitle: Text(
                                      categoryname[registeredExpenses[index]
                                              .category]
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                  trailing: Text(
                                      registeredExpenses[index].formatdate,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                )),
                          ),
                        );
                      },
                      itemCount: registeredExpenses.length,
                    ))
                  ],
                ),
              ));
  }
}

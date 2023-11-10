import 'package:flutter/material.dart';
import 'package:expense_tracker/expense.dart';
import 'package:intl/intl.dart';

class NewData extends StatefulWidget {
 const NewData({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewData> createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  var title = TextEditingController();
  var amount = TextEditingController();
  DateTime? selecteddate;
  Category? selectedcategory;

  void datepicker() async {
    final now = DateTime.now();
    final pickeddate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
    );
    setState(() {
      selecteddate = pickeddate;
    });
  }

  void submit() {
    if (title.text.trim().isEmpty ||
        amount.text.trim().isEmpty ||
        selecteddate.toString().trim().isEmpty ||
        selectedcategory.toString().trim().isEmpty) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(title: Text('Enter all detail', style: TextStyle( color: Colors.black)),
        content: Text('Enter valid title , amount , category or date of your expense', style: TextStyle( color: Colors.black)),
        actions: [IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.cancel_outlined,color: Colors.black,))],);
      },);
return;
    }
  else {
      widget.onAddExpense(Expense(
          title: title.text,
          amount: double.parse(amount.text),
          date: selecteddate!,
          category: selectedcategory!));
    }
  Navigator.pop(context);
  }

  @override
  void dispose() {
    title.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              radius: 5,center: Alignment.topCenter,
              colors:[
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
            height: 60,
          ),
          Text('Add New Expense',
              style: TextStyle(fontSize: 30, color: Colors.black)),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(

              maxLength: 50,
              controller: title,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.tealAccent,
                label: Text('Title',
                    style: TextStyle(fontSize: 25, color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 3)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 3)),
              ),
            ),
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 170,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: amount,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.tealAccent,
                      prefixIcon: Icon(Icons.attach_money_outlined),
                      label: Text('Amount',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 3)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 3)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Row(
              children: [
                Text(
                    selecteddate == null
                        ? 'Select date'
                        : '${DateFormat('yMd').format(selecteddate!)}',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                IconButton(
                    onPressed: () {
                      datepicker();
                    },
                    icon: Icon(
                      Icons.date_range_outlined,color: Colors.black,
                      size: 30,
                    ))
              ],
            )
          ]),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),color: Colors.tealAccent
              ),
                child: DropdownButton(dropdownColor: Colors.tealAccent,
                    hint: Text(
                        selectedcategory == null
                            ? 'select category'
                            : categoryname[selectedcategory].toString(),
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    items: Category.values.map((category) {
                      return DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedcategory = value!;
                      });
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.tealAccent),
                  onPressed: () {submit();},
                  child: Text('Add',
                      style: TextStyle(fontSize: 20, color: Colors.black))),
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: Spacer(),
              ),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.tealAccent),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel',
                      style: TextStyle(fontSize: 20, color: Colors.black))),
            ],
          )
        ],
      ),
    );
  }
}

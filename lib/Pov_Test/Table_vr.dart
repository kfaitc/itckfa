import 'package:flutter/material.dart';

class DropdownExample extends StatefulWidget {
  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  String selectedValue = '';
  List<String> items = ['{A}'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,
                  onChanged: (newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      // You can perform any action with the selected value here
                      print('Selected value: $selectedValue');
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'Option 1',
                      child: Text('Option 1'),
                    ),
                    DropdownMenuItem(
                      value: 'Option 2',
                      child: Text('Option 2'),
                    ),
                    DropdownMenuItem(
                      value: 'Option 3',
                      child: Text('Option 3'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Selected Value: $selectedValue'),
          ],
        ),
      ),
    );
  }
}

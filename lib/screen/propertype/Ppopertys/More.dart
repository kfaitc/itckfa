import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "More",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_circle_down_outlined),
                elevation: 16,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
                underline: SizedBox(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Text(
            'Selected Value: ${dropdownValue ?? 'None'}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  List<String> list = <String>[
    'Banteay Meanchey',
    'Siem reap',
    'Phnom penh',
    'Takae'
  ];
}

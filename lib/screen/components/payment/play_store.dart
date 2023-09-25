// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Banking App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeDay(),
//     );
//   }
// }

// class HomeDay extends StatefulWidget {
//   @override
//   State<HomeDay> createState() => _HomeDayState();
// }

// class _HomeDayState extends State<HomeDay> {
//   List<Transaction> transactions = [];

//   @override
//   void initState() {
//     super.initState();
//     CheckTransaction();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final groupedTransactions = groupTransactionsByDate(transactions);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Transaction History'),
//       ),
//       body: ListView.builder(
//         itemCount: groupedTransactions.length,
//         itemBuilder: (context, index) {
//           final date = groupedTransactions.keys.elementAt(index);
//           final transactions = groupedTransactions[date]!;
//           final totalValue = transactions.fold(
//               0.0, (sum, transaction) => sum + transaction.value);

//           return ListTile(
//             title: Text('Date: $date'),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 for (final transaction in transactions)
//                   Text('Value: \$${transaction.value.toStringAsFixed(2)}'),
//                 Text('Total Value: \$${totalValue.toStringAsFixed(2)}'),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<void> CheckTransaction() async {
//     final response = await http.get(Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/User_Tran/54K182F54A'));
//     if (response.statusCode == 200) {
//       setState(() {
//         final jsonData = jsonDecode(response.body) as List<dynamic>;
//         transactions = jsonData
//             .map((item) => Transaction(
//                   date: item['expiry'] ?? '',
//                   value: double.tryParse(item['payAmount'] ?? '0.0') ?? 0.0,
//                 ))
//             .toList();
//       });
//     }
//   }

//   Map<String, List<Transaction>> groupTransactionsByDate(
//       List<Transaction> transactions) {
//     final groupedTransactions = <String, List<Transaction>>{};

//     for (final transaction in transactions) {
//       if (!groupedTransactions.containsKey(transaction.date)) {
//         groupedTransactions[transaction.date] = [];
//       }
//       groupedTransactions[transaction.date]!.add(transaction);
//     }

//     return groupedTransactions;
//   }
// }

// class Transaction {
//   final String date;
//   final double value;

//   Transaction({required this.date, required this.value});
// }

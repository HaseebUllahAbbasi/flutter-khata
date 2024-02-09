import 'package:flutter/material.dart';
import 'package:khata_custom/src/give.dart';
import 'package:khata_custom/src/take.dart';

class TransactionItem extends StatelessWidget {
  final String date;
  final String time;
  final String type;
  final int amount;

  TransactionItem({
    required this.date,
    required this.time,
    required this.type,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Date",
          style: TextStyle(color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white, // Changed to white
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Date",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          ' $time',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100], // Changed to light grey
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Bal: Rs:15,000',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (type == 'give')
                    Text(
                      'Rs $amount',
                      style: TextStyle(color: Colors.green),
                    ),
                  if (type == 'take')
                    Text(
                      'Rs $amount',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  'Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Type',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Amount',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 450,
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return TransactionItem(
                  date: transaction['date'],
                  time: transaction['time'],
                  type: transaction['type'],
                  amount: transaction['amount'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PartyDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> transactions = [
      {"date": "2023-09-25", "time": "09:30 AM", "type": "give", "amount": 100},
      {"date": "2023-09-25", "time": "02:45 PM", "type": "take", "amount": 50},
      {"date": "2023-09-26", "time": "11:15 AM", "type": "give", "amount": 75},
      {"date": "2023-09-26", "time": "11:15 AM", "type": "give", "amount": 75},
      {"date": "2023-09-26", "time": "03:00 PM", "type": "take", "amount": 30},
      {"date": "2023-09-27", "time": "10:00 AM", "type": "give", "amount": 200},
      {"date": "2023-09-26", "time": "03:00 PM", "type": "take", "amount": 30},
      {"date": "2023-09-27", "time": "10:00 AM", "type": "give", "amount": 200},
    ];

    int totalGave = 0;
    int totalGot = 0;
    for (var transaction in transactions) {
      if (transaction['type'] == 'give') {
        totalGave += transaction['amount'] as int;
      } else {
        totalGot += transaction['amount'] as int;
      }
    }

    int overallTotal = totalGot - totalGave;

    return Scaffold(
      appBar: AppBar(
        title: Text('Party Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(45, 85, 255, 0.6),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        width: 2,
                        color: Color.fromRGBO(45, 85, 255, 1),
                      ),
                    ),
                    child: Text(
                      'H',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'Haseeb',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'You Will get',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rs $overallTotal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: overallTotal >= 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.message,
                    size: 30,
                    color: Color.fromRGBO(45, 85, 255, 1),
                  ),
                  Icon(
                    Icons.message,
                    size: 30,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.picture_as_pdf,
                    size: 30,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            TransactionList(transactions: transactions),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TakeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: Text(
                        'You Gave',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GiveScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      child: Text(
                        'You Got',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

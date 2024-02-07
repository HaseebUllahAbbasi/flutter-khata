import 'package:flutter/material.dart';

class GiveScreen extends StatefulWidget {
  @override
  _GiveScreenState createState() => _GiveScreenState();
}

class _GiveScreenState extends State<GiveScreen> {
  String person = "Ahmed";
  String number = "0";
  String desc = "";

  void handleNumberChange(String newNumber) {
    setState(() {
      number = newNumber;
    });
  }

  void handleSubmit() {
    if (double.tryParse(number) != null) {
      print("Submitted number: $number");
    } else {
      print("Invalid number: $number");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Give'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You Gave Rs $number to $person',
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter a number...',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: handleNumberChange,
              controller: TextEditingController(text: number),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Details (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  desc = value;
                });
              },
              controller: TextEditingController(text: desc),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleSubmit,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

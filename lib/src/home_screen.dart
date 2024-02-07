import 'package:flutter/material.dart';
import 'package:khata_custom/src/create_person_entry.dart';
import 'package:khata_custom/src/person_transactions.dart';

class VerticalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 1.5,
      color: Colors.grey[300],
    );
  }
}

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> users = UserList().users;
    int totalGive = 0;
    int totalGet = 0;

    for (var user in users) {
      int amount = user['total'];
      if (amount >= 0) {
        totalGet += amount;
      } else {
        totalGive -= amount;
      }
    }

    int overallTotal = totalGet - totalGive;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatColumn("You will Give", "Rs $totalGive", Colors.green),
          VerticalLine(),
          _buildStatColumn("You will Get", "Rs $totalGet", Colors.red),
          VerticalLine(),
          _buildStatColumn("Overall", "Rs $overallTotal", Colors.red),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String title, String amount, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 5),
        Text(
          amount,
          style: TextStyle(
            fontSize: 20,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class UserList extends StatelessWidget {
  final List<Map<String, dynamic>> users = [
    {"user": "User1", "total": 100, "lastUpdated": "2023-09-24"},
    {"user": "User2", "total": -50, "lastUpdated": "2023-09-23"},
    {"user": "User3", "total": 75, "lastUpdated": "2023-09-22"},
    {"user": "User4", "total": -30, "lastUpdated": "2023-09-21"},
    {"user": "User5", "total": 200, "lastUpdated": "2023-09-20"},
    {"user": "User6", "total": 50, "lastUpdated": "2023-09-19"},
    {"user": "User7", "total": -10, "lastUpdated": "2023-09-18"},
    {"user": "User8", "total": 300, "lastUpdated": "2023-09-17"},
    {"user": "User9", "total": -20, "lastUpdated": "2023-09-16"},
    {"user": "User10", "total": 150, "lastUpdated": "2023-09-15"},
    {"user": "User11", "total": 150, "lastUpdated": "2023-09-15"},
    {"user": "User12", "total": 150, "lastUpdated": "2023-09-15"},
    {"user": "User13", "total": 150, "lastUpdated": "2023-09-15"},
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> user = users[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PartyDetailsScreen()),
                );

                // Navigate to the PartyDetails screen
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(
                    user["user"][0],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(user["user"]),
                subtitle: Text(user["lastUpdated"]),
                trailing: Text(
                  "${user["total"]}",
                  style: TextStyle(
                    color: user["total"] >= 0 ? Colors.green : Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        children: [
          Stats(),
          UserList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePersonEntry()),
          );

          // Navigate to the screen for creating a transaction
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Transaction'),
      ),
      body: Center(
        child: Text('Transaction Screen'),
      ),
    );
  }
}

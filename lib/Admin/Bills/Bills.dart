import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bill {
  final String userName;
  final double amount;
  bool isPaid;

  Bill({required this.userName, required this.amount, this.isPaid = false});
}

class bills_user extends StatefulWidget {
  const bills_user({Key? key}) : super(key: key);

  @override
  _BillsUserState createState() => _BillsUserState();
}

class _BillsUserState extends State<bills_user> {
  List<Bill> bills = [];
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    final savedBills = _prefs?.getStringList('bills');

    if (savedBills != null) {
      bills = savedBills.map((billStr) {
        final billData = billStr.split(';');
        return Bill(
          userName: billData[0],
          amount: double.parse(billData[1]),
          isPaid: billData[2] == 'true',
        );
      }).toList();
    } else {
      bills = [
        Bill(userName: 'Sample User 1', amount: 50.0, isPaid: true),
        Bill(userName: 'Sample User 2', amount: 75.0, isPaid: false),
      ];
    }

    setState(() {});
  }

  Future<void> _saveData() async {
    final billStrings = bills.map((bill) {
      return '${bill.userName};${bill.amount};${bill.isPaid}';
    }).toList();
    await _prefs?.setStringList('bills', billStrings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff453658),
        title: Text(
          'User Bills',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: bills.isEmpty
          ? Center(
              child: Text('No bills yet'),
            )
          : ListView.builder(
              itemCount: bills.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: bills[index].isPaid
                      ? Colors.white
                      : Color.fromARGB(255, 211, 180, 252),
                  child: ListTile(
                    title: Text(bills[index].userName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${bills[index].amount.toStringAsFixed(2)} '),
                        Text(bills[index].isPaid ? 'Paid' : 'Not Paid'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteBill(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 211, 180, 252),
        onPressed: _addNewBill,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Bill'),
          content: Text('Change payment status for ${bills[index].userName}?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Mark as Paid'),
              onPressed: () {
                setState(() {
                  bills[index].isPaid = true;
                });
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Mark as Unpaid'),
              onPressed: () {
                setState(() {
                  bills[index].isPaid = false;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteBill(int index) {
    setState(() {
      bills.removeAt(index);
    });
  }

  void _addNewBill() {
    showDialog(
      context: context,
      builder: (context) {
        String userName = '';
        double amount = 0.0;

        return AlertDialog(
          title: Text('Add New Bill'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  userName = value;
                },
                decoration: InputDecoration(labelText: 'User Name'),
              ),
              TextField(
                onChanged: (value) {
                  amount = double.tryParse(value) ?? 0.0;
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Amount '),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Add Bill'),
              onPressed: () {
                setState(() {
                  bills.add(Bill(userName: userName, amount: amount));
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _saveData(); // Save data before disposing the state
    super.dispose();
  }
}


//herrergghjghjkghjhj
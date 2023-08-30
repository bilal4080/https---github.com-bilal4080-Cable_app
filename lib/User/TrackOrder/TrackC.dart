import 'package:flutter/material.dart';

class Trackk extends StatefulWidget {
  const Trackk({Key? key}) : super(key: key);

  @override
  _TrackkState createState() => _TrackkState();
}

class _TrackkState extends State<Trackk> {
  TextEditingController complaintNumberController = TextEditingController();
  String complaintStatus = '';

  void checkComplaintStatus() {
    // Dummy implementation to assign a complaint status based on the entered complaint number
    String complaintNumber = complaintNumberController.text;
    if (complaintNumber == '123') {
      complaintStatus = 'In Progress';
    } else if (complaintNumber == '456') {
      complaintStatus = 'Resolved';
    } else {
      complaintStatus = 'Invalid Complaint Number';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complaint Status',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff392850),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: complaintNumberController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  hintText: 'Enter complaint number',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                checkComplaintStatus();
                // You can also perform any navigation logic here if needed
              },
              child: Text('Check Status'),
            ),
            SizedBox(height: 16.0),
            complaintStatus.isNotEmpty
                ? ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Complaint Status: $complaintStatus',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff392850),
                      onPrimary: Colors.white,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

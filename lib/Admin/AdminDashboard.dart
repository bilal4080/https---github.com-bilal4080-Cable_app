import 'package:flutter/material.dart';
import 'package:flutter_cable_app/Admin/Bills/Bills.dart';

import 'Help/admin_help.dart';

class Admin_Dashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<Admin_Dashboard> {
  List<Complaint> complaints = [
    Complaint(
      id: 1,
      address: '123 Main Street',
      phoneNumber: '555-1234',
      description: 'Water leakage issue',
    ),
    Complaint(
      id: 2,
      address: '456 Elm Street',
      phoneNumber: '555-5678',
      description: 'Broken streetlight',
    ),
    Complaint(
      id: 3,
      address: '789 Oak Street',
      phoneNumber: '555-9876',
      description: 'Pothole on the road',
    ),
    // Add more complaints here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff453658),
        title: Text(
          'Admin Complaints',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff453658),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => Admin_Dashboard()),
                  );
                }
                // Handle Home option tap
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
                leading: Icon(
                  Icons.verified_user,
                  color: Colors.black,
                ),
                title: Text(
                  'Bills',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const bills_user()),
                  );
                }),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Handle Settings option tap
              },
              //
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.black,
              ),
              title: Text(
                'Help',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Admin_help_Screen()),
                  );
                }
                // Handle Help option tap
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Handle Logout option tap
              },
            ),
          ],
        ),
      ),
      body: complaints.isEmpty
          ? Center(
              child: Text(
                'No complaints yet',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                return ComplaintCard(
                  complaint: complaints[index],
                  onResolved: () {
                    setState(() {
                      complaints.removeAt(index);
                    });
                  },
                  onInProgress: () {
                    setState(() {
                      complaints[index].inProgress = true;
                    });
                  },
                );
              },
            ),
    );
  }
}

class ComplaintCard extends StatelessWidget {
  final Complaint complaint;
  final VoidCallback onResolved;
  final VoidCallback onInProgress;

  const ComplaintCard({
    required this.complaint,
    required this.onResolved,
    required this.onInProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: complaint.inProgress ? Colors.red : Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ID: ${complaint.id}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Address: ${complaint.address}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Divider(color: Colors.grey),
          SizedBox(height: 8),
          Text('Phone Number: ${complaint.phoneNumber}'),
          SizedBox(height: 8),
          Divider(color: Colors.grey),
          SizedBox(height: 8),
          Text('Description: ${complaint.description}'),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.attach_file),
              ElevatedButton(
                onPressed: onInProgress,
                child: Text('In Progress'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: onResolved,
                child: Text('Resolved'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Complaint {
  final int id;
  final String address;
  final String phoneNumber;
  final String description;
  bool inProgress;

  Complaint({
    required this.id,
    required this.address,
    required this.phoneNumber,
    required this.description,
    this.inProgress = false,
  });
}

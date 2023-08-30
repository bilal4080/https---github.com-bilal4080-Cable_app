import 'package:flutter/material.dart';
import 'package:flutter_cable_app/User/Dashboard/Dashboard.dart';
import 'package:url_launcher/url_launcher.dart';

class payment_method extends StatefulWidget {
  const payment_method({Key? key}) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<payment_method> {
  bool _isLoading = false;

  Future<void> _sendPayment() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    const url = 'https://www.hblibank.com.pk/Login';
    if (await canLaunch(url)) {
      await launch(url);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DialPad(),
            SizedBox(height: 16),
            AmountInputField(),
            SizedBox(height: 16),
            BankAccountDisplay(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendPayment,
              child: _isLoading ? CircularProgressIndicator() : Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}

class DialPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Implement your dial pad UI here
      child: Text('Dial Pad'),
    );
  }
}

class AmountInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter amount',
      ),
    );
  }
}

class BankAccountDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Implement your bank account display UI here
      child: Text('Bank Account:11362778929012'),
    );
  }
}

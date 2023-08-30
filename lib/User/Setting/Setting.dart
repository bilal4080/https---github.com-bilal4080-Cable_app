import 'package:flutter/material.dart';
import 'package:flutter_cable_app/User/Services/payment.dart';

class Settings_user extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Settings_user> {
  get color1 => Color(0xff453658);

  get color2 => Color(0xff392850);

  get color3 => Color(0xff453658);

  get textcolor => Colors.white;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: color1,
      body: Stack(
        children: [
          Positioned(
              top: 50,
              left: 30,
              child: Text(
                "Your Recent Bills",
                style: TextStyle(
                  color: textcolor,
                  letterSpacing: 2,
                  fontSize: 30,
                ),
              )),
          Positioned(
            top: 90,
            left: 30,
            child: Text(
              "December 2023",
              style: TextStyle(
                color: textcolor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Positioned(
            top: 155,
            left: 30,
            child: billedContainer(size),
          ),
        ],
      ),
    );
  }

  Widget nearbyFriends(Size size) {
    return Container(
      height: size.height / 3.7,
      width: size.width / 1.15,
      decoration: BoxDecoration(
        color: color3,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 100,
            child: Text(
              "",
              style: TextStyle(
                color: textcolor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recentSplits(Size size, String imageUrl, String name) {
    return Container(
      height: size.height / 10,
      width: size.width / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: size.height / 20,
            width: size.height / 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imageUrl),
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(
              color: color2,
            ),
          )
        ],
      ),
    );
  }

  Widget previousParticipants(Size size, String imageUrl, String name) {
    return Container(
      height: size.height / 10,
      width: size.width / 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color1,
      ),
      child: Column(
        children: [
          Container(
            height: size.height / 14.5,
            width: size.width / 14.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(
              color: color2,
            ),
          )
        ],
      ),
    );
  }

  Widget billedContainer(Size size) {
    return Container(
      height: size.height / 3,
      width: size.width / 1.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color2,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: Text(
              "Total Bill",
              style: TextStyle(
                color: textcolor,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 55,
            left: 30,
            child: Text(
              "750.86",
              style: TextStyle(
                color: textcolor,
                fontSize: 34,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 30,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => payment_method(),
                ),
              ),
              child: Material(
                color: color1,
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: size.height / 12,
                  width: size.width / 3.5,
                  alignment: Alignment.center,
                  child: Text(
                    "Pay Now",
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String logo;
  final String name;
  final String accno;
  final String balance;

  Header({
    required this.logo,
    required this.accno,
    required this.balance,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Image.network(
                      logo,
                      fit: BoxFit.cover,
                      height: 30,
                      width: 30,
                    ),
                    //Bank Name
                    SizedBox(width: 15),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\u{20B9} $balance",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 21,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Savings A/C\t\t",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
              Text(
                "($accno)\t\t",
              ),
              Text(
                "2.5% p.a\t\t",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

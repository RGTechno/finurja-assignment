import 'package:flutter/material.dart';

import '../screens/transaction_screen.dart';

class BankCard extends StatelessWidget {
  final String logo;
  final String name;
  final String accno;
  final String balance;
  final List? transactions;

  BankCard({
    required this.logo,
    required this.name,
    required this.accno,
    required this.balance,
    this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  //TODO:image of bank
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
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Savings A/C",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        accno,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Your Balance",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "\u{20B9} $balance",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => TransactionScreen(),
                        settings: RouteSettings(
                          arguments: {
                            "name": name,
                            "logo": logo,
                            "accNo": accno,
                            "balance": balance,
                            "transactions": transactions
                          },
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "View Transactions",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 2),
      ],
    );
  }
}

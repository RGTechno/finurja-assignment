import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  final String title;
  final String amount;
  final String type;

  TransactionWidget({
    required this.title,
    required this.amount,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black54,
            ),
          ),
          Wrap(
            children: [
              Text(
                "\u{20B9} ${amount}",
                style: TextStyle(
                  color: type == "credit" ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              type == "credit"
                  ? Transform.rotate(
                      angle: 2,
                      child: Icon(
                        Icons.arrow_right_alt_rounded,
                        color: Colors.green,
                        size: 20,
                      ),
                    )
                  : Transform.rotate(
                      angle: -1.1,
                      child: Icon(
                        Icons.arrow_right_alt_rounded,
                        color: Colors.red,
                        size: 20,
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}

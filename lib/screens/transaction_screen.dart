import 'package:finurja_assign/widgets/transaction_header.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    print(data);
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              logo: data["logo"],
              accno: data["accNo"],
              balance: data["balance"],
              name: data["name"],
            ),
            Divider(thickness: 3),
          ],
        ),
      ),
    );
  }
}

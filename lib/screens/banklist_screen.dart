import 'dart:convert';

import 'package:finurja_assign/widgets/bank_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BankListScreen extends StatefulWidget {
  const BankListScreen({Key? key}) : super(key: key);

  @override
  State<BankListScreen> createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> {
  List _banks = [];

  Future<void> fetchData() async {
    final String res = await rootBundle.loadString('assets/dummy_data.json');
    final bankdata = await jsonDecode(res);

    setState(() {
      _banks = bankdata["banks"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Bank Accounts"),
        centerTitle: true,
        toolbarHeight: 75,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: _banks.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return BankCard(
                  name: _banks[index]["name"],
                  logo: _banks[index]["logo"],
                  accno: _banks[index]["accNo"],
                  balance: _banks[index]["balance"],
                  transactions: _banks[index]["transactions"],
                );
              },
              itemCount: _banks.length,
            ),
    );
  }
}

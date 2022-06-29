import 'package:finurja_assign/widgets/transaction_header.dart';
import 'package:flutter/material.dart';

enum Order { latest, oldest }

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late List<dynamic> _trans;

  Order? _order = Order.latest;

  @override
  Widget build(BuildContext context) {
    // print("latest $_order");
    final data =
    ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<String, dynamic>;
    // print(data);
    setState(() {
      _trans = data["transactions"];
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Header(
                logo: data["logo"],
                accno: data["accNo"],
                balance: data["balance"],
                name: data["name"],
              ),
              const Divider(thickness: 3),
              SizedBox(height: 10),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Text(
                          "Last 10 Transactions",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        // TODO: filters
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        filter(context);
                      },
                      icon: Icon(
                        Icons.filter_alt_rounded,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, height: 30),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, idx) {
                  return Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _trans[idx]["date"],
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 8,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, i) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _trans[idx]["dayTransactions"][i]
                                      ["title"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          "\u{20B9} ${_trans[idx]["dayTransactions"][i]["amount"]}",
                                          style: TextStyle(
                                            color: _trans[idx]
                                            ["dayTransactions"]
                                            [i]["type"] ==
                                                "credit"
                                                ? Colors.red
                                                : Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        _trans[idx]["dayTransactions"][i]
                                        ["type"] ==
                                            "credit"
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
                            },
                            itemCount: _trans[idx]["dayTransactions"].length,
                          ),
                        ),
                        Divider(thickness: 1)
                      ],
                    ),
                  );
                },
                itemCount: _trans.length,
              )
            ],
          ),
        ),
      ),
    );
  }

  void filter(BuildContext ctx) {
    showModalBottomSheet<void>(
      context: ctx,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 600,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.cancel_rounded),
                      ),
                    ),
                    Text(
                      "Sort & Filter",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    Divider(thickness: 1),
                    SizedBox(height: 15),
                    Text(
                      "Sort by time",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 17,
                      ),
                    ),
                    RadioListTile<Order>(
                      title: const Text('Latest to Oldest'),
                      value: Order.latest,
                      groupValue: _order,
                      onChanged: (Order? value) {
                        setState(() {
                          _order = value;
                        });
                      },
                    ),
                    RadioListTile<Order>(
                      title: const Text('Oldest to Latest'),
                      value: Order.oldest,
                      groupValue: _order,
                      onChanged: (Order? value) {
                        setState(() {
                          _order = value;
                        });
                      },
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}

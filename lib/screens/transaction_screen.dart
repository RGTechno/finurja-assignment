import 'package:finurja_assign/widgets/transaction_header.dart';
import 'package:flutter/material.dart';

import '../widgets/transaction_widget.dart';

enum Order { latest, oldest }

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late List<dynamic> _trans, show;

  Order? _order = Order.latest;

  bool credit = true, debit = true, range = false, first = true;

  RangeValues _currentRangeValues = const RangeValues(1000, 30000);

  @override
  Widget build(BuildContext context) {
    // print("latest $_order");
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // print(data);
    setState(() {
      _trans = data["transactions"];
      first ? show = [..._trans] : null;
      first = false;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        centerTitle: true,
        backgroundColor: Color(0xff213b8e),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined),
          ),
        ],
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Last 10 Transactions",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
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
                    // TODO: filters
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          // alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _order == Order.latest
                                    ? "Latest to Oldest"
                                    : "Oldest to Latest",
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _order = _order == Order.latest
                                        ? Order.oldest
                                        : Order.latest;

                                    _order == Order.oldest
                                        ? show.sort((a, b) =>
                                            a["date"].compareTo(b["date"]))
                                        : show.sort((a, b) =>
                                            b["date"].compareTo(a["date"]));
                                  });
                                },
                                icon: Icon(
                                  Icons.swap_vert,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
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
                          show[idx]["date"],
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
                              if (credit && !debit && !range) {
                                return show[idx]["dayTransactions"][i]
                                            ["type"] !=
                                        "credit"
                                    ? Container()
                                    : TransactionWidget(
                                        title: show[idx]["dayTransactions"][i]
                                            ["title"],
                                        amount: show[idx]["dayTransactions"][i]
                                            ["amount"],
                                        type: show[idx]["dayTransactions"][i]
                                            ["type"],
                                      );
                              } else if (credit && !debit && range) {
                                // credit with range
                                if (show[idx]["dayTransactions"][i]["type"] !=
                                        "credit" ||
                                    (double.parse(show[idx]["dayTransactions"]
                                                [i]["amount"]) <
                                            _currentRangeValues.start ||
                                        double.parse(show[idx]
                                                    ["dayTransactions"][i]
                                                ["amount"]) >
                                            _currentRangeValues.end)) {
                                  return Container();
                                }
                                return TransactionWidget(
                                  title: show[idx]["dayTransactions"][i]
                                      ["title"],
                                  amount: show[idx]["dayTransactions"][i]
                                      ["amount"],
                                  type: show[idx]["dayTransactions"][i]["type"],
                                );
                              } else if (!credit && debit && !range) {
                                // all debit
                                return show[idx]["dayTransactions"][i]
                                            ["type"] !=
                                        "debit"
                                    ? Container()
                                    : TransactionWidget(
                                        title: show[idx]["dayTransactions"][i]
                                            ["title"],
                                        amount: show[idx]["dayTransactions"][i]
                                            ["amount"],
                                        type: show[idx]["dayTransactions"][i]
                                            ["type"],
                                      );
                              } else if (!credit && debit && range) {
                                // debit in range
                                if (show[idx]["dayTransactions"][i]["type"] !=
                                        "debit" ||
                                    (double.parse(show[idx]["dayTransactions"]
                                                [i]["amount"]) <
                                            _currentRangeValues.start ||
                                        double.parse(show[idx]
                                                    ["dayTransactions"][i]
                                                ["amount"]) >
                                            _currentRangeValues.end)) {
                                  return Container();
                                }
                                return TransactionWidget(
                                  title: show[idx]["dayTransactions"][i]
                                      ["title"],
                                  amount: show[idx]["dayTransactions"][i]
                                      ["amount"],
                                  type: show[idx]["dayTransactions"][i]["type"],
                                );
                              } else if (credit && debit && range) {
                                // credit and debit in range
                                if ((double.parse(show[idx]["dayTransactions"]
                                            [i]["amount"]) <
                                        _currentRangeValues.start ||
                                    double.parse(show[idx]["dayTransactions"][i]
                                            ["amount"]) >
                                        _currentRangeValues.end)) {
                                  return Container();
                                }
                                return TransactionWidget(
                                  title: show[idx]["dayTransactions"][i]
                                      ["title"],
                                  amount: show[idx]["dayTransactions"][i]
                                      ["amount"],
                                  type: show[idx]["dayTransactions"][i]["type"],
                                );
                              }
                              return TransactionWidget(
                                title: show[idx]["dayTransactions"][i]["title"],
                                amount: show[idx]["dayTransactions"][i]
                                    ["amount"],
                                type: show[idx]["dayTransactions"][i]["type"],
                              );
                            },
                            itemCount: show[idx]["dayTransactions"].length,
                          ),
                        ),
                        Divider(thickness: 1)
                      ],
                    ),
                  );
                },
                itemCount: show.length,
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
            builder: (BuildContext context, StateSetter sst) {
          return Container(
            height: MediaQuery.of(context).size.height * 1,
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: SingleChildScrollView(
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
                    activeColor: Color(0xff213b8e),
                    onChanged: (Order? value) {
                      sst(() {
                        _order = value;
                      });
                    },
                  ),
                  RadioListTile<Order>(
                    title: const Text('Oldest to Latest'),
                    value: Order.oldest,
                    groupValue: _order,
                    activeColor: Color(0xff213b8e),
                    onChanged: (Order? value) {
                      sst(() {
                        _order = value;
                      });
                    },
                  ),
                  Text(
                    "Filter by",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: credit,
                        activeColor: Color(0xff213b8e),
                        onChanged: (bool? value) {
                          sst(() {
                            credit = value!;
                          });
                        },
                      ),
                      Text("Credit"),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: debit,
                        activeColor: Color(0xff213b8e),
                        onChanged: (bool? value) {
                          sst(() {
                            debit = value!;
                          });
                        },
                      ),
                      Text("Debit"),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: range,
                        activeColor: Color(0xff213b8e),
                        onChanged: (bool? value) {
                          sst(() {
                            range = value!;
                          });
                        },
                      ),
                      Text("Select Range"),
                    ],
                  ),
                  range
                      ? RangeSlider(
                          values: _currentRangeValues,
                          max: 100000,
                          divisions: 10000,
                          min: 0,
                          activeColor: Color(0xff213b8e),
                          labels: RangeLabels(
                            _currentRangeValues.start.round().toString(),
                            _currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            sst(() {
                              _currentRangeValues = values;
                            });
                          },
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 2,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              _order = Order.latest;
                              credit = true;
                              debit = true;
                              range = false;
                            });
                          },
                          child: Text(
                            "RESET",
                            style: TextStyle(
                              color: Color(0xff213b8e),
                            ),
                          ),
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: Color(0xff213b8e),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 40),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // List tmp = [..._trans];
                            setState(() {
                              _order == Order.oldest
                                  ? show.sort(
                                      (a, b) => a["date"].compareTo(b["date"]))
                                  : show.sort(
                                      (a, b) => b["date"].compareTo(b["date"]));
                            });
                          },
                          child: Text(
                            "APPLY",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 40),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff213b8e),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

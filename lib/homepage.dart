import 'package:flutter/material.dart';


// Page d'accueuil
class HomePage extends StatelessWidget {
  final List transactions = [
    {
      'date': '05-01-2025',
      'montant': 1100000,
      'debit': true,
    },
    {
      'date': '05-01-2025',
      'montant': 200000,
      'debit': false,
    },
    {
      'date': '06-01-2025',
      'montant': 50000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '06-01-2025',
      'montant': 50000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
    {
      'date': '07-01-2025',
      'montant': 20000,
      'debit': false,
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Mon compte"),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Compte principale
            Container(
              color: Colors.blue,
              child: Text("Compte total"),
            ),

            // Liste des transactions
            Column(
              children: transactions.map(
                (tr){
                  return Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [BoxShadow(
                              color: Colors.black12,
                              offset: Offset(2, 2),
                              blurRadius: 5,
                            )],
                          ),

                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(tr['date']),
                                Text(tr['montant'].toString()),
                              ],
                          )

                        );
                }
              ).toList()
              ),
          ],
        ),
      ),

    );
  }

}


class MyHomePage extends StatefulWidget {

  final String title = "Home";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

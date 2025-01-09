import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'trans_row.dart';
import 'package:intl/intl.dart';

final List transactions = [
  // {
  //   'date': '05-01-2025',
  //   'montant': 1100000,
  //   'debit': false,
  // },
  // {
  //   'date': '05-01-2025',
  //   'montant': 200000,
  //   'debit': true,
  // },
  // {
  //   'date': '06-01-2025',
  //   'montant': 50000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // },
  // {
  //   'date': '07-01-2025',
  //   'montant': 20000,
  //   'debit': true,
  // }

];
num cash = 0;
var formater = NumberFormat("#,###",'fr_FR');

// Page d'accueuil
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeContent();
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  TextEditingController controller = TextEditingController();
  final box = Hive.box('mon_compte');
  String compte = "";



  @override
  void initState() {
    super.initState();
    compte = box.get('name') ? box.get('name') : "Your Name Here" ;
    cash = transactions.fold(0, (prev, element) {
      return element['debit'] ? prev - element['montant'] : prev + element['montant'];
    });
  }

  operationDialog(BuildContext context, bool retrait){
    String title = retrait ? "Retrait": "Dépot";
    controller.text = "";

    showDialog(context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: TextField(
            keyboardType: TextInputType.number,
            controller: controller,
            decoration: InputDecoration(hintText: "Entrer le montant en Ar"),
          ),
          actions: [
            TextButton(onPressed: () {
              if(controller.text.isEmpty || num.parse(controller.text) > cash){
                return;
              }
              num value = num.parse(controller.text) ;
              String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
              setState(
                      (){
                    transactions.add({'date': date, 'montant': value, 'debit': retrait});
                    cash = retrait ? cash - value: cash + value;
                  }
              );
              controller.text = "";
              Navigator.pop(context);

            }, child: Text("Valider"))
          ],
        )
    );
  }

  rename(context){
    controller.text = compte;
    // Afficher un dialog pour saisir le nom
    showDialog(context: context,
        builder: (context) => AlertDialog(
          title: Text("Renommer le compte"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: "Entrer le nouveau nom"),
          ),
          actions: [
            TextButton(onPressed: () {
              if(controller.text.isEmpty){
                return;
              }
              setState(
                  (){
                    compte = controller.text;
                  }
              );
              controller.text = "";
              Navigator.pop(context);

            }, child: Text("Valider"))
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          backgroundColor: Colors.indigo,
          title: Text("Mon compte"),
        ),
        body: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Compte principale
              Container(
                  width: double.infinity,
                  height: 100,
                  padding:const EdgeInsets.all(15),
                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      const Icon(Icons.paid),
                      Positioned(
                        left: 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(compte,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Text("${formater.format(cash)} Ar",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),

                          ],
                        ),),

                      Positioned(
                        right: 10,
                        child: IconButton(
                            onPressed: (){rename(context);} ,
                            icon: Icon(Icons.edit)),
                      ),
                    ],
                  )
              ),

              const Text("Mes dernières opérations"),

              // Liste des transactions
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      var tr = transactions[index];
                      return TransRow(tr);
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.fromLTRB(35, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            mainAxisSize: MainAxisSize.max,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.indigoAccent,
                focusColor: Colors.blue,
                child: Icon(Icons.add, color: Colors.white,),
                onPressed: () {
                  operationDialog(context, false);
                },
              ),
              SizedBox(width: 10),
              FloatingActionButton(
                backgroundColor: Colors.pink,
                focusColor: Colors.red,
                child: Icon(Icons.remove, color: Colors.white,),
                onPressed: () {
                  setState(() {
                    operationDialog(context, true);
                  });
                },
              ),
            ],
          ),
        )
    );
  }
}



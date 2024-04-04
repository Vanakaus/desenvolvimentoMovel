import 'package:flutter/material.dart';


class MyUsersPage extends StatefulWidget {
  const MyUsersPage({super.key, required this.title});

  final String title;

  @override
  State<MyUsersPage> createState() => _MyHomeUserState();
}

class _MyHomeUserState extends State<MyUsersPage> {

   List<Map<String, String>> users = [
    {"RA": "2012345", "name": "João", "email": "joao@example.com"},
    {"RA": "2098765", "name": "Maria", "email": "maria@example.com"},
    {"RA": "1912345", "name": "Pedro", "email": "pedro@example.com"},
  ];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        child: Container(
          padding: const EdgeInsets.all(30.0),
          width: 800,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child: DataTable(
            headingTextStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Inter',
            ),
            columns: users.first.keys
                .map((key) => DataColumn(label: Text(key.toUpperCase())))
                .toList(),
            rows: users
                .map((item) => DataRow(
                      cells: item.keys
                          .map((key) => DataCell(Text(item[key].toString())))
                          .toList(),
                    ))
                .toList(),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/newUser");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

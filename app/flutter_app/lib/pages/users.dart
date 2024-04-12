import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyUsersPage extends StatefulWidget {
  const MyUsersPage({super.key, required this.title});

  final String title;

  @override
  State<MyUsersPage> createState() => _MyHomeUserState();
}

class _MyHomeUserState extends State<MyUsersPage> {

// Lista de usuários fictícia
   List<Map<String, String>> users = [
    {"RA": "2012345", "name": "João", "email": "joao@example.com"},
    {"RA": "2098765", "name": "Maria", "email": "maria@example.com"},
    {"RA": "1912345", "name": "Pedro", "email": "pedro@example.com"},
  ];


// Build da página
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



      // Botão de regarregar a lista de usuários
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            getUsers();
          // Navigator.of(context).pushNamed("/newUser");
        },
        tooltip: 'Reload',
        child: const Icon(Icons.refresh),
      ),
    );
  }


  // Função para quando a página for carregada
  @override
  void initState() {
    super.initState();
    getUsers();
  }


  // Função para pegar os usuários da API
  Future<void> getUsers() async {
    final response = await http.get(Uri.parse('http://localhost:3000/users/lista'));

    users = [];
    json.decode(response.body).forEach((element) {
      users.add({
        "RA": element["id"].toString(),
        "name": element["name"],
        "email": element["email"]
      });
    });

    setState(() {
      users;
    });
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/layout/index.dart';
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
    {"RA": "", "nome": "", "email": ""},
  ];


    final _formKey = GlobalKey<FormState>();


  // Build da página
  @override
  Widget build(BuildContext context) {

    return CommonLayout(
      pageTitle: widget.title,
      context: context,
      body: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            width: 800,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white
            ),
            child: Column(
              children: [
                const Text(
                  "Lista de Usuários",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                ),
                 DataTable(
              headingTextStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Inter',
              ),
              columns: [
                ...users.first.keys
                .map((key) => DataColumn(label: Text(key.toUpperCase()))),
                const DataColumn(label: Text('Ações'))
              ],
                rows: users.map((item) => DataRow(
                cells: [
                  ...item.keys
                  .map((key) => DataCell(Text(item[key].toString())))
                  ,
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            print('Enviar atividade ${item["RA"]}');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            print('Editar usuário ${item["RA"]}');
                            _showAddUserDialog(context, item["RA"]!, item["email"]!);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            excluirUser(item["RA"]!);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )).toList(),
            ),]
            )
          ),
        ),

          
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/newUser');
          },
          tooltip: 'Adicionar Aluno',
          child: const Icon(Icons.add),
        ),
      )
    );
  }


  // Função para quando a página for carregada
  @override
  void initState() {
    super.initState();
    getUsers();
  }


// Função para abrir o pop-up
  void _showAddUserDialog(BuildContext context, String id, String email) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    emailController.text = email;


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Usuário'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Escreva seu email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Cria uma senha';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirme sua senha';
                    }
                    if (value != passwordController.text) {
                      return 'As senhas não são iguais';
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      editarUser(id,
                                emailController.text,
                                passwordController.text,
                                confirmPasswordController.text);
                      // Fechar o pop-up
                      Navigator.of(context).pop();
                  }},
                  child: const Text('Atualizar'),
                ),
              ],
            )
          )
        );
      },
    );
  }



  // Função para pegar os usuários da API
  Future<void> getUsers() async {
    final response = await http.get(Uri.parse('http://localhost:3000/users/lista'));

    users = [];
    json.decode(response.body).forEach((element) {
      users.add({
        "RA": element["id"].toString(),
        "nome": element["name"],
        "email": element["email"]
      });
    });

    setState(() {
      users;
    });
  }


  // Função para editar um usuário
  Future<void> editarUser(String item, String email, String password, String confirmPassword) async {
    print('Editar usuário $item');
    
    // Imprimir os valores no console
    print('E-mail: $email');
    print('Senha: $password');
    print('Confirmar Senha: $confirmPassword');

    final id = int.parse(item);

    // Enviar requisição para a API com json
    final response = await http.patch(Uri.parse('http://localhost:3000/users/atualiza'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // converter o item para int
    body: json.encode({
      "id": id,
      "email": email,
      "senha": password
    }));

    // Criar a mensagem de retorno
    var mensagem = '';

    if (response.statusCode == 400) {
      mensagem = 'Erro Interno';
    } else {
      mensagem = 'Usuário atualizado com sucesso';
    }

    // Mostrar mensagem de retorno como um alerta
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 4),
      ),
    );

    // Atualizar a lista de usuários
    getUsers();
  }

  

  // Função para excluir um usuário
  Future<void> excluirUser(String item) async {
    print('Editar usuário $item');

    final id = int.parse(item);

    // Enviar requisição para a API com json
    final response = await http.delete(Uri.parse('http://localhost:3000/users/deleta'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // converter o item para int
    body: json.encode({
      "id": id
    }));

    // Criar a mensagem de retorno
    var mensagem = '';

    if (response.statusCode == 400) {
      mensagem = 'Erro Interno';
    } else {
      mensagem = 'Usuário excluído com sucesso';
    }

    // Mostrar mensagem de retorno como um alerta
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 4),
      ),
    );

    // Atualizar a lista de usuários
    getUsers();
  }
}
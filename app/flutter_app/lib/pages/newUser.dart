import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/layout/index.dart';
import 'package:http/http.dart' as http;



class newUserPage extends StatefulWidget {
  const newUserPage({super.key, required this.title});

  final String title;

  @override
  State<newUserPage> createState() => _newUserPageState();
}


class _newUserPageState extends State<newUserPage> {


  @override
  Widget build(BuildContext context) {


    final _formKey = GlobalKey<FormState>();
    late String _name;
    late String _email;
    late String _password;
    late String _confirmPassword;


    return CommonLayout(
      pageTitle: widget.title,
      context: context,
      body: Scaffold(
        body: Center(

          child: Container(
            padding: const EdgeInsets.all(30.0),
            width: 700,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white
            ),

            
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Novo Usuário",
                      style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold)
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Escreva seu nome';
                        }
                        return null;
                      },
                      onSaved: (value) => _name = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Escra seu email';
                        }
                        // Add more complex validation for email if needed
                        return null;
                      },
                      onSaved: (value) => _email = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Senha'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Cria uma senha';
                        }
                        _password = value;
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Confirme sua senha'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirme sua senha';
                        }
                        if (value != _password) {
                          return 'As senhas não são iguais';
                        }
                        return null;
                      },
                      onSaved: (value) => _confirmPassword = value!,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          createNewUser(_name, _email, _password, _confirmPassword);
                        }
                      },
                      child: const Text('Cadastrar'),
                    ),
                  ],
                ),
              ),
          ),



        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/users");
          },
          tooltip: 'Usuarios',
          child: const Icon(Icons.group),
        ),
      ),
    );
  }
  
  Future<void> createNewUser(String name, String email, String password, String confirmPassword) async {
    
    // Verifica se as senhas são iguais
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não são iguais'),
        ),
      );
      return;
    }

    // Enviar requisição para a API
    final response = await http.post(Uri.parse('http://localhost:3000/users/cria'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // converter o item para int
    body: json.encode({
      'name': name,
      'email': email,
      'senha': password
    }));

    // Criar a mensagem de retorno
    var mensagem = '';

    if (response.statusCode == 400) {
      mensagem = 'Erro Interno';
    } else {
      mensagem = 'Usuário cadastrado com sucesso';
    }

    // Mostrar mensagem de retorno como um alerta
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}

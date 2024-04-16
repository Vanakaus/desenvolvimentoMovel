import 'package:flutter/material.dart';
import 'package:flutter_app/layout/index.dart';



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
                          // Aqui você pode adicionar o novo usuário à lista ou realizar outras ações
                          // por enquanto, vamos apenas imprimir os dados no console do navegador
                          print('Nome: $_name');
                          print('Email: $_email');
                          print('Senha: $_password');
                          print('Confirmação de senha: $_confirmPassword');
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
}

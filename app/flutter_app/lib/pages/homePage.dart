import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/layout/index.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    final formKeyActivity = GlobalKey<FormState>();
    late String email;
    late String senha;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Pagina Inicial",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          )
        ),
        centerTitle: true,
        automaticallyImplyLeading: false
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              padding: const EdgeInsets.all(30.0),
              width: 600,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                child: Form(
                  key: formKeyActivity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Text(
                          "Login",
                          style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold)
                        ),

                        const Text(
                          'Realize o login para continuar',
                          style: TextStyle(fontSize: 18),
                        ),

                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Escreva seu Email';
                            }
                            return null;
                          },
                          onSaved: (value) => email = value!,
                        ),
  
                  
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Senha'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Escreva sua senha';
                            }
                            return null;
                          },
                          onSaved: (value) => senha = value!,
                        ),
                  
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (formKeyActivity.currentState!.validate()) {
                              formKeyActivity.currentState!.save();

                              loginHandler(email, senha);

                              print("asdasdasdasdasda");
                            }
                          },
                          child: const Text('Logar'),
                        ),
                    ],
                  ),
                ),
            ),
          ],
        ),
      )
    );
  }
  

  Future<void> loginHandler(String email, String senha) async {

    // Enviar requisição para a API
    final response = await http.post(Uri.parse('http://localhost:3000/users/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // converter o item para int
    body: json.encode({
      'email': email,
      'senha': senha
    }));

    // Criar a mensagem de retorno
    var mensagem = '';

    if (response.statusCode == 400) {
      mensagem = 'Erro Interno';
    } else {
      
      WidgetsFlutterBinding.ensureInitialized();
      await initLocalStorage();

      Map<String, dynamic> userData = json.decode(response.body);
      var user = userData["name"];


      localStorage.setItem('id', userData["id"].toString());
      localStorage.setItem('name', userData["name"]);


      mensagem = 'Login realizado com sucesso! \nBem-Vindo $user';
      Navigator.of(context).pushNamed("/users");      
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
import 'package:flutter/material.dart';


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


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        child: Container(
          padding: const EdgeInsets.all(30.0),
          width: 600,
          height: 400,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),

        child:
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Add more complex validation for email if needed
                      return null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      _password = value;
                      return null;
                    },
                    onSaved: (value) => _password = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _password) {
                        return 'Passwords do not match';
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
                        print('Name: $_name');
                        print('Email: $_email');
                        print('Password: $_password');
                        print('Confirm Password: $_confirmPassword');
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
        ),



      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/newActivity");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

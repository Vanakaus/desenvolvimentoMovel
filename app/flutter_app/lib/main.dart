import 'package:flutter/material.dart';
import 'package:flutter_app/pages/activities.dart';
import 'package:flutter_app/pages/homePage.dart';
import 'package:flutter_app/pages/newActivity.dart';
import 'package:flutter_app/pages/newUser.dart';
import 'package:flutter_app/pages/users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Page',
      initialRoute: '/homePage',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.grey,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
      routes: {
        '/homePage': (context) => const MyHomePage(title: 'Home Page'),
        '/users': (context) => const MyUsersPage(title: 'Usuários'),
        '/newUser': (context) => const newUserPage(title: 'Novo Usuário'),
        '/activities': (context) => const MyActivitiesPage(title: 'Atividades'),
        '/newActivity': (context) => const newActivityPage(title: 'Nova Atividade'),
      },
    );
  }
}
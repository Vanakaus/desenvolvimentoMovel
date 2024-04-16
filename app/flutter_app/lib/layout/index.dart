import 'package:flutter/material.dart';



class CommonLayout extends StatelessWidget {

  final String pageTitle;
  final BuildContext context;
  final Scaffold body;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  
  int currentIndex = 0;


  CommonLayout({
    super.key,
    required this.pageTitle,
    required this.context,
    required this.body,
    this.currentIndex = 0
  });

  

// Lista de páginas
  final List<Map<String, String>> pages = [
    // Paginas de aluos
    {'index': '0', 'route': '/users'},
    {'index': '0', 'route': '/newUser'},

    // Paginas de atividades
    // {'index': '1', 'route': '/activitys'},
    {'index': '1', 'route': '/newActivity'},
  ];


// Lista de navegacao
  final List<Map<String, String>> urls = [
    {'title': 'Alunos', 'route': '/users'},
    {'title': 'Atividades', 'route': '/newActivity'},
  ];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          pageTitle,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          )
        ),
        centerTitle: true,
        automaticallyImplyLeading: false
      ),
      body: body,

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Alunos',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_add),
          //   label: 'Novo Aluno',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Atividades',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.assignment_turned_in),
          //   label: 'Nova Atividade',
          // ),
        ],
        selectedItemColor: pages.indexWhere((element) => element['route'] == ModalRoute.of(context)!.settings.name) == -1 ?
                            Theme.of(context).colorScheme.secondary :
                            Theme.of(context).colorScheme.primary,

        unselectedItemColor: Theme.of(context).colorScheme.secondary,

        currentIndex: pages.indexWhere((element) => element['route'] == ModalRoute.of(context)!.settings.name) == -1 ?
                        0 :
                        int.parse(pages[pages.indexWhere((element) => element['route'] == ModalRoute.of(context)!.settings.name)]['index']!),
        onTap: _onItemTapped,

      ),
    );
  }

  

  // Função para navegar entre as páginas
  void _onItemTapped(int newIndex) {

    var currentIndex = pages.indexWhere((element) => element['route'] == ModalRoute.of(context)!.settings.name);
    if (currentIndex== -1 || int.parse(pages[currentIndex]['index']!) != newIndex) {
      Navigator.of(context).pushNamed(urls[newIndex]['route']!);
    }
  }
}
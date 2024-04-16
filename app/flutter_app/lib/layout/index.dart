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
    {'title': 'Alunos', 'route': '/users'},
    {'title': 'Novo Aluno', 'route': '/newUser'},
    {'title': 'Atividades', 'route': '/newActivity'},
    {'title': 'Nova Atividade', 'route': '/newActivity'},
  ];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(pageTitle),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Novo Aluno',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Atividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Nova Atividade',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: pages.indexWhere((element) => element['route'] == ModalRoute.of(context)!.settings.name) == -1 ?
                        0
                        : 
                        pages.indexWhere((element) => element['route'] == ModalRoute.of(context)!.settings.name),
        onTap: _onItemTapped,
      ),
    );
  }

  

  // Função para navegar entre as páginas
  void _onItemTapped(int index) {
    // Verifica se o índice da página atual é diferente do índice da página selecionada
    if (pages[index]['route'] != ModalRoute.of(context)!.settings.name) {
      Navigator.of(context).pushNamed(pages[index]['route']!);
    }
  }
}
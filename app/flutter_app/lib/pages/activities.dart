import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/layout/index.dart';
import 'package:http/http.dart' as http;


class MyActivitiesPage extends StatefulWidget {
  const MyActivitiesPage({super.key, required this.title});

  final String title;

  @override
  State<MyActivitiesPage> createState() => _MyHomeAtividadesState();
}

class _MyHomeAtividadesState extends State<MyActivitiesPage> {
  
  // Lista de usuários fictícia
  List<Map<String, String>> atividades = [
    {"id": "", "Titulo": "", "descricao": "", "data de entrega": ""},
  ];

  // Lista de atividades nao enviadas
  List<Map<String, String>> atividadesNaoEntregues = [
    {"id": "", "titulo": ""}
  ];
  String _selectedValue = '';

  // Lista de atividades nao enviadas
  List<Map<String, String>> atividadesEntregues = [
    {"id": "", "Aluno": "", "email": "", "dataEntrega": "", "nota": ""}
  ];



  final _formKey = GlobalKey<FormState>();
  late DateTime dataEntrega = DateTime.now().add(const Duration(days: 7));


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
                  "Lista de Atividades",
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
                ...atividades.first.keys
                .map((key) => DataColumn(label: Text(key.toUpperCase()))),
                const DataColumn(label: Text('Ações'))
              ],
                rows: atividades.map((item) => DataRow(
                cells: [
                  ...item.keys
                  .map((key) => DataCell(Text(item[key].toString())))
                  ,
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.list_alt),
                          tooltip: 'Atividaddes entregues',
                          onPressed: () {
                            getAtividadesEntregues(context, item["id"]!);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'Editar Usuário',
                          onPressed: () {
                            _showEditAtividadeDialog(context, item["id"]!, item["titulo"]!, item["descricao"]!, DateTime.parse(item["data de entrega"]!));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Excluir Atividade',
                          onPressed: () {
                            excluirAtividade(item["id"]!);
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
            Navigator.of(context).pushNamed('/newActivity');
          },
          tooltip: 'Nova Atividade',
          child: const Icon(Icons.add),
        ),
      )
    );
  }


  // Função para quando a página for carregada
  @override
  void initState() {
    super.initState();
    getAtividades();
  }


// Função para abrir o pop-up de atualização de usuário
  void _showEditAtividadeDialog(BuildContext context, String id, String titulo, String descricao, DateTime data) {
    final TextEditingController tituloController = TextEditingController();
    final TextEditingController descricaoController = TextEditingController();
        TextEditingController();

    tituloController.text = titulo;
    descricaoController.text = descricao;
    dataEntrega = data;


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Atividade'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: tituloController,
                  decoration: const InputDecoration(labelText: 'Titulo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Escreva um titulo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descricaoController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Escreva uma descrição';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                    children: [
                      const Text('Data de Entrega:'),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () => selectDate(context),
                        child: Text(
                          '${dataEntrega.day}/${dataEntrega.month}/${dataEntrega.year}',
                        ),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Fechar o pop-up
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          editarAtividade(id,
                                          tituloController.text,
                                          descricaoController.text,
                                          dataEntrega);
                                    
                          // Fechar o pop-up
                          Navigator.of(context).pop();
                      }},
                      child: const Text('Atualizar'),
                    ),
                ]),
              ],
            )
          )
        );
      },
    );
  }




  // Função para abrir o pop-up de envio de atividade
  void _showEntregasDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atividades Entregues'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
              children: [
                 DataTable(
              headingTextStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Inter',
              ),
              columns: [
                ...atividadesEntregues.first.keys
                .map((key) => DataColumn(label: Text(key.toUpperCase())))
              ],
                rows: atividadesEntregues.map((item) => DataRow(
                cells: [
                  ...item.keys
                  .map((key) => DataCell(Text(item[key].toString())))
                  ,
                ],
              )).toList(),
            ),]
            );


            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Fechar o pop-up
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }



  // Função para pegar os usuários da API
  Future<void> getAtividades() async {
    final response = await http.get(Uri.parse('http://localhost:3000/atividades/lista'));

    atividades = [];
    json.decode(response.body).forEach((element) {
      atividades.add({
        "id": element["id"].toString(),
        "titulo": element["titulo"],
        "descricao": element["descricao"],
        "data de entrega": element["dataLimite"]
      });
    });

    setState(() {
      atividades;
    });
  }


  // Função para editar um usuário
  Future<void> editarAtividade(String item, String titulo, String descricao, DateTime data) async {

    final id = int.parse(item);

    // Enviar requisição para a API com json
    final response = await http.patch(Uri.parse('http://localhost:3000/atividades/atualiza'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // converter o item para int
    body: json.encode({
      "id": id,
      "titulo": titulo,
      "descricao": descricao,
      "dataLimite": data.toIso8601String()
    }));

    // Criar a mensagem de retorno
    var mensagem = '';

    if (response.statusCode == 400) {
      mensagem = 'Erro Interno';
    } else {
      mensagem = 'Atividade atualizada com sucesso';
    }

    // Mostrar mensagem de retorno como um alerta
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 4),
      ),
    );

    // Atualizar a lista de usuários
    getAtividades();
  }

  

  // Função para excluir um usuário
  Future<void> excluirAtividade(String item) async {

    final id = int.parse(item);

    // Enviar requisição para a API com json
    final response = await http.delete(Uri.parse('http://localhost:3000/atividades/deleta'),
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
      mensagem = 'Atividade excluída com sucesso';
    }

    // Mostrar mensagem de retorno como um alerta
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 4),
      ),
    );

    // Atualizar a lista de usuários
    getAtividades();
  }



  // Função para pegar as atividades não enviadas 
  void getAtividadesEntregues(BuildContext context, String item) async {

    final id = int.parse(item);

    // Enviar requisição para a API com query string
    final response = await http.get(Uri.parse('http://localhost:3000/userAtividades/listaAtividades?id_atividade=$id'));

    // Limpar a lista de atividades e adicionar as atividades da API
    if (response.body == "[]") {

     atividadesEntregues = [
      {"id": "", "Aluno": "", "email": "", "dataEntrega": "", "nota": ""}
    ];

    } else {
      
      atividadesEntregues = [];
      json.decode(response.body).forEach((element) {

        atividadesEntregues.add({
          "id": element["id"].toString(),
          "aluno": element["autor"]["name"],
          "email": element["autor"]["email"],
          "dataEntrega": element["dataEntrega"],
          "nota": element["nota"] == '-1' ? "Não avaliado" : element["nota"].toString()
        });
      });
    }


    // Atualizar a variável atividades
    setState(() {
      atividadesEntregues;
    });

    // Chamar a função para abrir o pop-up de envio de atividade
    _showEntregasDialog(context);
  }
  

  // Função para selecionar a data  
Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dataEntrega,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != dataEntrega) {
      setState(() {
        dataEntrega = pickedDate;
      });
    }
  }
}
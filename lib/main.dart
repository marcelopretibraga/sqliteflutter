import 'package:flutter/material.dart';
import 'package:sqliteflutter/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo de CRUD básico'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Inserir dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_inserir();},
            ),
            RaisedButton(
              child: Text('Retorna Dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_consultar();},
            ),
            RaisedButton(
              child: Text('Remover Ultimo', style: TextStyle(fontSize: 20),),
              onPressed: () {_removerUltimo();},
            ),
            RaisedButton(
              child: Text('Remover Todos', style: TextStyle(fontSize: 20),),
              onPressed: () {_removerTodos();},
            ),
            RaisedButton(
              child: Text('Alterar Primeiro', style: TextStyle(fontSize: 20),),
              onPressed: () {_atualizar();},
            ),
          ],
        ),
      ),
    );
  }

  void _inserir() async {
    // linha para inserir
    Map<String, dynamic> row = {
      'NOME' : 'Marcelo Preti Braga',
      'IDADE' : 27
    };
    final id = await dbHelper.insert(row);
    print('linha inserida id: $id');
  }

  void _consultar() async {
    final linhas = await dbHelper.getAll();
    print('==============Todas Pessoas================');
    linhas.forEach( (linha) => print(linha));
  }

  void _removerTodos() async {
    print('==============Remover Todos================');
    await dbHelper.removerTodos();
  }

  void _removerUltimo() async {
    print('==============Remover Ultimo================');
    final pessoa = await dbHelper.getLast();

    var id = pessoa['ID'];
    print("Id a remover alterado");
    print(id);
    await dbHelper.remover(id);
  }

  void _atualizar() async {
    // linha para atualizar
    Map<String, dynamic> row = {
      'ID': 1,
      'NOME' : 'Marcelo ALTERADO',
      'IDADE' : 54
    };
    final linhasAfetadas = await dbHelper.update(row, 1);
    print('UPDATE $linhasAfetadas linha(s)');
  }

}

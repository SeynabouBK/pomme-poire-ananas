import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<int> _fruits = []; // Déclaration de la liste des fruits

  void _incrementCounter() {
    setState(() {
      _counter++;
      _fruits.add(_counter); // Ajout d'un nouvel élément à la liste _fruits
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      //map transforme chaque élément, mais le résultat est quelque chose qui n'est pas encore une vraie liste.
      //.toList() convertit le résultat en une vraie liste que le ListView peut afficher.
      body: ListView(
        children: _fruits
            .map((e) => ListTile(
                  title: Text(
                    'Fruit numéro: $e',
                    style:
                        const TextStyle(color: Colors.white), // Texte en blanc
                  ),
                  tileColor: e % 2 == 0
                      ? Colors.indigo
                      : Colors
                          .cyan, // Arrière-plan Indigo si pair, Cyan si impair
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Ajouter un fruit',
        backgroundColor: _counter == 0
            ? Colors.orange
            : _counter % 2 == 0
                ? Colors.indigo
                : Colors.cyan,
        child: const Icon(Icons.add),
      ),
    );
  }
}

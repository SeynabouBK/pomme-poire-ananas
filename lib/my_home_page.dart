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
//Un nombre premier est un entier naturel supérieur à 1 qui n'a que deux diviseurs : 1 et lui-même.
// Si le nombre est inférieur ou égal à 1, il n'est pas premier.
//Elle vérifie s'il existe un autre diviseur de number entre 2 et number ~/ 2 (le ~ représente une division entière).
//false : Si un diviseur est trouvé, ce n'est pas un nombre premier.

  bool isPrime(int number) {
    if (number <= 1) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  Color getBackgroundColor(int number) {
    if (number == 0) {
      return Colors.orange;
    } else if (number % 2 == 0) {
      return Colors.indigo;
    } else {
      return Colors.cyan;
    }
  }

  String getNumberType(int number) {
    if (number == 0) {
      return 'Zero';
    } else if (isPrime(number)) {
      return 'Nombre premier';
    } else if (number % 2 == 0) {
      return 'Nombre pair';
    } else {
      return 'Nombre impair';
    }
  }

  Image getFruitImage(int number) {
    if (isPrime(number)) {
      return Image.asset('images/ananas.png');
    } else if (number % 2 == 0) {
      return Image.asset('images/poire.png');
    } else {
      return Image.asset('images/pomme.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          '$_counter : ${getNumberType(_counter)}',
        ),
      ),
      //map transforme chaque élément, mais le résultat est quelque chose qui n'est pas encore une vraie liste.
      //.toList() convertit le résultat en une vraie liste que le ListView peut afficher.
      body: ListView(
        children: _fruits
            .map((e) => ListTile(
                  leading: getFruitImage(e),
                  title: Text(
                    'Fruit numéro: $e',
                    style:
                        const TextStyle(color: Colors.white), // Texte en blanc
                  ),
                  tileColor: getBackgroundColor(e),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Fruit numéro $e : ${getNumberType(e)}'),
                          backgroundColor: getBackgroundColor(e),
                          content: getFruitImage(e),
                          actions: <Widget>[
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _fruits.remove(
                                      e); // Supprime l'élément de la liste
                                });
                                Navigator.of(context)
                                    .pop(); // Ferme le `AlertDialog`
                              },
                              icon: const Icon(Icons.delete,
                                  color: Colors.redAccent),
                              tooltip: 'Supprimer',
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Ferme le AlertDialog
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                              ),
                              child: const Text('Fermer',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Ajouter un fruit',
        backgroundColor: getBackgroundColor(_counter),
        child: const Icon(Icons.add),
      ),
    );
  }
}

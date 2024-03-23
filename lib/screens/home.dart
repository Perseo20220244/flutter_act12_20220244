import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final words = nouns.take(50).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apps Favoritas'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('favoritos').listenable(),
        builder: (context, box, child) {
          return ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              final isFavorite = box.get(index) != null;
              return ListTile(
                title: Text(word),
                trailing: IconButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    if (isFavorite) {
                      await box.delete(index);
                      const snackBar = SnackBar(
                        content: Text('Removido con Éxito'),
                        backgroundColor: Colors.red,
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      await box.put(index, word);
                      const snackBar = SnackBar(
                        content: Text('Añadido con Éxito'),
                        backgroundColor: Colors.blue,
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

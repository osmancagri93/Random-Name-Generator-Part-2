import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İsim Üretici Başlatıcısı',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const RastgeleKelimeler(),
    );
  }
}

class _RastgeleKelimelerState extends State<RastgeleKelimeler> {
  final _onerilenisimler = <WordPair>[];
  final _kaydet = <WordPair>{};
  final _buyukFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İsim Üretici Başlatıcısı'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _tiklaKaydet,
            tooltip: 'Öneriler Kaydedildi!',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _onerilenisimler.length) {
            _onerilenisimler.addAll(generateWordPairs().take(10));
          }

          final kaydedilenler = _kaydet.contains(_onerilenisimler[index]);

          return ListTile(
            title: Text(
              _onerilenisimler[index].asPascalCase,
              style: _buyukFont,
            ),
            trailing: Icon(
              kaydedilenler ? Icons.favorite : Icons.favorite_border,
              color: kaydedilenler ? Colors.red : null,
              semanticLabel:
                  kaydedilenler ? 'Kayıtlardan Silindi!' : 'Kaydedildi!',
            ),
            onTap: () {
              setState(() {
                if (kaydedilenler) {
                  _kaydet.remove(_onerilenisimler[index]);
                } else {
                  _kaydet.add(_onerilenisimler[index]);
                }
              });
            },
          );
        },
      ),
    );
  }

  void _tiklaKaydet() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _kaydet.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _buyukFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('İsim Önerisi Kaydedildi!'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

class RastgeleKelimeler extends StatefulWidget {
  const RastgeleKelimeler({super.key});

  @override
  State<RastgeleKelimeler> createState() => _RastgeleKelimelerState();
}

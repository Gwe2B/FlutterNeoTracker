import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:master_neo/api_calls.dart';
import 'package:master_neo/model/neo.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Near Earth Object',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Near Earth Object'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<NEO>> futureNeo;

  @override
  void initState() {
    super.initState();
    futureNeo = ApiCalls.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<NEO>>(
        future: futureNeo,
        builder: (context, snapshot) {
          Widget retour = const CircularProgressIndicator();

          if (snapshot.hasData) {
            retour = ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                print(snapshot.data!.elementAt(index));
                return Text(snapshot.data!.elementAt(index).name);
              }),
            );
          } else if (snapshot.hasError) {
            retour = Text('${snapshot.error}');
          }
          return retour;
        },
      ),
    );
  }
}

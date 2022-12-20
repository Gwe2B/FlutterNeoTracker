import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:master_neo/api_calls.dart';
import 'package:master_neo/list_item.dart';
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
          Widget retour = const Center(child: CircularProgressIndicator());

          if (snapshot.hasData) {
            retour = ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return ListItem(object: snapshot.data!.elementAt(index));
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

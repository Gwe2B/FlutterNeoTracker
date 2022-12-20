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
  late ScrollController _controller;
  int lastFetchedPage = 0;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        lastFetchedPage++;
        setState(() {
          futureNeo = ApiCalls.fetchAppend(futureNeo, lastFetchedPage);
        });
      }
    });

    super.initState();
    futureNeo = ApiCalls.fetchAll();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              controller: _controller,
              itemCount: snapshot.data!.length + 1,
              itemBuilder: ((context, index) {
                if (index < snapshot.data!.length) {
                  return ListItem(object: snapshot.data!.elementAt(index));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
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

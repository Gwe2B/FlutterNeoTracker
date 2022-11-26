import 'package:flutter/material.dart';

import 'model/neo.dart';

class DetailedView extends StatefulWidget {
  final NEO object;
  const DetailedView({Key? key, required this.object}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Near Earth Object')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(),
      ),
    );
  }
}

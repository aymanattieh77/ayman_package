import 'dart:math';

import 'package:ayman_package/logs/logs.dart';
import 'package:flutter/material.dart';

class RecordableListPage extends StatefulWidget {
  const RecordableListPage({super.key});

  @override
  State<StatefulWidget> createState() => _RecordableListPageState();
}

class _RecordableListPageState extends State<RecordableListPage> {
  late List<Color> items;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    Random r = Random();
    items = List.generate(
        5,
        (index) =>
            Color.fromRGBO(r.nextInt(255), r.nextInt(255), r.nextInt(255), 1));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // description of the page
          const Text(
            'Press and hold an item to start dragging. Drag an item between two other items to insert it between them.',
          ),

          Expanded(
            child: ReorderableListView.builder(
              itemCount: items.length,
              physics: const BouncingScrollPhysics(),
              header: const Text("HEADER"),
              itemBuilder: (context, index) {
                return Container(
                  key: Key(items[index].toString()),
                  height: 80,
                  color: items[index],
                );
              },
              onReorder: (oldIndex, newIndex) {
                logSuccess("$oldIndex $newIndex");
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = items.removeAt(oldIndex);
                  items.insert(newIndex, item);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

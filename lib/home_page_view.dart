import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: ValueListenableBuilder(
          valueListenable: Hive.box('settings').listenable(),
          builder: (context, box, child) {
            final isDark = box.get('isDark', defaultValue: false);
            return Switch(
              value: isDark,
              onChanged: (val) {
                box.put('isDark', val);
              },
            );
          },
        )),
        floatingActionButton: ValueListenableBuilder(
          valueListenable: Hive.box('settings').listenable(),
          builder: (context, box, child) {
            final isDark = box.get('isDark', defaultValue: false);
            return FloatingActionButton(
              onPressed: () {
                bool val = false;
                Hive.box('settings').put('isDark', val);
              },
              tooltip: 'Increment',
              child: const Icon(Icons.change_circle),
            );
          },
        ));
  }
}

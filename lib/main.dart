import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show LogicalKeyboardKey, rootBundle;

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dataFromFile = '';
  List<String> data = ['test'];
  late TextEditingController _controller;
  Future<void> readText(String amm, List<String> aray) async {
    if (amm.isNotEmpty) {
      for (var name in aray) {
        if (name == amm) {
          final String response =
              await rootBundle.loadString('assets/$amm.txt');
          setState(() {
            dataFromFile = response;
          });
        } else {
          setState(() {
            dataFromFile = 'Файл не найден!';
          });
        }
      }
    }
  }

  @override
  void initState() {
    readText(dataFromFile, data);
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: Padding(
        padding: EdgeInsets.all(65.0),
        child: Column(
          children: [
            FocusTraversalGroup(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  Form.of(primaryFocus!.context!)!.save();
                },
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: "Search",
                    labelStyle: TextStyle(color: Colors.purple),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.purple,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2,
                        )),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2,
                      ),
                    ),
                    hintText: "Введите значение",
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      readText(value, data);
                    } else {
                      setState(() {
                        dataFromFile = 'Файл не найден!';
                      });
                    }
                  },
                ),
              ),
            ),
            Text(dataFromFile),
          ],
        ),
      ))),
    );
  }
}

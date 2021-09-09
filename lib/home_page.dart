import 'dart:developer';
//https://www.youtube.com/watch?v=NOrUazt9vNI&t=2s
import 'package:flutter/material.dart';
import 'package:flutter_provider_list_dynamic/models/model.dart';
import 'package:flutter_provider_list_dynamic/provider/list_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> _formKey;
  TextEditingController _controller;
  var taskItems;
  int counter = 0;
  DynamicList listClass;
  String txtBtnAdd = 'Add';
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _controller = TextEditingController();
    taskItems = Provider.of<ListProvider>(context, listen: false);
    listClass = DynamicList(taskItems.list);
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
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Container(
                  width: 200,
                  height: 50,
                  child: TextFormField(
                    controller: _controller,
                    decoration:
                        InputDecoration(labelText: 'Insira um texto aqui...'),
                    onSaved: (val) {
                      taskItems.addItem(val);
                    },
                    validator: (val) {
                      if (val.length > 0) {
                        return null;
                      } else {
                        return 'Add a text';
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    _controller.clear();
                  }
                },
                child: Text(txtBtnAdd),
              ),
            ),
            Consumer<ListProvider>(builder: (context, provider, listTile) {
              return Expanded(
                child: ListView.builder(
                  itemCount: listClass.list.length,
                  itemBuilder: buildList,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    counter++;
    return Dismissible(
        key: Key(
          counter.toString(),
        ),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          taskItems.deleteItem(index);
        },
        child: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            title: Text(
              listClass.list[index],
            ),
            trailing: Icon(Icons.keyboard_arrow_left),
          ),
        ));
  }
}

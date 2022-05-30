import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todo = [
    Todo(
      id: 1,
      details: 'Teach senya numbers',
    ),
  ];

  final ScrollController _sc = ScrollController();
  final TextEditingController _tc = TextEditingController();
  final FocusNode _fn = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos App')),
      backgroundColor: Colors.amberAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  controller: _sc,
                  child: SingleChildScrollView(
                    controller: _sc,
                    child: Column(
                      children: [
                        for (Todo todo in todo)
                          ListTile(
                            leading: Text(todo.id.toString()),
                            title: Text(todo.created.toString()),
                            subtitle: Text(todo.details),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                removeTodo(todo.id);
                              },
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: _tc,
                focusNode: _fn,
                maxLines: 5,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    prefix: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _fn.unfocus();
                      },
                    ),
                    suffix: IconButton(
                      icon: Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        addTodo(_tc.text);
                        _tc.text = '';
                        _fn.unfocus();
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addTodo(String details) {
    int index = 0;
    if (todo.isEmpty) {
      index = 0;
    } else {
      index = todo.last.id + 1;
    }
    todo.add(Todo(details: details, id: index));
    if (mounted) setState(() {});
  }

  removeTodo(int id) {
    if (todo.isNotEmpty) {
      for (int i = 0; i < todo.length; i++) {
        if (id == todo[i].id) {
          todo.removeAt(i);
          setState(() {});
        }
      }
    }
  }
}

class Todo {
  String details;
  late DateTime created;
  int id;

  Todo({this.details = '', DateTime? created, this.id = 0}) {
    created == null ? this.created = DateTime.now() : this.created = created;
  }
}

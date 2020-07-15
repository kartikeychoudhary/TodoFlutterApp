import 'package:Todo/Store/store.dart';
import 'package:Todo/screens/add_todo.dart';
import 'package:Todo/widgets/todo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

class TodoDetail extends StatefulWidget {
  final todo;
  final type;
  final color;
  final icon;

  const TodoDetail({Key key, this.todo, this.type, this.color, this.icon})
      : super(key: key);
  @override
  _TodoDetailState createState() => _TodoDetailState(todo, type, color, icon);
}

class _TodoDetailState extends State<TodoDetail> {
  var todo;
  final type;
  final color;
  final icon;

  var date_flag = 0;
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');

  refresh() {
    this.setState(() {
      this.date_flag = 0;
    });
  }

  calculateLeftTask() {
    int left = 0;

    for (var t in todo) {
      if (t['status'] == false) {
        left += 1;
      }
    }
    return left;
  }

  calculateTaskCompleted() {
    int completed = 0;
    for (var t in todo) {
      if (t['status'] == true) {
        completed += 1;
      }
    }
    if (todo.length > 0) {
      var result = (completed / todo.length);

      return result;
    } else {
      return 0;
    }
  }

  _TodoDetailState(this.todo, this.type, this.color, this.icon);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: this.color,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => {Navigator.pop(context)}),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: this.type,
                        child: Icon(
                          this.icon,
                          color: this.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${calculateLeftTask()} Tasks left",
                          style:
                              TextStyle(color: Color.fromRGBO(0, 0, 0, 0.25)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 0.0),
                        child: Text(
                          '${this.type.toString()[0].toUpperCase()}${this.type.toString().substring(1)}',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(0, 0, 0, 0.65)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.black12,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        this.color,
                      ),
                      value: calculateTaskCompleted(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
              // Text("Tasks ...",
              //     style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.50))),
              Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: this.todo.length,
                      itemBuilder: (BuildContext cxt, int i) {
                        var day = DateTime.parse(todo[i]['date']).day;
                        var temp = this.date_flag;
                        this.date_flag = day;
                        var date = DateTime.parse(todo[i]['date']);

                        return Column(
                          children: [
                            (day != temp)
                                ? Row(
                                    children: [
                                      Text(
                                        "${formatter.format(date)}",
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            TodoUI(
                              key: UniqueKey(),
                              title: todo[i]['title'],
                              status: todo[i]['status'],
                              date: todo[i]['date'],
                              id: todo[i]['id'],
                              type: this.type,
                              deleteTodo: () => this.setState(() {
                                this.todo.removeAt(i);
                                this.date_flag = 0;
                              }),
                            ),
                          ],
                        );
                      }))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return AddTodo(
                  color: this.color, type: this.type, refresh: this.refresh);
            }))
          },
          child: Icon(Icons.add),
          backgroundColor: this.color,
        ),
      ),
    );
  }
}

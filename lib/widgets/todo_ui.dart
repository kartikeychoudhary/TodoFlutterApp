import 'package:Todo/Store/Reducer/actions.dart';
import 'package:Todo/Store/store.dart';
import 'package:Todo/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class TodoUI extends StatefulWidget {
  final title;
  final status;
  final date;
  final type;
  final id;

  final VoidCallback deleteTodo;

  TodoUI({
    Key key,
    this.title,
    this.status,
    this.date,
    this.type,
    this.id,
    this.deleteTodo,
  }) : super(key: key);

  @override
  _TodoUIState createState() =>
      _TodoUIState(title, status, date, type, id, deleteTodo);
}

class _TodoUIState extends State<TodoUI> {
  var title;
  var status;
  var date;
  var type;
  var id;
  var edit = false;

  VoidCallback deleteTodo;

  _TodoUIState(
      this.title, this.status, this.date, this.type, this.id, this.deleteTodo);

  @override
  Widget build(BuildContext context) {
    print(
        "${this.title}, ${this.status}, ${this.date}, ${this.type}, ${this.id}");

    return Container(
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: !this.status
            ? GestureDetector(
                onLongPress: () => this.setState(() {
                  this.edit = true;
                }),
                child: !this.edit
                    ? Row(
                        children: [
                          Checkbox(
                            value: status,
                            onChanged: (bool value) {
                              StoreProvider.of<AppState>(context).dispatch(
                                  Completed(value, this.id, this.type));
                              this.setState(() {
                                this.status = value;
                              });
                            },
                            activeColor: colorArray[0],
                          ),
                          Text(
                            title,
                            style: TextStyle(color: Colors.black87),
                          )
                        ],
                      )
                    : Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {
                                StoreProvider.of<AppState>(context).dispatch(
                                    ChangeTitle(
                                        this.title, this.id, this.type));
                                this.setState(() {
                                  this.edit = false;
                                });
                              }),
                          Expanded(
                            child: TextFormField(
                              initialValue: this.title,
                              onChanged: (value) => this.setState(() {
                                this.title = value;
                              }),
                            ),
                          )
                        ],
                      ),
              )
            : Row(
                children: [
                  Checkbox(
                    value: status,
                    onChanged: (bool value) {
                      StoreProvider.of<AppState>(context)
                          .dispatch(Completed(value, this.id, this.type));
                      this.setState(() {
                        this.status = value;
                      });
                    },
                    activeColor: colorArray[0],
                  ),
                  Text(title,
                      style: TextStyle(
                          color: Colors.black38,
                          decoration: TextDecoration.lineThrough)),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        StoreProvider.of<AppState>(context)
                            .dispatch(Delete(this.id, this.type));
                        this.deleteTodo();
                      })
                ],
              ));
  }
}

import 'package:Todo/Store/Reducer/actions.dart';
import 'package:Todo/Store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

class AddTodo extends StatefulWidget {
  final color;
  final type;
  final refresh;

  const AddTodo({Key key, this.color, this.type, this.refresh})
      : super(key: key);

  @override
  _AddTodoState createState() =>
      _AddTodoState(this.color, this.type, this.refresh);
}

class _AddTodoState extends State<AddTodo> {
  final color;
  final type;
  var taskTitle;
  var date;
  var tommorrow = true;
  var validation = true;
  final refresh;

  DateTime _dateTime = DateTime.now();
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');

  _AddTodoState(this.color, this.type, this.refresh);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: this.color,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "New Task",
            style: TextStyle(fontSize: 20.0, color: Colors.white70),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white70,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 0.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "What task are you planning to perform. ?",
                        style: TextStyle(color: Colors.black54, fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                      onChanged: (value) => this.setState(() {
                            if (value != null) {
                              this.taskTitle = value;
                              this.validation = true;
                            } else {
                              this.validation = false;
                            }
                          })),
                  SizedBox(height: 40.0),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                SizedBox(height: 10.0),
                                Text(
                                  "Pick Date",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 18.0),
                                ),
                                Expanded(
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: _dateTime,
                                    onDateTimeChanged: (dateTime) {
                                      this.setState(() {
                                        _dateTime = dateTime;
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.check),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            );
                          });
                    },
                    child: Row(
                      children: [
                        Text("Date",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 18.0)),
                        Spacer(),
                        Text("${this.formatter.format(_dateTime)}",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 18.0))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) => GestureDetector(
                  onTap: () {
                    store.dispatch(new AddTask(
                        this.taskTitle, this._dateTime.toString(), this.type));
                    Navigator.pop(context);
                    this.refresh();
                  },
                  child: Container(
                    height: AppBar().preferredSize.height,
                    color: this.color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

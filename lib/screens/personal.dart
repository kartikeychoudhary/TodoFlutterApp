import 'package:Todo/Store/store.dart';
import 'package:Todo/widgets/todo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PersonalScreen extends StatefulWidget {
  final title;

  const PersonalScreen(String stringArray, {Key key, this.title})
      : super(key: key);
  @override
  _PersonalScreenState createState() => _PersonalScreenState(title);
}

class _PersonalScreenState extends State<PersonalScreen> {
  final title;

  var sample = [
    {"id": "1", "title": "test", "status": false, "date": "timestamp"},
    {"id": "2", "title": "test2", "status": false, "date": "timestamp"}
  ];

  _PersonalScreenState(this.title);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(247, 123, 103, 1),
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
                        tag: 'avatar0',
                        child: Icon(
                          Icons.person,
                          color: Color.fromRGBO(247, 123, 103, 1),
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
                          "Tasks left",
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
                          "Personal",
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
                        Color.fromRGBO(247, 123, 103, 1),
                      ),
                      value: 0.8,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Text("Tasks ...",
                  style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.50))),
              Expanded(
                child: StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (context, state) {
                    // print(state.sample);
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.personalTodo.length,
                        itemBuilder: (BuildContext cxt, int i) {
                          return TodoUI(
                              title: state.personalTodo[i]['title'],
                              status: state.personalTodo[i]['status'],
                              date: state.personalTodo[i]['date'],
                              id: state.personalTodo[i]['id'],
                              type: 'personal');
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

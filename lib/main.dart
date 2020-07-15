import 'package:Todo/screens/personal.dart';
import 'package:Todo/screens/todo_detail.dart';
import 'package:Todo/values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'Store/store.dart';
import 'Store/Reducer/actions.dart';

void main() {
  runApp(new Todo());
}

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Todo';

    return new MaterialApp(
      theme: new ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'SFProDisplay',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      title: title,
      home: new StoreProvider<AppState>(
        store: store,
        child: new Scaffold(
          body: TodoBody(),
          // floatingActionButton: new StoreConnector<AppState, VoidCallback>(
          //   converter: (store) {
          //     return () => store.dispatch(actions.Increment);
          //   },
          //   builder: (context, callback) => new FloatingActionButton(
          //     onPressed: callback,
          //     tooltip: 'Increment',
          //     child: new Icon(Icons.add),
          //   ),
          // ),
        ),
      ),
    );
  }
}

class TodoBody extends StatefulWidget {
  @override
  _TodoBodyState createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {
  int _index = 0;
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorArray[_index],
      child: StoreProvider<AppState>(
        store: store,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppBar(
                centerTitle: true,
                backgroundColor: colorArray[_index],
                title: Text(
                  "TODO",
                  style: TextStyle(
                      color: Colors.white, fontFamily: "SFProDisplay"),
                ),
                elevation: 0.0,
                leading: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                actions: [
                  Icon(
                    Icons.search,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 20.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Hey, User.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Looks like feels Good.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "You have 3 tasks to do today.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Today : ${formatter.format(DateTime.now())}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              child: SizedBox(
                height: 250, // card height
                child: StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (context, state) => PageView.builder(
                      itemCount: 4,
                      controller: PageController(viewportFraction: 0.5),
                      onPageChanged: (int index) =>
                          setState(() => _index = index),
                      itemBuilder: (_, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              // return PersonalScreen(stringArray[i]);
                              print(stringArray[i]);
                              return TodoDetail(
                                todo: state.sample[stringArray[i].toLowerCase()]
                                    ['todo'],
                                type: stringArray[i].toLowerCase(),
                                color: colorArray[i],
                                icon: iconsArray[i],
                              );
                            }));
                          },
                          child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            20.0, 20.0, 0.0, 0.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Hero(
                                            tag: stringArray[i],
                                            child: Icon(
                                              iconsArray[i],
                                              color: colorArray[i],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              "Tasks left",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.25)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 4.0, 0.0, 0.0),
                                            child: Text(
                                              stringArray[i],
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.65)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.black12,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            colorArray[i],
                                          ),
                                          value: 0.8,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:html';

import 'package:uuid/uuid.dart';

import '../store.dart';
import "actions.dart";

AppState reducer(AppState prevState, dynamic action) {
  var uuid = Uuid();

  AppState newState = AppState.fromAppState(prevState);
  // print("${action.id} ${action.type}");
  if (action is Completed) {
    for (var todo in newState.sample[action.type]['todo']) {
      if (todo['id'] == action.id) {
        todo['status'] = action.status;
        print(todo['status']);
      }
    }

    // print(newState.sample);
    return newState;
  } else if (action is ChangeTitle) {
    for (var todo in newState.sample[action.type]['todo']) {
      if (todo['id'] == action.id) {
        todo['title'] = action.title;
        print('reducer');
        print(todo['title']);
      }
    }

    print(newState.sample);
    return newState;
  } else if (action is Delete) {
    var temp = [];
    for (var todo in newState.sample[action.type]['todo']) {
      if (todo['id'] == action.id) {
        continue;
      } else {
        temp.add(todo);
      }
    }
    newState.sample[action.type]['todo'] = temp;
    print(newState.sample);
    return newState;
  } else if (action is AddTask) {
    var temp = newState.sample[action.type]['todo'];
    temp.add({
      'id': uuid.v1(),
      'title': action.title,
      'date': action.date,
      'status': false
    });
    newState.sample[action.type]['todo'] = temp;

    return newState;
  }

  return prevState;
}

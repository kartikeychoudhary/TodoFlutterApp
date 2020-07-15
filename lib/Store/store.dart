import 'package:flutter/foundation.dart';

import 'Reducer/reducer.dart';
import 'package:redux/redux.dart';

class AppState {
  var sample;

  AppState({@required this.sample});

  AppState.fromAppState(AppState another) {
    sample = another.sample;
  }

  get personalTodo => sample['personal']['todo'];
  todoGet(type) => sample[type]['todo'];
}

final store = new Store(reducer,
    initialState: AppState(sample: {
      "avatar": "link",
      "personal": {
        "task": 1,
        "todo": [
          {
            "id": "1",
            "title": "test",
            "status": false,
            "date": "2020-07-15 15:43:12.276"
          },
          {
            "id": "2",
            "title": "test",
            "status": false,
            "date": "2020-07-15 15:43:12.276"
          }
        ]
      },
      "work": {
        "task": 1,
        "todo": [
          {
            "id": "1",
            "title": "test",
            "status": false,
            "date": "2020-07-15 15:43:12.276"
          }
        ]
      },
      "home": {
        "task": 1,
        "todo": [
          {
            "id": "1",
            "title": "test",
            "status": false,
            "date": "2020-07-15 15:43:12.276"
          }
        ]
      },
      "balance": {
        "task": 1,
        "todo": [
          {
            "id": "1",
            "title": "test",
            "status": false,
            "date": "2020-07-15 15:43:12.276"
          }
        ]
      }
    }));

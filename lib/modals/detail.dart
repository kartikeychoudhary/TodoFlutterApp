import 'package:Todo/main.dart';
import 'package:Todo/modals/todo_modal.dart';

class Detail {
  final avatar;

  final List<TodoModal> personal;
  final List<TodoModal> work;
  final List<TodoModal> balance;
  final List<TodoModal> home;

  Detail(this.avatar, this.personal, this.work, this.balance, this.home);
}

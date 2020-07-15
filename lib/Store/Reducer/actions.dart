class Completed {
  final status;
  final id;
  final type;

  Completed(this.status, this.id, this.type);
}

class ChangeTitle {
  final title;
  final id;
  final type;

  ChangeTitle(this.title, this.id, this.type);
}

class Delete {
  final id;
  final type;

  Delete(this.id, this.type);
}

class AddTask {
  final title;
  final date;
  final type;

  AddTask(this.title, this.date, this.type);
}

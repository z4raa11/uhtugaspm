  class ToDo {
    String title;
    String description;
    bool isDone;

    ToDo({
      required this.title,
      required this.description,
      this.isDone = false,
    });
  }

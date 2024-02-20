import 'model.dart';

class TaskRepository {
  final List<Task> _taskList = [
    Task(
        0,
        "Study MVVM",
        "In order to avoid ugly state management librares and collect continuously technical debt, I should study proper state management patterns",
        false),
  ];

  final List<Message> _messageList = [
    Message(0, "This is a default Message"),
  ];

  void addTask(Task task) {
    task.id = _taskList.length;
    _taskList.add(task);
  }

  void removeTask(Task task) {
    _taskList.remove(task);
  }

  void updateTask(Task task) {
    _taskList[_taskList.indexWhere((element) => element.id == task.id)] = task;
  }

  void sendMessage(Message msg) {
    msg.message_id = _messageList.length;
    _messageList.add(msg);
  }

  Future<List<Task>> loadTasks() async {
    // Simulate a http request
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_taskList);
  }

  Future<List<Message>> loadMessages() async {
    // Simulate a http request
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_messageList);
  }

}
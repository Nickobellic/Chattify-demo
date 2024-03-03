import '../mvvm/viewmodel.dart';
import './repository.dart';

import '../mvvm/observer.dart';
import 'model.dart';

class TaskViewModel extends EventViewModel {
  TaskRepository _repository;

  TaskViewModel(this._repository);

  void loadTasks() {
    notify(LoadingEvent(isLoading: true));
    _repository.loadTasks().then((value) {
      notify(TasksLoadedEvent(tasks: value));
      notify(LoadingEvent(isLoading: false));
    });
  }

  void createTask(String title, String description) {
     notify(LoadingEvent(isLoading: true));
     // ... code to create the task
     _repository.addTask(Task(1, title, description, false));
     notify(LoadingEvent(isLoading: false));
  }

  void addMessage(String _message) {
     notify(LoadingEvent(isLoading: true));
     // ... code to create the task
     _repository.sendMessage(Message(1, _message));
     notify(LoadingEvent(isLoading: false));
  }

    void loadMessages() {
    notify(LoadingEvent(isLoading: true));
    _repository.loadMessages().then((value) {
      notify(MessagesLoadedEvent(messages: value));
      notify(LoadingEvent(isLoading: false));
    });
  }
}

class LoadingEvent extends ViewEvent {
  bool isLoading;

  LoadingEvent({required this.isLoading}) : super("LoadingEvent");
}

class TasksLoadedEvent extends ViewEvent {
  final List<Task> tasks;

  TasksLoadedEvent({required this.tasks}) : super("TasksLoadedEvent");
}

class MessagesLoadedEvent extends ViewEvent {
  final List<Message> messages;

  MessagesLoadedEvent({required this.messages}) : super("MessagesLoadedEvent");
}

// should be emitted when 
class TaskCreatedEvent extends ViewEvent {
  final Task task;

  TaskCreatedEvent(this.task) : super("TaskCreatedEvent");
}
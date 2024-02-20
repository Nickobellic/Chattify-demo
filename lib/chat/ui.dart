import 'package:flutter/material.dart';
import 'package:learn_flut/chat/text.dart';
import '../mvvm/observer.dart';
import './repository.dart';
import './viewmodel.dart';
import "dm.dart";
import 'model.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskWidgetState();
  }
}

class _TaskWidgetState extends State<TaskWidget> implements EventObserver {
// Consider making TaskRepository() a singleton by using a factory
  final TaskViewModel _viewModel = TaskViewModel(TaskRepository());
  bool _isLoading = false;
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chattify"),
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FloatingActionButton(
          onPressed:  () { _viewModel.createTask("New Task", "Hard Coded Tasks tbh"); }
,
          child: Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () {    _viewModel.loadTasks(); } ,
          child: Icon(Icons.refresh),
        ),
      ],
    ),
  ),
      
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                
                return ListTile(
                  title: Text(_tasks[index].title),
                  subtitle: Text(_tasks[index].description),
                  onTap: () => Navigator.push(context,
    MaterialPageRoute(builder: (context) => const MyCustomForm()),
  ),
                );
              },
            )
    );
  }

  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _isLoading = event.isLoading;
      });
    } else if (event is TasksLoadedEvent) {
      setState(() {
        _tasks = event.tasks;
      });
    }
  }
}
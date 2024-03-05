import 'package:flutter/material.dart';
import 'package:learn_flut/chat/text.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:learn_flut/responsive/responsive.dart';
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

class WebAccountListWidget extends StatefulWidget {
  const WebAccountListWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WebAccountState();
  }
}

class _WebAccountState extends State<WebAccountListWidget>
    implements EventObserver {
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
      double width = MediaQuery.of(context).size.width;
  double loadPosition = width * 0.35;
    return Scaffold(
        appBar: AppBar(
          title: Text("Chattify (Web)"),
          backgroundColor: Colors.green,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color for the button
                  borderRadius: BorderRadius.circular(10), // Adjust as needed
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: 10), // Padding for the button
                child: TextButton(
                  onPressed: () {
                    // Call the method to load tasks again
                    _viewModel.loadTasks();
                  },
                  child: Text(
                    "Refresh",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 300,
                  color: Colors.lightGreen,
                ),
                Positioned(
                  top: 10, // Adjust as needed
                  left: 10, // Adjust as needed
                  child: GestureDetector(
                    onTap: () {
                      _viewModel.createTask("New Task", "Hard Coded Tasks tbh");
                    },
                    child: Container(
                      width: 280, // Adjust as needed
                      height: 50, // Adjust as needed
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            BorderRadius.circular(10), // Adjust as needed
                      ),
                      child: Center(
                        child: Text(
                          'Add Data',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _isLoading
                ? Center(
                    child:  Padding(
                      child:  CircularProgressIndicator(),
                      padding: EdgeInsets.only(left: loadPosition),
                    )
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_tasks[index].title),
                          subtitle: Text(_tasks[index].description),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResponsiveLayout(
                                      desktopBody: MyWebCustomForm(),
                                      mobileBody: MyCustomForm(),
                                    )),
                          ),
                        );
                      },
                    ),
                  )
          ],
        ));
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
          title: Text("Chattify"),
          backgroundColor: Colors.blue,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  _viewModel.createTask("New Task", "Hard Coded Tasks tbh");
                },
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  _viewModel.loadTasks();
                },
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
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyCustomForm()),
                    ),
                  );
                },
              ));
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

import 'package:flutter/material.dart';
import '../mvvm/observer.dart';
import './repository.dart';
import './viewmodel.dart';
import "./text.dart";

import 'model.dart';

class DirectMessageWidget extends StatefulWidget {
  const DirectMessageWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DirectMessageWidgetState();
  }
}

class _DirectMessageWidgetState extends State<DirectMessageWidget> implements EventObserver {
// Consider making TaskRepository() a singleton by using a factory
  final TaskViewModel _viewModel = TaskViewModel(TaskRepository());
  bool _isLoading = false;
  List<Message> _messages = [];

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
      
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : MyCustomForm()
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

      });
    }
  }
}
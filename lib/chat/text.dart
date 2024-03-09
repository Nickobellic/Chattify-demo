import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learn_flut/chat/model.dart';
import 'package:learn_flut/chat/repository.dart';
import 'package:learn_flut/chat/viewmodel.dart';
import "../mvvm/observer.dart";

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() {
    return _MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> implements EventObserver {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final TaskViewModel _viewModel = TaskViewModel(TaskRepository());
  bool _isLoading = false;
  List<Message> _messages = [];

  double _paddingTop = 700.0;

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _paddingTop =
              350.0; // Update the padding when the TextField receives focus
        });
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _paddingTop =
                700.0; // Reset the padding when the TextField loses focus
          });
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
    _viewModel.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('John Doe'),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: ListView.builder(
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_messages[index].message),
            );
          },
        )),
        Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.bottomCenter,
          child: TextField(
            focusNode: _focusNode,
            controller: myController,
            decoration: InputDecoration(hintText: "Enter your message.."),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          setState(() {
            _paddingTop = 350.0;
            log(myController.text);
            _viewModel.addMessage(myController.text);
            _viewModel.loadMessages();
            myController.clear();
          });
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.send),
      ),
    );
  }

  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _isLoading = event.isLoading;
      });
    } else if (event is MessagesLoadedEvent) {
      setState(() {
        _messages = event.messages;
      });
    }
  }
}

// Define a Web custom Form widget.
class MyWebCustomForm extends StatefulWidget {
  const MyWebCustomForm({super.key});

  @override
  State<MyWebCustomForm> createState() {
    return _MyWebCustomForm();
  }
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyWebCustomForm extends State<MyWebCustomForm> implements EventObserver {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final TaskViewModel _viewModel = TaskViewModel(TaskRepository());
  bool _isLoading = false;
  List<Message> _messages = [];

  double _paddingTop = 700.0;

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _paddingTop =
              350.0; // Update the padding when the TextField receives focus
        });
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _paddingTop =
                700.0; // Reset the padding when the TextField loses focus
          });
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
    _viewModel.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('John Doe'),
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_messages[index].message),
                    );
                  },
                )),
                // Input text area
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    focusNode: _focusNode,
                    controller: myController,
                    decoration:
                        InputDecoration(hintText: "Enter your message.."),
                  ),
                ),
                // Send button
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Implement send button functionality
                //     },
                //     child: Text('Send'),
                //   ),
                // ),
              ],
            ),
          ),
          // Column(children: <Widget>[
          //   Expanded(
          //       child: ListView.builder(
          //     itemCount: _messages.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(_messages[index].message),
          //       );
          //     },
          //   )),
          //   Container(
          //     padding: EdgeInsets.all(16),
          //     margin: EdgeInsets.only(top: _paddingTop - 16),
          //     child: TextField(
          //       focusNode: _focusNode,
          //       controller: myController,
          //       decoration: InputDecoration(hintText: "Enter your message.."),
          //     ),
          //   ),
          // ]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          setState(() {
            _paddingTop = 350.0;
            log(myController.text);
            _viewModel.addMessage(myController.text);
            _viewModel.loadMessages();
            myController.clear();
          });
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.send),
      ),
    );
  }

  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _isLoading = event.isLoading;
      });
    } else if (event is MessagesLoadedEvent) {
      setState(() {
        _messages = event.messages;
      });
    }
  }
}

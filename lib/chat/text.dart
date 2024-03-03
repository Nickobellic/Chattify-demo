/*import 'package:flutter/material.dart';


/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Styling Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}*/

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();

  /*@override
  Widget build(BuildContext context) {
    return Material(
      
      child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
    );
  }*/
}

class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
    return TextField(
  controller: myController,
)
  }
}*/







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
  State<MyCustomForm> createState() 
  {
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
          _paddingTop = 350.0; // Update the padding when the TextField receives focus
        });
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
          _paddingTop = 700.0; // Reset the padding when the TextField loses focus
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
      ),
      body: Column (
        children: <Widget> [
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
        margin: EdgeInsets.only(top: _paddingTop-16),

        child: TextField(
          focusNode: _focusNode,
          controller: myController,
          decoration: InputDecoration(
            hintText: "Enter your message.."
          ),
        ),
      ),
        ]
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learn/Home/bloc/home_bloc.dart';

void main() {
  // Entry point of the Flutter application
  runApp(MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Providing the HomeBloc to the widget tree
      home: BlocProvider(create: (context) => HomeBloc(), child: CounterPage()),
    );
  }
}

// Widget representing the Counter Page
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the HomeBloc instance from the context
    final HomeBloc counterBloc = BlocProvider.of<HomeBloc>(context);

    return BlocBuilder<HomeBloc, CounterState>(
      // Rebuilding the UI based on the current state of HomeBloc
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Flutter BLoC Example'),
            backgroundColor: Colors.blue.shade800,
            foregroundColor: Colors.white,
          ),
          body: Center(
            // Displaying the current counter value
            child: Text(
              'Counter: ${state.counter}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue.shade800,
            foregroundColor: Colors.white,
            onPressed: () {
              // Dispatching an event to increment the counter
              counterBloc.add(CounterIncrementPressed(counter: state.counter));
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}

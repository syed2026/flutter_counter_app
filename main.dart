import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'counter.dart';

void main() {
  setupWindow();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

const double windowWidth = 360;
const double windowHeight = 640;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Counter');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Color _getBackgroundColor(int age) {
    if (age <= 12) return Colors.lightBlue;
    if (age <= 19) return Colors.lightGreen;
    if (age <= 30) return Colors.yellow.shade200;
    if (age <= 50) return Colors.orange;
    return Colors.grey.shade400;
  }

  String _getAgeMessage(int age) {
    if (age <= 12) return "You're a child!";
    if (age <= 19) return "Teenager time!";
    if (age <= 30) return "You're a young adult!";
    if (age <= 50) return "You're an adult now!";
    return "Golden years!";
  }

  Color _getProgressBarColor(int age) {
    if (age <= 33) return Colors.green;
    if (age <= 67) return Colors.yellow;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(
      builder: (context, counter, child) {
        return Scaffold(
          backgroundColor: _getBackgroundColor(counter.value),
          appBar: AppBar(
            title: const Text('Flutter Age Counter'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Your Age:', style: TextStyle(fontSize: 24)),
                Text('${counter.value}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                Text(_getAgeMessage(counter.value), style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),

                // Progress Bar
                LinearProgressIndicator(
                  value: counter.value / 99,
                  color: _getProgressBarColor(counter.value),
                  backgroundColor: Colors.grey[300],
                  minHeight: 10,
                ),
                const SizedBox(height: 20),

                // Slider for Age
                Slider(
                  value: counter.value.toDouble(),
                  min: 0,
                  max: 99,
                  divisions: 99,
                  label: '${counter.value}',
                  onChanged: (double newValue) {
                    counter.setValue(newValue.toInt());
                  },
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: 'decrement',
                      onPressed: counter.decrement,
                      tooltip: 'Decrement',
                      child: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      heroTag: 'increment',
                      onPressed: counter.increment,
                      tooltip: 'Increment',
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

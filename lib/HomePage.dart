import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;

  Future<int> getCounterValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('counterValue') ?? 0; // Default to 0 if null
  }

  Future<void> setCounterValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('counterValue', counter);
  }

  void countNo() {
    setState(() {
      counter++;
      setCounterValue();
    });
  }

  @override
  void initState() {
    super.initState();
    checkForCounterValue();
  }

  Future<void> checkForCounterValue() async {
    counter = await getCounterValue();
    setState(() {}); // Refresh UI
  }

  void reset() async {
    setState(() {
      counter = 0;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('counterValue'); // Clear stored value
  }

  void decrease() {
    setState(() {
      counter--;
      setCounterValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Counter App"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$counter',
              style: TextStyle(fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: countNo,
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text("Increase"),
                ),
                ElevatedButton(onPressed: reset, child: const Text("Reset")),
                ElevatedButton(
                    onPressed: decrease, child: const Text("Decrease")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

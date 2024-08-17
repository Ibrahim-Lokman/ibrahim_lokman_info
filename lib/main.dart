import 'package:flutter/material.dart';
import 'package:ibrahim_lokman_info/screens/resume_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ibrahim Lokman Resume',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MenuPage(isDarkMode: _isDarkMode, toggleTheme: toggleTheme),

      //home: ResumeScreen(isDarkMode: _isDarkMode, toggleTheme: toggleTheme),
    );
  }
}

class MenuPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const MenuPage(
      {super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ibrahim Lokman'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wb_sunny,
                    color: widget.isDarkMode ? Colors.grey : Colors.orange),
                const SizedBox(width: 10),
                SizedBox(
                  width: 60,
                  height: 30,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Switch(
                      value: widget.isDarkMode,
                      onChanged: (_) => widget.toggleTheme(),
                      activeColor: Colors.blueGrey[700],
                      // activeThumbImage: AssetImage('assets/moon.png'),
                      // inactiveThumbImage: AssetImage('assets/sun.png'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.nightlight_round,
                  color: widget.isDarkMode ? Colors.blue : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              child: const Text('Resume'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResumeScreen(
                            isDarkMode: widget.isDarkMode,
                            // toggleTheme: widget.toggleTheme,
                          )),
                );
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text('Projects'),
              onPressed: () {
                // Navigate to Projects page (not implemented in this example)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    showCloseIcon: true,
                    content: Text('Projects page is coming soon!'),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

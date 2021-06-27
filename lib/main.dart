import 'package:bootcamp/views/country_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.yellow[700],
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);

class ThemeNotifier with ChangeNotifier {
  ThemeData? _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

//  getTheme() {
//    return _themeData;
//  }

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider(
          create: (_) => Counter(),
          child: MyApp(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(lightTheme),
          child: MyApp(),
        ),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: context.watch<ThemeNotifier>()._themeData,
      home: MyHomePage(title: 'Session 01'),
    );
  }
}

class Counter with ChangeNotifier {
  int count = 0;

  increment() {
    count++;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController textController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeData = context.watch<ThemeNotifier>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Switch(
            value: themeData._themeData == darkTheme,
            onChanged: (value) {
              if (value) {
                themeData.setTheme(darkTheme);
              } else {
                themeData.setTheme(lightTheme);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            MyTextWidget(),
            ListTile(
              title: Text('Waleed'),
              subtitle: Text('waleed@gmail.com'),
              trailing: Icon(Icons.arrow_forward),
              leading: CircleAvatar(child: Icon(Icons.person)),
            ),
            Container(
              child: Image.asset('assets/Icon.png'),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<Counter>().increment();
              },
              child: Text('LOGIN'),
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Enter your name', labelText: 'Name'),
            ),
            Text('hello'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SecondScreen(
                name: textController.text,
                onPressed: () {
                  _incrementCounter();
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('${context.watch<Counter>().count}');
  }
}

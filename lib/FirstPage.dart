import 'package:flutter/material.dart';
import 'package:flutter_app/MainRoute.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _myHomePageTitle;

  void _incrementCounter() {
    print("_incrementCounter");
    setState(() {
      _counter++;
    });
  }

  void _decreasedCounter() {
    setState(() {
      _counter--;
    });
  }

  void _goToSecondPage() {
    Navigator.of(context).pushNamed('/second');
  }

  @override
  Widget build(BuildContext context) {
    _myHomePageTitle = widget.title;
    print("_MyHomePageState");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: routes.length + 1,
          itemBuilder: (context, index) {
            return createDrawer(index);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$_myHomePageTitle'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        FloatingActionButton(
          heroTag: null,
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
          elevation: 3.0,
          autofocus: true,
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: _decreasedCounter,
          tooltip: 'Increment',
          child: Icon(Icons.remove),
          backgroundColor: Colors.green,
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: _goToSecondPage,
          tooltip: 'Increment',
          child: Icon(Icons.arrow_circle_up_sharp),
          backgroundColor: Colors.black,
        ),
      ],
    );
  }

  Widget createDrawer(int index) {
    if (index == 0) {
      return DrawerHeader(
        child: Text('Tune Talk'),
        decoration: BoxDecoration(color: Colors.red),
      );
    }

    return ListTile(
      selectedTileColor: Colors.redAccent,
      title: Text('Index $index'),
      onTap: () {
        Navigator.of(context).pushNamed(routeList.elementAt(index - 1));
      },
    );
  }
}

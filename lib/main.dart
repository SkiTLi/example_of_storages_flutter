import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tms20les_local_storege/dog.dart';

void main() async {
  // Shared Preferences ----------------

  // WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  //
  // await prefs.setInt('my int', 1234);
  // final myInt = prefs.getInt('my int');
  // print(myInt);
  //
  // await prefs.setString('my String', 'my String');
  // final myString = prefs.getString('my String');
  // print(myString);
  //
  // print (prefs.containsKey('my String'));
  //
  // for (final key in prefs.getKeys()){
  //   print(prefs.get(key));
  // }
  // // await prefs.remove('my String');
  // // await prefs.clear();

  // flutter_secure_storage 8.0.0 ----------------
  //хранит данные в зашифрованном виде
  // но есть ограничния по sdk версии (тут 18)
  //нужно лезть в android в gradle
// недописал видеоурок 20 (второй час)

  // WidgetsFlutterBinding.ensureInitialized();
  // final storage = FlutterSecureStorage();
  // await storage.write(key: 'my value', value: '987654'); // only String
  // final value = await storage.read(key: 'my value');

  //path_provider: ^2.0.15 ------------------
  //дает возможности создавать папки которые будут видны только этому приложению
  // WidgetsFlutterBinding.ensureInitialized();
  // final directory = await getApplicationDocumentsDirectory(); // папка (но целый объект) в которорй документы хранятся постоянно
  // final String path = directory.path;
  // final file = File('$path/some_file.txt');
  // // await file.writeAsString('some content');
  //
  // final content = await file.readAsString();
  // file.writeAsBytes([]);//для записи других файлов
  // print (content);

  //sqflite: ^2.2.8+2 ------------------------------
  //записывает данные  исполььзуя sqllite
  //хранит данные в локальной базе данных
  WidgetsFlutterBinding.ensureInitialized();
  final databasePath = '${await getDatabasesPath()}/dog_database.db';

  final database = await openDatabase(
    databasePath,
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
    },
    version: 1, //нужно чтобы работали измененные колонки таблицы
    //т.к. есть метод onUpgrate()
  );

  //create a dog------
  // const dog = Dog(id: 1, name: "Fido", age: 2);
  // await database.insert('dogs', dog.toJson(),
  //     conflictAlgorithm: ConflictAlgorithm.replace);


  // update a dog ------
  // const dogToUpdate =Dog (id: 1, name: 'Fido', age: 13);
  // await database.update('dogs', dogToUpdate.toJson(), where: 'id = ?', whereArgs: [1] );


  //delete a dog ------
  // await database.delete('dogs',  where: 'id = ?', whereArgs: [1] );



  final dogs = await database.query('dogs');
  final dog = Dog.fromJson(dogs.first);
  print(dog);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MyDialog extends StatelessWidget {
  const MyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.blueAccent,
        child: Material(
          child: Column(
            children: [
              Text('shdfghsdfhds'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('no'))
            ],
          ),
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // void _incrementCounter() async {
  void _incrementCounter() {
    // setState(() {     _counter++;    });// original code

    //-----------------------------------------------------

    //examples of dialog window

    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text('Dialog title   Sometimes we cant get everything done! Well need to update the task to remember to get that milk tomorrow.            Well be sending another POST request to update the task. This time we add the id of the task to the url of the tasks endpoint: https:   We use the same headers for authorization and content-type. We also provide the optional request ID as we have in the previous steps.  This time well set the due_string property of the task to tomorrow in the JSON post body. The task will be automatically scheduled for tomorrows date. You can find more information on due dates in our Help Center.   The API will respond with status 204 to indicate that the request was successful.'),
    //         content: Text('Sometimes we cant get everything done! Well need to update the task to remember to get that milk tomorrow.            Well be sending another POST request to update the task. This time we add the id of the task to the url of the tasks endpoint: https:   We use the same headers for authorization and content-type. We also provide the optional request ID as we have in the previous steps.  This time well set the due_string property of the task to tomorrow in the JSON post body. The task will be automatically scheduled for tomorrows date. You can find more information on due dates in our Help Center.   The API will respond with status 204 to indicate that the request was successful.'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('Cancel'),
    //           ),
    //           ElevatedButton(onPressed: () {}, child: Text('ok'))
    //         ],
    //       );
    //     });

    //-----------------------------------------------------

    // final result = await showDialog(// по сути возвращает future
    //     context: context,
    //     builder: (context) => TimePickerDialog(
    //             initialTime: TimeOfDay(
    //           hour: 12,
    //           minute: 0,
    //         )));
    // print (result);

    //-------------------------------------------

    //  final date = showDialog(// по сути возвращает future
    //     context: context,
    //     builder: (context) => DatePickerDialog(
    //         initialDate: DateTime.now(),
    //           firstDate: DateTime(1000,1,1),
    //       lastDate: DateTime.now(),
    //         ));
    // print (date);

    //-------------------------------------------

    final res = showDialog(
        // по сути возвращает future
        context: context,
        builder: (context) => MyDialog());
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

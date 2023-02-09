import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_abdallahmansor/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_abdallahmansor/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy_abdallahmansor/modules/new_tasks/new_tasks_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex=0;
  List<Widget>screens=
      [
        NewTasksScreen(),
        DoneTasksScreen(),
        ArchivedTasksScreen(),
      ];
  List<String>titles=
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
   Database? database;
  @override
  void initState() {
    super.initState();

    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          titles[currentIndex],
        ),
      ),
      body:screens[currentIndex] ,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: () async {
          insertToDatabase();
        },
        child: Icon(
          Icons.add,
        ),

      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex=index;
            print(index);
          });

        },
        items: [
          BottomNavigationBarItem(
              icon:Icon(Icons.menu, color: Colors.purpleAccent,),
            label: 'Tasks',

          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.check, color: Colors.purpleAccent,),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.archive, color: Colors.purpleAccent,),
            label: 'Archive',
          ),

        ],
      ),
    );
  }

  Future<String>getName() async
  {
    return 'Ahmed ali';
  }

  Future<void> createDatabase()
  async {
     database= await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version)
      {
        print('database created');
        database.execute('CREATE TABLE TASKS(id INTEGER PRIMARY KEY,title TEXT,date TEXT, time TEXT, status TEXT,   )').then((value) {
          print('table is created');
        }).catchError((error){
          print('Error when creating table ${error.toString()}');
        });

      },
      onOpen: (database)
        {
          print('database opened');
        }
    );
     return null;

  }
  void insertToDatabase()
  {

    database?.transaction((txn)
    async {
      txn.rawInsert(
          'INSERT INTO tasks(tittle, date, time, status) VALUES ("first task","02356","565","new")'
      )
          .then((value) {
        print("$value is inserted successfully");
      }).catchError((error) {
        print('Error when inserting New record ${error.toString()}');
      });
    }
    );
  }
}


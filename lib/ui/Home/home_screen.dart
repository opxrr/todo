import 'package:flutter/material.dart';
import 'package:todo/ui/Home/add_task_bottom_sheet.dart';
import 'package:todo/ui/Home/settings/settings_tab.dart';
import 'package:todo/ui/Home/todos_list/todos_list_tab.dart';

class HomeScreen extends StatefulWidget {
 static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 int selectedIndex =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('TODO App',
        style: TextStyle(
          color: Colors.white
        ),),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(30)
        ),
        child: FloatingActionButton(
          shape: const StadiumBorder(
            side: BorderSide(color: Colors.white,width: 4)
          ),
          onPressed: (){
            showAddTaskSheet();
          },
          child: Icon(Icons.add) ,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:selectedIndex ,
        onTap: (index){
          setState(() {
            selectedIndex = index;

          });

        },
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list,size: 32,),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings,size: 32,),label: ''),
        ],
      ),
      body: tabs[selectedIndex],


    );
  }
  void showAddTaskSheet(){
    showModalBottomSheet(context: context, builder: (buildContext){
      return AddTaskBottomSheet();
    });
}

  var tabs = [
    TodosList(),
    SettingsTab()
  ];
}

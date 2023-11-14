import 'package:flutter/material.dart';
import 'package:todo/database/MyDateUtils.dart';
import 'package:todo/ui/compnents/custome_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Add New Task ',
                style: Theme.of(context).textTheme.headlineMedium,),
                CustomFormField(label: 'Task Title',
                    validator: (text){
                    if (text==null || text.trim().isEmpty){
                      return 'Please task title';
                    }
                    },
                    controller: titleController),
                CustomFormField(label: 'Task Description',
                    validator: (text){
                    if (text==null || text.trim().isEmpty){
                      return 'Please task description';
                    }
                    },
                    lines: 3,
                    controller: descriptionController),
                SizedBox(height: 12,),
                Text('Task Date'),

                InkWell(
                  onTap: (){
                    showTaskDatePicker();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black54
                        )
                      )
                    ),
                      child: Text('${MyDateUtils.formatTaskDate(selectedDate)}'),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),

                ElevatedButton(onPressed: (){
                  addTask();
                },
                    child: Text('Add Task',style: TextStyle(
                      color: Colors.white
                    ),
                    )
                )
              ],

            ),
          ),
        ),
      ),
    );
  }

  void addTask (){
    if(formKey.currentState?.validate()==false){
      return;
    }
  }
  var selectedDate = DateTime.now();

  void showTaskDatePicker()async{
   var date = await showDatePicker(context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
   if (date == null )return;
   selectedDate= date;
   setState(() {

   });
  }
}

import 'package:firebase_authentication_with_flutter/src/shared/custom_modal_action_button.dart';
import 'package:firebase_authentication_with_flutter/src/shared/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  final _textTaskController = TextEditingController();

  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().add(
          Duration(days: -365),
        ),
        lastDate: DateTime.now().add(
          Duration(days: 365),
        ));
    if (datepick != null)
      setState(() {
        _selectedDate = datepick;
      });
  }

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<Database>(context);
    _textTaskController.clear();
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              'Add new task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          CustomTextField(
            labelText: 'Enter task name',
            controller: _textTaskController,
          ),
          SizedBox(
            height: 24,
          ),
          CustomModalActionButton(
            onClose: () => Navigator.of(context).pop(),
            onSave: () {
              if (_textTaskController.text == '') {
                print('data not found');
              } else {
                // provider
                //     .insertTodoEntries(
                //       Todo(
                //         id: null,
                //         date: _selectedDate,
                //         time: DateTime.now(),
                //         isFinish: false,
                //         description: '',
                //         task: _textTaskController.text,
                //         todoType: TodoType.TYPE_TASK.index,
                //       ),
                //     )
                //     .whenComplete(
                //       () => Navigator.of(context).pop(),
                //     );
                print('insert task');
              }
            },
          ),
        ],
      ),
    );
  }
}

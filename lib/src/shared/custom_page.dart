import 'package:firebase_authentication_with_flutter/src/shared/add_task_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomPage extends StatefulWidget {
  final String title;
  final Color color;

  const CustomPage({Key key, this.title, this.color}) : super(key: key);

  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  var counter = 0;

  var textController = TextEditingController();
  var popUpTextController = TextEditingController();

  List<ListItem> WidgetList = [];

  @override
  void dispose() {
    textController.dispose();
    popUpTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        foregroundColor: Color(0xffffffff),
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: AddTaskPage(),
              );
            },
          );
        },
        tooltip: 'Thêm',
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: TextField(
              decoration: InputDecoration(hintText: "Enter Todo Text Here"),
              style: TextStyle(
                fontSize: 22.0,
                //color: Theme.of(context).accentColor,
              ),
              controller: textController,
              cursorWidth: 5.0,
              autocorrect: true,
              autofocus: true,
              //onSubmitted: ,
            ),
          ),
          RaisedButton(
            child: Text("Add Todo"),
            onPressed: () {
              if (textController.text.isNotEmpty) {
                WidgetList.add(new ListItem(textController.text, false));
                setState(() {
                  textController.clear();
                });
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("12 Tasks", style: TextStyle(color: Colors.grey)),
                SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(widget.title,
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold)),
                    Text('26%', style: TextStyle(fontSize: 16.0))
                  ],
                ),
                SizedBox(height: 12.0),
                LinearProgressIndicator(
                  value: 0.3,
                ),
              ],
            ),
          ),
          Expanded(
            child: ReorderableListView(
              children: <Widget>[
                for (final widget in WidgetList)
                  GestureDetector(
                    key: Key(widget.todoText),
                    child: Dismissible(
                      key: Key(widget.todoText),
                      child: CheckboxListTile(
                        //key: ValueKey("Checkboxtile $widget"),
                        value: widget.todoCheck,
                        title:
                            _strikeThrough(widget.todoText, widget.todoCheck),
                        onChanged: (checkValue) {
                          //_strikethrough toggle
                          setState(() {
                            if (!checkValue) {
                              widget.todoCheck = false;
                            } else {
                              widget.todoCheck = true;
                            }
                          });
                        },
                      ),
                      background: Container(
                        child: Icon(Icons.delete),
                        alignment: Alignment.centerRight,
                        color: Colors.orange[300],
                      ),
                      confirmDismiss: (dismissDirection) {
                        return showDialog(
                            //On Dismissing
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Delete Todo?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ), //OK Button
                                  FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ), //Cancel Button
                                ],
                              );
                            });
                      },
                      direction: DismissDirection.endToStart,
                      movementDuration: const Duration(milliseconds: 200),
                      onDismissed: (dismissDirection) {
                        //Delete Todo
                        WidgetList.remove(widget);
                        Fluttertoast.showToast(msg: "Todo Deleted!");
                      },
                    ),
                    onDoubleTap: () {
                      popUpTextController.text = widget.todoText;
                      //For Editing Todo
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Edit Todo"),
                            content: TextFormField(
                              controller: popUpTextController,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  setState(() {
                                    widget.todoText = popUpTextController.text;
                                  });
                                  Navigator.of(context).pop(true);
                                },
                              ), //OK Button
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ), //Cancel Button
                            ],
                          );
                        },
                      );
                    },
                  )
              ],
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  var replaceWiget = WidgetList.removeAt(oldIndex);
                  WidgetList.insert(newIndex, replaceWiget);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class ListItem {
  String todoText;
  bool todoCheck;
  ListItem(this.todoText, this.todoCheck);
}

class _strikeThrough extends StatelessWidget {
  final String todoText;
  final bool todoCheck;
  _strikeThrough(this.todoText, this.todoCheck) : super();

  Widget _widget() {
    if (todoCheck) {
      return Text(
        todoText,
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
          fontSize: 22.0,
          color: Colors.red[200],
        ),
      );
    } else {
      return Text(
        todoText,
        style: TextStyle(fontSize: 22.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _widget();
  }
}

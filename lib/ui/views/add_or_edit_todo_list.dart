import 'package:flutter/material.dart';
import 'package:todo_list_application/const_values/assets.dart';
import 'package:todo_list_application/const_values/colors.dart';
import 'package:todo_list_application/enums/appbar_state.dart';
import 'package:todo_list_application/services/database/database.dart';

class AddOrEditTodoList extends StatefulWidget {
  final AppBarState appBar;
  final String? todoListText;
  const AddOrEditTodoList({Key? key, required this.appBar, this.todoListText}) : super(key: key);

  @override
  State<AddOrEditTodoList> createState() => _AddOrEditTodoListState();
}

class _AddOrEditTodoListState extends State<AddOrEditTodoList> {
  TextEditingController? textEditingController;
  TodoListDatabase todoListDatabase = TodoListDatabase.db;

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.todoListText ?? '');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appBar == AppBarState.add ? 'Add New Task' : 'Edit Task',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: white,
            fontFamily: Assets.robotoRegular,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 1.0,
                color: black,
              ),
            ],
          ),
        ),
        backgroundColor: brandMainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              widget.appBar == AppBarState.add ? 'Task Name' : 'Edit Task',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textEditingController!,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: brandMainColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                highlightColor: transparent,
                splashColor: transparent,
                onTap: (){
                  todoListDatabase.insertTodoList(textEditingController!.text);
                },
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: brandMainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: white,
                          fontFamily: Assets.robotoRegular,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 1.0,
                              color: black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController!.dispose();
    super.dispose();
  }
}

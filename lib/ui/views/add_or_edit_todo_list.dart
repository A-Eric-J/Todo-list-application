import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/const_values/assets.dart';
import 'package:todo_list_application/const_values/colors.dart';
import 'package:todo_list_application/enums/appbar_state.dart';
import 'package:todo_list_application/locator.dart';
import 'package:todo_list_application/models/todo_list.dart';
import 'package:todo_list_application/providers/todo_list_provider.dart';
import 'package:todo_list_application/services/database/database.dart';
import 'package:todo_list_application/services/navigation_service.dart';

class AddOrEditTodoList extends StatefulWidget {
  final AppBarState appBar;
  final TodoList? todoList;
  const AddOrEditTodoList({Key? key, required this.appBar,  this.todoList}) : super(key: key);

  @override
  State<AddOrEditTodoList> createState() => _AddOrEditTodoListState();
}

class _AddOrEditTodoListState extends State<AddOrEditTodoList> {
  TextEditingController? textEditingController;
  TodoListDatabase todoListDatabase = TodoListDatabase.db;
  TodoListProvider? todoProvider;

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.todoList != null ? widget.todoList!.text : '');
    todoProvider = Provider.of<TodoListProvider>(context,listen: false);
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: black,
              ),
            ),
            const SizedBox(height: 10,),
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
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  highlightColor: transparent,
                  splashColor: transparent,
                  onTap: () async{
                    if(widget.appBar == AppBarState.add){
                      await todoListDatabase.insertTodoList(textEditingController!.text);
                    }
                    else{
                      await todoListDatabase.updateTodoCard(TodoList(id: widget.todoList!.id,text: textEditingController!.text,isChecked: widget.todoList!.isChecked));
                    }
                    var todoLists = await todoListDatabase.findAllTodoLists();
                    todoProvider!.setTodoList(todoLists);
                    locator<NavigationService>().goBack();
                  },
                  child: Container(
                    height: 61,
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

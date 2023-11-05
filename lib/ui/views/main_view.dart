import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/const_values/assets.dart';
import 'package:todo_list_application/const_values/colors.dart';
import 'package:todo_list_application/const_values/route_paths.dart';
import 'package:todo_list_application/enums/appbar_state.dart';
import 'package:todo_list_application/locator.dart';
import 'package:todo_list_application/models/todo_list.dart';
import 'package:todo_list_application/providers/todo_list_provider.dart';
import 'package:todo_list_application/services/database/database.dart';
import 'package:todo_list_application/services/navigation_service.dart';
import 'package:todo_list_application/ui/widgets/no_ads_widget.dart';
import 'package:todo_list_application/ui/widgets/profile_widget.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TodoListDatabase todoListDatabase = TodoListDatabase.db;
  TodoListProvider? todoListProvider;

  @override
  void initState() {
    todoListProvider = Provider.of(context,listen: false);


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      var todoLists = await todoListDatabase.findAllTodoLists();
      todoListProvider!.setTodoList(todoLists);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: brandMainColor,
        onPressed: () => locator<NavigationService>().navigateTo(RoutePaths.addOrEditTodoListPath,arguments: {'appbarState' : AppBarState.add}),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer<TodoListProvider>(
          builder: (context, todoListProvider ,child) {
            return Column(
              children: [
                const ProfileWidget(),
                const NoAdsWidget(),
                const SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                    itemCount: todoListProvider.todoLists.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4, // Add shadow to the card
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                             children: [
                               SizedBox(
                                 width: 160,
                                 height: 50,
                                 child: CheckboxListTile(
                                   contentPadding: const EdgeInsets.all(0),
                                   value: todoListProvider.todoLists[index].isChecked,
                                   onChanged: (bool? newValue) async{
                                     await todoListDatabase.updateTodoCard(TodoList(id: todoListProvider.todoLists[index].id,text: todoListProvider.todoLists[index].text,isChecked: newValue));
                                     var lists = await todoListDatabase.findAllTodoLists();
                                     todoListProvider.setTodoList(lists);
                                   },
                                   controlAffinity: ListTileControlAffinity
                                       .leading, //  <-- leading Checkbox
                                   activeColor: green,
                                   checkboxShape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(15)),
                                 ),
                               ),
                               Expanded(child: Text(todoListProvider.todoLists[index].text!,style:  TextStyle(fontSize: 16,color: todoListProvider.todoLists[index].isChecked ?? false ? checkedTextColor : blueFontColor_1,fontWeight: FontWeight.w500,fontFamily: Assets.robotoRegular,decoration: todoListProvider.todoLists[index].isChecked ?? false ? TextDecoration.lineThrough : TextDecoration.none),)),
                               Expanded(
                                 child: Align(
                                   alignment: Alignment.centerRight,
                                   child: InkWell(
                                     onTap: ()=> locator<NavigationService>().navigateTo(RoutePaths.addOrEditTodoListPath,arguments: {'appbarState' : AppBarState.edit,'todoList' : todoListProvider.todoLists[index]}),
                                     child: Container(
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(6),
                                         border: Border.all(
                                           color: brandMainColor,
                                           width: 1
                                         )
                                       ),
                                       child: const Padding(
                                         padding: EdgeInsets.all(10),
                                         child: Text('Edit',style: TextStyle(fontSize: 16,color: blueFontColor_1,fontWeight: FontWeight.w500,fontFamily: Assets.robotoRegular,),),
                                       ),
                                     ),
                                   ),
                                 ),
                               )
                             ],
                           ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}


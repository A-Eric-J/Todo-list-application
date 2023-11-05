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
                Container(
                  color: brandMainColor,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          Assets.profile,
                          width: 50.0,
                          height: 50.0,
                        ),
                      ),
                      const SizedBox(width: 14,),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hello, Amirali',style: TextStyle(fontSize: 16,color: white,fontWeight: FontWeight.w500,fontFamily: Assets.robotoRegular),),
                            Text('What are your plans for today?',style: TextStyle(fontSize: 25,color: white,fontWeight: FontWeight.w100,fontStyle: FontStyle.italic),),

                          ],
                        ),
                      )

                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [lemon_1, lemon_2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),),
                  padding: const EdgeInsets.only(bottom: 30,right: 20,left: 20),
                  child:
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Image.asset(Assets.cup,width: 53,height: 41,),
                              const SizedBox(width: 14,),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Go Pro (No Ads)',style: TextStyle(fontSize: 18,color: blueFontColor_1,fontWeight: FontWeight.w700,fontFamily: Assets.robotoRegular, shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 1.0,
                                        color: white,
                                      ),
                                    ],),),
                                    SizedBox(height: 4,),
                                    Text('No fuss, no ads, for only \$1 a month',style: TextStyle(fontSize: 12,color: blueFontColor_2,fontWeight: FontWeight.w400, shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 1.0,
                                        color: white,
                                      ),
                                    ],),),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: darkBlue,
                        height: 71,
                        width: 66,
                        child: const Center(child: Text('\$1',style: TextStyle(fontSize: 18,color: yellow,fontWeight: FontWeight.w500,fontFamily: Assets.robotoRegular,),)),
                      )
                    ],
                  )
                ),
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
                               Checkbox(
                                 value: todoListProvider.todoLists[index].isChecked,
                                 onChanged: (bool? newValue) async{
                                  await todoListDatabase.updateTodoCard(TodoList(id: todoListProvider.todoLists[index].id,text: todoListProvider.todoLists[index].text,isChecked: newValue));
                                  var lists = await todoListDatabase.findAllTodoLists();
                                  todoListProvider.setTodoList(lists);
                                 },
                               ),
                               Expanded(child: Text(todoListProvider.todoLists[index].text!,style: const TextStyle(fontSize: 16,color: blueFontColor_1,fontWeight: FontWeight.w500,fontFamily: Assets.robotoRegular,),)),
                               Expanded(
                                 child: Align(
                                   alignment: Alignment.centerRight,
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


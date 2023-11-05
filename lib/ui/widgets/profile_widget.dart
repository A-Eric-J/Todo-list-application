import 'package:flutter/material.dart';
import 'package:todo_list_application/const_values/assets.dart';
import 'package:todo_list_application/const_values/colors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

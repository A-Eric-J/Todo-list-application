import 'package:flutter/material.dart';
import 'package:todo_list_application/const_values/assets.dart';
import 'package:todo_list_application/const_values/colors.dart';

class NoAdsWidget extends StatelessWidget {
  const NoAdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

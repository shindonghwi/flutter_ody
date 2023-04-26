import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/CustomDraggableContainer.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';

import '../../../utils/Common.dart';
import 'widget/HomeAppBar.dart';
import 'dart:math';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final calendarMinHeight = getMediaQuery(context).size.height * 0.15;
    final mainContentTopMargin = getMediaQuery(context).size.height * 0.18;
    final calendarMaxHeight = getMediaQuery(context).size.height * 0.38;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: HomeAppBar(),
      body: Stack(
        children: [

          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: mainContentTopMargin),
              padding: EdgeInsets.only(bottom: 57),
              child: Column(
                children: [
                  Container(color: Colors.green, height: 280,),
                    Container(color: Colors.black, height: 280,),
                    Container(color: Colors.blue, height: 280,),
                    Container(color: Colors.orange, height: 280,)
                ],
              ),
            ),
          ),

          CustomDraggableContainer(
            child: Container(
              color: Colors.red,
            ),
            initialHeight: calendarMinHeight,
            minHeight: calendarMinHeight,
            maxHeight: calendarMaxHeight,
            onExpandCollapse: (isExpanded) {
              debugPrint('isExpanded: $isExpanded');
              // Handle expand/collapse state change
            },
          ),


        ],
      ),
    );
  }
}


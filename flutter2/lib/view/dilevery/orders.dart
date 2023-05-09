import 'package:flutter/material.dart';
import 'package:flutter2/view/dilevery/homedil.dart';
import 'package:flutter2/view/test.dart';
import 'package:flutter2/utils/globalColors.dart';
class orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,

        child:
        Scaffold(
          appBar: PreferredSize(
            // backgroundColor: globalcolors.besiccolor,
            preferredSize: Size.fromHeight(kToolbarHeight),
            // title: const Text(''),

            child: Container(
              color: globalcolors.besiccolor,
              child: TabBar(
                indicatorColor: globalcolors.textcolor,
                indicatorWeight: 6,
                labelColor: globalcolors.textcolor,
                tabs: [
                  Tab(
                    child: Text("orders"),
                    icon: Icon(Icons.checklist_rtl_sharp),
                  ),
                  Tab(
                    child: Text("track"),
                    icon: Icon(Icons.track_changes),
                  ),
                ],

              ),
            ),
          ),
          body: TabBarView(
            children: [
              dil(),
              MapScreen(),
            ],
          ),
        )

      // ]
    );
    // );
  }
}
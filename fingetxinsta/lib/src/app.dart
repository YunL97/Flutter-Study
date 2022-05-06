import 'package:fingetxinsta/components/image_data.dart';
import 'package:fingetxinsta/controller/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//class 내에서 나오는 controller 는 모두 bottomNavController 이라고 알려주는것
class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Obx(
          () => Scaffold(
            appBar: AppBar(),
            body: IndexedStack(
              index: controller.pageIndex.value,
              children: [
                Container(child: Center(child: Text('HOME'))),
                Container(child: Center(child: Text('SEARCH'))),
                Container(child: Center(child: Text('UPLOAD'))),
                Container(child: Center(child: Text('ACTIVITY'))),
                Container(child: Center(child: Text('MYPAGE'))),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.pageIndex.value,
              //controller.changeBottomNav 와 같음,왜같냐 이게
              onTap: (int index) {
                controller.changeBottomNav(index);
              },

              elevation: 0,
              items: [
                BottomNavigationBarItem(
                    icon: ImageData(IconsPath.homeOff),
                    activeIcon: ImageData(IconsPath.homeOn),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: ImageData(IconsPath.searchOff),
                    activeIcon: ImageData(IconsPath.searchOn),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: ImageData(IconsPath.uploadIcon), label: 'home'),
                BottomNavigationBarItem(
                    icon: ImageData(IconsPath.activeOff),
                    activeIcon: ImageData(IconsPath.activeOn),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        )),
                    label: 'home'),
              ],
            ),
          ),
        ),
        onWillPop: controller.willPopAction);
  }
}

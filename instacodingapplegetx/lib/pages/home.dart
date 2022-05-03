import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key , this.data,required this.addData}) : super(key: key);
  final data;
  final addData;



  //스크롤 관련 데이터들 바로바로 저장됨
  var scroll = ScrollController();

  //oninit로 바꾸기
  @override
  void initState() {
    // TODO: implement initState
    //scroll이 바뀔때마다 실행, listener은 필요 없어지면 제거하는것도 성능상 좋음
    //scroll에 addlistener이 옵저버 같은 역할인가?
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent){
        // print("같음");
        getMore();
      }
    });
  }

  //마지막 도착하면 이미지 나옴
  getMore() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var result2 = jsonDecode(result.body);
    addData(result2);
    print("aa");
  }

  @override
  Widget build(BuildContext context) {

    if (data.isNotEmpty) {
      return Container(
          child: ListView.builder(
            controller: scroll,
            itemCount: data.length,
            itemBuilder: (context, i) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image(image: AssetImage("assets/images/download.jpg"), fit: BoxFit.fitWidth),
                    data[i]['image'].runtimeType == String ? Image.network(data[i]['image']) : Image.file(data[i]['image']),
                    GestureDetector(
                      child: Text(data[i]['user']),
                      onTap: () {
                       Get.toNamed('/profile');
                      },
                    )
                    ,
                    Text(data[i]['likes'].toString()),
                    Text(data[i]['content'])
                  ]
              );
              print("a");
            },
          )
      );
    }else {
      return Text("로딩중");
    }
  }
}



class Store2 extends ChangeNotifier {

}




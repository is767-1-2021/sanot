import 'package:flutter/material.dart';
import 'model.dart';
import 'second_page.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double hight = 0;
  bool isExpand = false;

  List<Model> dataList = [
    Model(
        question: "How does WhatToEat work ?",
        answer: 'We random the food for you',
        isExpand: false,
        hight: 0),
    Model(
        question: "Can I order food through WhatToEat ?",
        answer: 'Now, this is not possible.',
        isExpand: false,
        hight: 0),
    Model(
        question: "Can I use app to find restaurants aboard ?",
        answer:
            'The team is in the process of developing a system to enable this function.',
        isExpand: false,
        hight: 0),
    Model(
        question: "How can I give a service recommendation ?",
        answer: 'You can send us a message at xxxx@whattoeat.com',
        isExpand: false,
        hight: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'FAQ',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            //สร้าง widget แบบ dynamic ตาม list
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, int index) {
                  final Model item = dataList[index];
                  return Container(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            //เงื่อนไขการ
                            setState(() {
                              if (item.isExpand != null) {
                                item.isExpand = !item.isExpand!;
                                //ถ้าต้องการ fix ค่าความสูงของคำตอบให้เอาคอมเม้นข้างล่างออก แล้วใส่
                                // if (item.isExpand!) {
                                //   item.hight = 200;
                                // } else {
                                //   item.hight = 0;
                                // }
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Question
                                Text(
                                  "${item.question}",
                                  style: TextStyle(fontSize: 16),
                                ),

                                // Check condition icon: true arrow up, false arrow down
                                Icon(item.isExpand!
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        // Answer
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          //เช็คความสูงถ้า isExpand เท่ากับ true ไม่ต้องส่งค่าความสูงเนื่องจากความสูงจะขยายตาม child เอง
                          //ถ้า isExpand == false ให้ส่งค่า 0 เพื่อนซ่อน คำตอบ
                          height: item.isExpand!
                              ? null
                              : 0, //ถ้าต้องการ Fix ความสูงใส่ item.hight แทน item.isExpand! ? null : 0
                          width: double.infinity,
                          color: Colors.blue[50],
                          child: Text('${item.answer}'),
                        ),
                      ],
                    ),
                  );
                }),
            //Widget Press to Next Page
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondPage()));
              },
              child: Text('Next Page'),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

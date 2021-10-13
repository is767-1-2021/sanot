import 'package:flutter/material.dart';
import 'model.dart';
import 'second_page.dart';
import 'home_page.dart';

class Thirdpage extends StatefulWidget {
  @override
  _ThirdpageState createState() => _ThirdpageState();
}

class _ThirdpageState extends State<Thirdpage> {
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'FAQ',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
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
                            setState(() {
                              if (item.isExpand != null) {
                                item.isExpand = !item.isExpand!;
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Question

                                Expanded(
                                  child: Text(
                                    "${item.question}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),

                                Icon(item.isExpand!
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          height: item.isExpand! ? null : 0,
                          width: double.infinity,
                          color: Colors.blue[50],
                          child: Text('${item.answer}'),
                        ),
                      ],
                    ),
                  );
                }),
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

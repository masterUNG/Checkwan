import 'package:checkwan/Model/know.dart';
import 'package:checkwan/animation/FadeAnimation.dart';
import 'package:checkwan/knowledge/knowledge1.dart';
import 'package:checkwan/knowledge/knowledge_2.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Knowledge extends StatefulWidget {
  const Knowledge({Key? key}) : super(key: key);

  @override
  _KnowledgeState createState() => _KnowledgeState();
}

class _KnowledgeState extends State<Knowledge> {
  List<Learning> learning = [
    Learning(
        'สมุนไพร', 'https://cdn-icons-png.flaticon.com/512/3057/3057455.png'),
    Learning(
        'อาหาร', 'https://cdn-icons-png.flaticon.com/512/1999/1999722.png'),
    Learning(
        'อาการ', 'https://cdn-icons-png.flaticon.com/512/4190/4190712.png'),
    Learning(
        'วิธีดูแล', 'https://cdn-icons-png.flaticon.com/512/4713/4713482.png'),
    Learning('อาการข้างเคียง \n     จากโควิด',
        'https://cdn-icons-png.flaticon.com/512/2659/2659980.png'),
    Learning(
        'อื่นๆ', 'https://cdn-icons-png.flaticon.com/512/2471/2471152.png'),
  ];

  int selectedService = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: FadeAnimation(
                1.2,
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 70, 20, 0),
                  child: Text(
                    'สาระน่ารู้เกี่ยวกับโรคเบาหวาน \nภัยใกล้ตัวที่คุณมองข้าม',
                    style: GoogleFonts.prompt(
                      fontSize: 23,
                      color: Colors.grey.shade900,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: learning.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FadeAnimation(
                          (1.0 + index) / 4,
                          serviceContainer(learning[index].imageURL,
                              learning[index].name, index));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
        if (name == 'สมุนไพร') {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Knowledge1();
          }));
        }
        if (name == 'อาหาร') {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return Knowledge2();
          // }));
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Knowledge2();
          }));
        }
        if (name == 'อาการ') {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return Knowledge3();
          // }));
        }
        if (name == 'วิธีดูแล') {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return Knowledge5();
          // }));
        }
        if (name == 'อาการข้างเคียง \n     จากโควิด') {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return Knowledge6();
          // }));
        }
        if (name == 'อื่นๆ') {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return Knowledge7();
          // }));
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selectedService == index
              ? Colors.blue.shade50
              : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index
                ? Colors.blue
                : Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(image, height: 70),
            SizedBox(
              height: 12,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

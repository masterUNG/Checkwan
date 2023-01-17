import 'package:checkwan/Model/food_model.dart';
import 'package:checkwan/screen/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class ProcessScreen extends StatefulWidget {
  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  DateTime chooseDateTime = DateTime.now();
  var user = FirebaseAuth.instance.currentUser;

  var foodModels = <FoodModel>[];
  var filterFoodModels = <FoodModel>[];
  bool load = true;
  bool? haveData;

  @override
  void initState() {
    super.initState();
    readFoodData();
  }

  Future<void> readFoodData() async {
    await FirebaseFirestore.instance
        .collection('food')
        .where('uid', isEqualTo: user!.uid)
        .get()
        .then((value) {
      load = false;

      if (value.docs.isEmpty) {
        haveData = false;
      } else {
        haveData = true;

        for (var element in value.docs) {
          FoodModel foodModel = FoodModel.fromMap(element.data());
          foodModels.add(foodModel);
        }
      }
      createContent();
      setState(() {});
    });
  }

  void createContent() {
    if (filterFoodModels.isNotEmpty) {
      filterFoodModels.clear();
    }

    chooseDateTime = DateTime(chooseDateTime.year, chooseDateTime.month,
        chooseDateTime.day, 0, 0, 0, 0, 0);
    for (var element in foodModels) {
      DateTime foodDatetime = element.timestampFood.toDate();
      foodDatetime = DateTime(foodDatetime.year, foodDatetime.month,
          foodDatetime.day, 0, 0, 0, 0, 0);

      print(
          '##17jan chooseDateTime -> $chooseDateTime, foodDatetime -> $foodDatetime');

      var result = chooseDateTime.compareTo(foodDatetime);
      print('##17jan result ----> $result');

      if (result == 0) {
        filterFoodModels.add(element);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สรุปผลรายวัน",
            style: GoogleFonts.prompt(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        leading: const SizedBox(),
      ),
      body: Column(
        children: [
          showDate(),
          load
              ? Center(child: CircularProgressIndicator())
              : haveData!
                  ? filterFoodModels.isEmpty
                      ? Text('ไม่มีรายการ อาหาร')
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: filterFoodModels.length,
                          itemBuilder: (context, index) => Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      filterFoodModels[index].urlImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(filterFoodModels[index].timeFood, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                                      Text(filterFoodModels[index].nameFood),
                                      Text(filterFoodModels[index].detailFood),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                  : Text('ไม่มีรายการ อาหาร'),
        ],
      ),
    );
  }

  DatePicker showDate() {
    return DatePicker(
      DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 4),
      initialSelectedDate: chooseDateTime,
      selectionColor: Colors.orange,
      onDateChange: (selectedDate) {
        chooseDateTime = selectedDate;
        createContent();
        // setState(() {});
      },
    );
  }
}

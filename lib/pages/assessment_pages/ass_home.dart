import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:ohsa/models/assessment_model.dart';
import 'package:ohsa/models/room_model.dart';
import 'package:ohsa/services/room_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_home.dart';
import 'ass_one.dart';

class AssPageHome extends StatefulWidget {
  const AssPageHome({super.key});

  @override
  State<AssPageHome> createState() => _AssPageHomeState();
}

class _AssPageHomeState extends State<AssPageHome> {
  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final RoomService _roomService = RoomService();
  late AssessmentModel assessmentResult;

  TextEditingController assessmentDate = TextEditingController(
      text: DateFormat('d-MMM-y H:mm:ss').format(DateTime.now()).toString());

  final List<ListItem> _roomDropdownItems = [];
  List<DropdownMenuItem<ListItem>>? _roomDropdownMenuItems;
  ListItem? _roomSelectedItem;

  @override
  void initState() {
    super.initState();
    pageInitialization();
  }

  List<DropdownMenuItem<ListItem>>? buildDropdownMenuItem(
      List<ListItem> dropdownItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem item in dropdownItems) {
      items.add(
        DropdownMenuItem(
          value: item,
          child: Text(item.name),
        ),
      );
    }
    return items;
  }

  void pageInitialization() async {
    // get room no from Room collection
    var rooms = await _roomService.getRoom();

    for (var element in rooms.docs) {
      var room = RoomModel.fromJson(element.data() as Map<String, dynamic>);
      _roomDropdownItems.add(ListItem(
          FirebaseFirestore.instance.collection("Rooms").doc(element.id),
          room.room));
    }
    setState(() {
      _roomDropdownMenuItems = buildDropdownMenuItem(_roomDropdownItems);
      _roomSelectedItem = _roomDropdownMenuItems![0].value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'ประเมินห้องปฏิบัติการ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserHomePage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.home,
                color: Colors.black,
              ))
        ],
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 24),
                  LinearProgressBar(
                    maxSteps: 10,
                    progressType:
                        LinearProgressBar.progressTypeDots, // Use Dots progress
                    currentStep: 0,
                    progressColor: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).disabledColor,
                    dotsAxis: Axis.horizontal, // OR Axis.vertical
                    dotsActiveSize: 10,
                    dotsInactiveSize: 10,
                    dotsSpacing: EdgeInsets.only(right: 10),
                  ),
                  const SizedBox(height: 24),
                  buildAssessmentDate(context),
                  const SizedBox(height: 24),
                  const Text("ห้องปฏิบัติการที่ประเมิน"),
                  createDropdown(_roomSelectedItem, _roomDropdownMenuItems),
                  const SizedBox(height: 24),
                  nextBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAssessmentDate(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          controller: assessmentDate,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: "วันที่ทำประเมิน",
            floatingLabelStyle: TextStyle(fontSize: 18),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: UnderlineInputBorder(),
            contentPadding: EdgeInsets.all(20),
          ),
        ),
      ),
    );
  }

  Widget createDropdown(ListItem? selectedItem,
      List<DropdownMenuItem<ListItem>>? dropdownMenuItems) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 238, 233),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          value: selectedItem,
          items: dropdownMenuItems,
          onChanged: (value) {
            print(value!.docid);
            setState(() {
              selectedItem = value;
            });
          },
        ),
      ),
    );
  }

  Widget nextBtn() {
    return Center(
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.3,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            )),
          ),
          onPressed: () {
            // prepare variable
            // send AssessmentModel variable
            assessmentResult = AssessmentModel(
              uid: FirebaseAuth.instance.currentUser!.uid,
              assessmentDate: DateTime.now(),
              room: _roomSelectedItem!.docid,
              avgScore: 0.0,
              results: [],
            );
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AssPageOne(assessment: assessmentResult),
                ));
          },
          child: const Text('หน้าถัดไป'),
        ),
      ),
    );
  }
}

class ListItem {
  DocumentReference docid;
  String name;

  ListItem(this.docid, this.name);
}

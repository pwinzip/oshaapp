import 'package:flutter/material.dart';

import '../user_home.dart';
import '../assessment_pages/ass_home.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key});

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 8),
                logo(),
                const SizedBox(height: 8),
                description(),
                const SizedBox(height: 16),
                confirmBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Image.asset(
        "assets/images/logo.png",
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget description() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Column(
        children: const [
          Text(
            "แบบประเมินชุดนี้เป็นส่วนหนึ่งของโครงการวิจัยเรื่องแอปพลิเคชันการประเมินทางด้าน"
            "อาชีวอนามัยและความปลอดภัยสำหรับห้องปฏิบัติการเคมีในมหาวิทยาลัยทักษิณ วิทยาเขตพัทลุง",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12),
          Text(
            "จัดทำขึ้นเพื่อตรวจสอบว่าห้องปฏิบัติการทางเคมีนี้ได้ประเมินผ่านแอปพลิเคชันแล้วเป็นไปตาม"
            "กฎหมายและมาตรฐานที่เกี่ยวข้องหรือไม่ อยู่ในระดับใด",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12),
          Text(
            "ข้อมูลนี้จะถือเป็นความลับไม่เปิดเผยต่อบุคคลอื่นโดยจะนำเสนอผลการศึกษาในภาพรวม "
            "การดำเนินงานวิจัยจะไม่มีผลกระทบใด ๆ แก่ผู้ทำแบบประเมินผู้วิจัยจึงขอความกรุณา"
            "จากท่านช่วยตอบแบบประเมินใช้ครบถ้วนทุกข้อตามความเป็นจริง",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget confirmBtn() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          )),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AssPageHome(),
            ),
          );
        },
        child: const Text('ยืนยัน'),
      ),
    );
  }
}

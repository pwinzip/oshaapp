import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  bool isConsent = false;

  final List<ListItem> _prefixDropdownItems = [
    ListItem(0, "นาย"),
    ListItem(1, "นาง"),
    ListItem(2, "นางสาว"),
  ];

  final List<ListItem> _userTypeDropdownItems = [
    ListItem(0, "นิสิต"),
    ListItem(1, "อาจารย์"),
    ListItem(2, "บุคคลากร"),
  ];

  List<DropdownMenuItem<ListItem>>? _prefixDropdownMenuItems;
  List<DropdownMenuItem<ListItem>>? _userTypeDropdownMenuItems;
  ListItem? _prefixSelectedItem;
  ListItem? _userTypeSelectedItem;

  List<DropdownMenuItem<ListItem>> buildDropdownMenuItem(
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

  @override
  void initState() {
    super.initState();
    _prefixDropdownMenuItems = buildDropdownMenuItem(_prefixDropdownItems);
    _prefixSelectedItem = _prefixDropdownMenuItems![0].value;

    _userTypeDropdownMenuItems = buildDropdownMenuItem(_userTypeDropdownItems);
    _userTypeSelectedItem = _userTypeDropdownMenuItems![0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "สมัครสมาชิก",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        // toolbarHeight: MediaQuery.of(context).size.height * 0.15,
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    profileAvatar(),
                    labelTitle(title: "ข้อมูลทั่วไป"),
                    createDropdown(
                        _prefixSelectedItem, _prefixDropdownMenuItems),
                    commonTextField("ชื่อ", firstnameController, false),
                    commonTextField("นามสกุล", lastnameController, false),
                    commonTextField("เบอร์โทรศัพท์", telController, true),
                    labelTitle(title: "ข้อมูลบัญชี"),
                    accountTextField("E-mail", emailController, false),
                    accountTextField("รหัสผ่าน", passController, true),
                    const Text(
                      "ประเภทผู้ใช้งาน",
                      style: TextStyle(fontSize: 16),
                    ),
                    createDropdown(
                        _userTypeSelectedItem, _userTypeDropdownMenuItems),
                    consentCheckbox(),
                    registBtn(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget profileAvatar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CircleAvatar(
        backgroundColor: Colors.grey[500],
        radius: 70,
        child: const CircleAvatar(
          backgroundColor: Color(0xFF41D207),
          radius: 60,
          backgroundImage: AssetImage("assets/images/profile.png"),
        ),
      ),
    );
  }

  Widget labelTitle({required String title}) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(
        title,
        // textAlign: TextAlign.center,
        style: const TextStyle(
            fontFamily: 'Open Sans',
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20),
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
            setState(() {
              selectedItem = value;
            });
          },
        ),
      ),
    );
  }

  Widget commonTextField(
      String str, TextEditingController controller, bool isPhone) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 238, 233),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          hintText: str,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget accountTextField(
      String str, TextEditingController controller, bool isPassword) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 238, 233),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isPassword
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: str,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget consentCheckbox() {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: CheckboxListTile(
        title: const Text(
            "ยินยอมให้นำข้อมูลไปใช้ประโยชน์เฉพาะทางการวิจัยของนิสิต TSU"),
        value: isConsent,
        onChanged: (value) {
          setState(() {
            isConsent = value!;
          });
        },
      ),
    );
  }

  Widget registBtn() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFF285814)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          )),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            User? user = await AuthService.signUpWithEmail(
                name: firstnameController.text,
                email: emailController.text,
                password:
                    passController.text); // add prefix, lastname, tel, type

            if (!mounted) return;
            if (user != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            }
          }
        },
        child: const Text('สมัครสมาชิก'),
      ),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

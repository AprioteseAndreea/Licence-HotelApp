import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:first_app_flutter/models/staff_model.dart';
import 'package:first_app_flutter/screens/homeScreens/staff_home_screen.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:first_app_flutter/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffProfile extends StatefulWidget {
  const StaffProfile({Key? key}) : super(key: key);
  @override
  _StaffProfile createState() => _StaffProfile();
}

class _StaffProfile extends State<StaffProfile> {
  String? email, name, role, gender, old, phoneNumber, position, salary;
  late UserService userService;

  final _formkey = GlobalKey<FormState>();
  late TextEditingController _staffNameController = TextEditingController();
  late TextEditingController _staffPhoneController = TextEditingController();
  late TextEditingController _staffEmailController = TextEditingController();
  late TextEditingController _staffSalaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _readStaffData();
    });
  }

  Future<void> _readStaffData() async {
    final _prefs = await SharedPreferences.getInstance();

    final _email = _prefs.getString('email');
    final _role = _prefs.getString('role');
    final _gender = _prefs.getString('gender');
    final _name = _prefs.getString('name');
    final _old = _prefs.getString('old');
    final _phone = _prefs.getString('phoneNumber');
    final _position = _prefs.getString('position');
    final _salary = _prefs.getString('salary');

    if (_email != null) {
      setState(() {
        email = _email;
      });
    }
    if (_role != null) {
      setState(() {
        role = _role;
      });
    }
    if (_gender != null) {
      setState(() {
        gender = _gender;
      });
    }
    if (_name != null) {
      setState(() {
        name = _name;
      });
    }
    if (_old != null) {
      setState(() {
        old = _old;
      });
    }
    if (_phone != null) {
      setState(() {
        phoneNumber = _phone;
      });
    }
    if (_position != null) {
      setState(() {
        position = _position;
      });
    }
    if (_salary != null) {
      setState(() {
        salary = _salary;
      });
    }
    _staffNameController = TextEditingController(text: name);
    _staffPhoneController = TextEditingController(text: phoneNumber);
    _staffEmailController = TextEditingController(text: email);
    _staffSalaryController = TextEditingController(text: salary);
  }

  void onGenderSelected(String genderKey) {
    setState(() {
      gender = genderKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    final userService = Provider.of<UserService>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(Strings.darkTurquoise), //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          Strings.myProfile,
          style: TextStyle(color: Color(Strings.darkTurquoise)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Form(
                  key: _formkey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: const Color(0xFFFFFFFF),
                        elevation: 10,
                        child: SizedBox(
                          width: mediaQuery.width * 0.9,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                      right: 10,
                                    ),
                                    child: Text(
                                      Strings.fullName,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(Strings.darkTurquoise),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _staffNameController,
                                        validator: (val) => val!.isNotEmpty
                                            ? null
                                            : Strings.errorFullName,
                                        decoration: InputDecoration(
                                            hintText: Strings.enterStaffsName,
                                            hintStyle:
                                                const TextStyle(fontSize: 15),
                                            prefixIcon: Container(
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color(
                                                      Strings.darkTurquoise),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Color(Strings
                                                          .darkTurquoise))),
                                              child: Icon(
                                                Icons.person,
                                                color: Color(Strings.orange),
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            )),
                                        onChanged: (value) {
                                          name = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 5,
                                      right: 10,
                                    ),
                                    child: Text(
                                      "E-mail",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(Strings.darkTurquoise),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        enabled: false,
                                        controller: _staffEmailController,
                                        decoration: InputDecoration(
                                            hintText: Strings.enterStaffsEmail,
                                            hintStyle:
                                                const TextStyle(fontSize: 15),
                                            prefixIcon: Container(
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color(
                                                      Strings.darkTurquoise),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Color(Strings
                                                          .darkTurquoise))),
                                              child: Icon(
                                                Icons.mail,
                                                color: Color(Strings.orange),
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 5,
                                      right: 10,
                                    ),
                                    child: Text(
                                      Strings.phoneNumber,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(Strings.darkTurquoise),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _staffPhoneController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        validator:
                                            FieldValidator.validatePhoneNumber,
                                        decoration: InputDecoration(
                                            hintText:
                                                Strings.enterStaffsPhoneNumber,
                                            hintStyle:
                                                const TextStyle(fontSize: 15),
                                            prefixIcon: Container(
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color(
                                                      Strings.darkTurquoise),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Color(Strings
                                                          .darkTurquoise))),
                                              child: Icon(
                                                Icons.phone,
                                                color: Color(Strings.orange),
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            )),
                                        onChanged: (value) {
                                          name = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 5,
                                      right: 10,
                                    ),
                                    child: Text(
                                      Strings.occupation,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(Strings.darkTurquoise),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10, bottom: 10),
                                child: ElevatedButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        position != null
                                            ? position!
                                            : 'not specified',
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF6d6d6d),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () => {},
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(Strings.darkTurquoise)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              side: const BorderSide(
                                                  color: Color(0xFF9a9b9c))))),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 5,
                                      right: 10,
                                    ),
                                    child: Text(
                                      Strings.salary,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(Strings.darkTurquoise),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        enabled: false,
                                        controller: _staffSalaryController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        validator: (val) => val!.isNotEmpty
                                            ? null
                                            : Strings.enterSalary,
                                        decoration: InputDecoration(
                                            hintText: Strings.enterSalary,
                                            hintStyle:
                                                const TextStyle(fontSize: 15),
                                            prefixIcon: Container(
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color(
                                                      Strings.darkTurquoise),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Color(Strings
                                                          .darkTurquoise))),
                                              child: Icon(
                                                Icons.euro,
                                                color: Color(Strings.orange),
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 5,
                                      right: 10,
                                    ),
                                    child: Text(
                                      Strings.gender,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(Strings.darkTurquoise),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              CupertinoRadioChoice(
                                choices: Strings.genderMap,
                                onChange: onGenderSelected,
                                initialKeyValue: gender,
                                selectedColor: Color(Strings.darkTurquoise),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      if (_formkey.currentState!.validate()) {
                                        Staff currentStaff = Staff(
                                          email: _staffEmailController.text,
                                          gender: gender!,
                                          name: _staffNameController.text,
                                          old: old!,
                                          phone: _staffPhoneController.text,
                                          position: position!,
                                          salary: int.parse(
                                              _staffSalaryController.text),
                                        );

                                        await userService.updateStaffInFirebase(
                                            currentStaff);

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const StaffHomeScreen(),
                                            ),
                                            ModalRoute.withName('/'));
                                      }
                                    },
                                    height: 40,
                                    minWidth: 150,
                                    color: Theme.of(context).primaryColor,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Text(
                                      'Update profile',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

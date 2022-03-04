import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:email_validator/email_validator.dart';
import 'package:first_app_flutter/models/gender.dart';
import 'package:first_app_flutter/models/staff_model.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/screens/user_screens/notifiers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({Key? key}) : super(key: key);
  @override
  _AddStaff createState() => _AddStaff();
}

class _AddStaff extends State<AddStaff> {
  List<Gender> genders = [];
  late TextEditingController _staffNameController = TextEditingController();
  late TextEditingController _staffEmailController = TextEditingController();
  late TextEditingController _staffPhoneController = TextEditingController();
  late TextEditingController _staffSalaryController = TextEditingController();
  List<String> occupations = [];
  String selectedOccupation = "";
  String name = "", date = "";
  final _formkey = GlobalKey<FormState>();

  AuthServices authServices = AuthServices();
  double rating = 5.0;
  static final Map<String, String> genderMap = {
    'male': 'Male',
    'female': 'Female'
  };

  String _selectedGender = genderMap.keys.first;
  @override
  void initState() {
    DateTime dateToday = DateTime.now();
    date = DateFormat('MMMM dd, yyyy').format(dateToday);
    genders.add(Gender("Male", Icons.male, true));
    genders.add(Gender("Female", Icons.female, false));
    _staffNameController = TextEditingController();
    _staffEmailController = TextEditingController();
    _staffPhoneController = TextEditingController();
    _staffSalaryController = TextEditingController();
    authServices.getCurrentUser().then((value) {
      setState(() {
        name = value!.displayName!;
      });
    });
    occupations.add("Chef");
    occupations.add("Manager");
    occupations.add("Receptionist");
    occupations.add("Room Service");
    occupations.add("Maid");

    super.initState();
  }

  @override
  void dispose() {
    _staffNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    final userService = Provider.of<UserService>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Add staff',
            style: TextStyle(color: Color(0xFF124559)),
          ),
          iconTheme: const IconThemeData(
            color: Color(0xFF124559),
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
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
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                      right: 10,
                                    ),
                                    child: Text(
                                      "Full name",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF124559),
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
                                            : "Please enter full name",
                                        decoration: InputDecoration(
                                            hintText: "Enter staff's name",
                                            hintStyle:
                                                const TextStyle(fontSize: 15),
                                            prefixIcon: Container(
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF124559),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: const Color(
                                                          0xFF124559))),
                                              child: const Icon(
                                                Icons.person,
                                                color: Color(0xFFF0972D),
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
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      top: 5,
                                      right: 10,
                                    ),
                                    child: Text(
                                      "E-mail",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF124559),
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
                                        controller: _staffEmailController,
                                        validator: (value) =>
                                            EmailValidator.validate(value)
                                                ? null
                                                : "Please enter a valid email",
                                        decoration: InputDecoration(
                                            hintText: "Enter staff's email",
                                            hintStyle:
                                                const TextStyle(fontSize: 15),
                                            prefixIcon: Container(
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF124559),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: const Color(
                                                          0xFF124559))),
                                              child: const Icon(
                                                Icons.mail,
                                                color: Color(0xFFF0972D),
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
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      top: 5,
                                      right: 10,
                                    ),
                                    child: Text(
                                      "Phone number",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF124559),
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
                                        validator: (val) => val!.length < 10
                                            ? "Phone number must be 10 characters."
                                            : null,
                                        decoration: InputDecoration(
                                            hintText:
                                                "Enter staff's phone number",
                                            hintStyle:
                                                const TextStyle(fontSize: 15),
                                            prefixIcon: Container(
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF124559),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: const Color(
                                                          0xFF124559))),
                                              child: const Icon(
                                                Icons.phone,
                                                color: Color(0xFFF0972D),
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
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      top: 5,
                                      right: 10,
                                    ),
                                    child: Text(
                                      "Occupation",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF124559),
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
                                    children: const [
                                      Text(
                                        'Choose...',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF6d6d6d),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () =>
                                      _showMultipleChoiceDialog(context),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color(0xFF124559)),
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
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      top: 5,
                                      right: 10,
                                    ),
                                    child: Text(
                                      "Salary",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF124559),
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
                                        controller: _staffSalaryController,
                                        keyboardType: TextInputType.number,
                                        validator: (val) => val!.isNotEmpty
                                            ? null
                                            : "Please enter occupation",
                                        decoration: InputDecoration(
                                            hintText:
                                                "Enter staff's occupation",
                                            hintStyle:
                                                const TextStyle(fontSize: 15),
                                            prefixIcon: Container(
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF124559),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: const Color(
                                                          0xFF124559))),
                                              child: const Icon(
                                                Icons.euro,
                                                color: Color(0xFFF0972D),
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
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      top: 5,
                                      right: 10,
                                    ),
                                    child: Text(
                                      "Gender",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF124559),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              CupertinoRadioChoice(
                                choices: genderMap,
                                onChange: onGenderSelected,
                                initialKeyValue: _selectedGender,
                                selectedColor: const Color(0xFF124559),
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
                                          gender: _selectedGender,
                                          name: _staffNameController.text,
                                          old: date,
                                          phone: _staffPhoneController.text,
                                          position: selectedOccupation,
                                          salary: int.parse(
                                              _staffSalaryController.text),
                                        );

                                        await userService
                                            .addStaffInFirebase(currentStaff);
                                        Navigator.pop(context);
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
                                      "ADD STAFF",
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
              ],
            ),
          ),
        ));
  }

  void onGenderSelected(String genderKey) {
    setState(() {
      _selectedGender = genderKey;
    });
  }

  _showMultipleChoiceDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        final _singleNotifiers = Provider.of<SingleNotifier>(context);
        return AlertDialog(
          title: const Text('Select the staff\'s occupation'),
          content: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: occupations
                      .map((e) => CheckboxListTile(
                            title: Text(e),
                            onChanged: (value) {
                              if (value != null) {
                                _singleNotifiers.updateOccupation(e);
                              }
                            },
                            value: _singleNotifiers.isHaveItem(e),
                          ))
                      .toList(),
                )),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                selectedOccupation = _singleNotifiers.currentCountry;
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

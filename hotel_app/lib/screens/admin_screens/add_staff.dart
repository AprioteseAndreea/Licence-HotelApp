import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:email_validator/email_validator.dart';
import 'package:first_app_flutter/models/staff_model.dart';
import 'package:first_app_flutter/models/user_model.dart';
import 'package:first_app_flutter/screens/admin_screens/staff_screen.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:first_app_flutter/screens/user_screens/notifiers.dart';
import 'package:first_app_flutter/utils/form_text_field_title.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:first_app_flutter/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddStaff extends StatefulWidget {
  final Staff staff;

  const AddStaff({Key? key, required this.staff}) : super(key: key);
  @override
  _AddStaff createState() => _AddStaff();
}

class _AddStaff extends State<AddStaff> {
  late TextEditingController _staffNameController = TextEditingController();
  late TextEditingController _staffEmailController = TextEditingController();
  late TextEditingController _staffPhoneController = TextEditingController();
  late TextEditingController _staffSalaryController = TextEditingController();

  String selectedOccupation = "", name = "", date = "";
  late String _selectedGender, occupation, pageTitle;

  final _formkey = GlobalKey<FormState>();

  AuthServices authServices = AuthServices();
  UserService userService = UserService();

  double rating = 5.0;

  @override
  void initState() {
    DateTime dateToday = DateTime.now();
    date = DateFormat('MMMM dd, yyyy').format(dateToday);
    _staffNameController = super.widget.staff.name == Strings.none
        ? TextEditingController()
        : TextEditingController(text: super.widget.staff.name);
    _staffEmailController = super.widget.staff.email == Strings.none
        ? TextEditingController()
        : TextEditingController(text: super.widget.staff.email);
    _staffPhoneController = super.widget.staff.phone == Strings.none
        ? TextEditingController()
        : TextEditingController(text: super.widget.staff.phone);
    _staffSalaryController = super.widget.staff.salary == 0
        ? TextEditingController()
        : TextEditingController(text: super.widget.staff.salary.toString());
    authServices.getCurrentUser().then((value) {
      setState(() {
        name = value!.displayName!;
      });
    });

    _selectedGender = super.widget.staff.gender == Strings.none
        ? Strings.genderMap.keys.first
        : super.widget.staff.gender;
    occupation = super.widget.staff.position == Strings.none
        ? Strings.choose
        : super.widget.staff.position;
    selectedOccupation = super.widget.staff.position == Strings.none
        ? Strings.choose
        : super.widget.staff.position;
    pageTitle = super.widget.staff.name == Strings.none
        ? Strings.addStaff
        : Strings.updateStaff;
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
          title: Text(
            pageTitle,
            style: TextStyle(color: Color(Strings.darkTurquoise)),
          ),
          iconTheme: IconThemeData(
            color: Color(Strings.darkTurquoise),
          ),
          backgroundColor: Colors.white,
          actions: [
            pageTitle != Strings.addStaff
                ? IconButton(
                    icon: const Icon(
                      CupertinoIcons.delete,
                      size: 25,
                    ),
                    onPressed: () => {
                      showAlertDialog(context),
                    },
                  )
                : const SizedBox(
                    width: 0,
                  )
          ],
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
                                TextFormFieldTitle(title: Strings.fullName),
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
                                                margin:
                                                    const EdgeInsets.all(10),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        Strings.darkTurquoise),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
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
                                TextFormFieldTitle(title: Strings.email),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _staffEmailController,
                                          validator: (value) =>
                                              FieldValidator.validateEmail(
                                                  value),
                                          decoration: InputDecoration(
                                              hintText:
                                                  Strings.enterStaffsEmail,
                                              hintStyle:
                                                  const TextStyle(fontSize: 15),
                                              prefixIcon: Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        Strings.darkTurquoise),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
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
                                          onChanged: (value) {
                                            name = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextFormFieldTitle(title: Strings.phoneNumber),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _staffPhoneController,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          validator: (val) => FieldValidator
                                              .validatePhoneNumber(val),
                                          decoration: InputDecoration(
                                              hintText: Strings
                                                  .enterStaffsPhoneNumber,
                                              hintStyle:
                                                  const TextStyle(fontSize: 15),
                                              prefixIcon: Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        Strings.darkTurquoise),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
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
                                TextFormFieldTitle(title: Strings.occupation),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10, bottom: 10),
                                  child: ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          occupation,
                                          style: const TextStyle(
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
                                TextFormFieldTitle(title: Strings.salary),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _staffSalaryController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          validator: (val) => val!.isNotEmpty
                                              ? null
                                              : Strings.enterSalary,
                                          decoration: InputDecoration(
                                              hintText: Strings.enterSalary,
                                              hintStyle:
                                                  const TextStyle(fontSize: 15),
                                              prefixIcon: Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        Strings.darkTurquoise),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
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
                                          onChanged: (value) {
                                            name = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextFormFieldTitle(title: Strings.gender),
                                CupertinoRadioChoice(
                                  choices: Strings.genderMap,
                                  onChange: onGenderSelected,
                                  initialKeyValue: _selectedGender,
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
                                            gender: _selectedGender,
                                            name: _staffNameController.text,
                                            old: date,
                                            phone: _staffPhoneController.text,
                                            position: selectedOccupation,
                                            salary: int.parse(
                                                _staffSalaryController.text),
                                          );

                                          User currentUser = User(
                                              email: _staffEmailController.text,
                                              gender: _selectedGender,
                                              name: _staffNameController.text,
                                              old: date,
                                              phoneNumber:
                                                  _staffPhoneController.text,
                                              role: "staff");
                                          if (pageTitle == Strings.addStaff) {
                                            await userService
                                                .addUserInFirebase(currentUser);
                                            await userService
                                                .addStaffInFirebase(
                                                    currentStaff);
                                            await authServices.register(
                                                _staffEmailController.text,
                                                "GrandHotelStaff123",
                                                _staffNameController.text,
                                                _staffPhoneController.text);
                                            //si creeaza cont in FirebaseAuthentication
                                          } else if (pageTitle ==
                                              Strings.updateStaff) {
                                            await userService
                                                .updateStaffInFirebase(
                                                    currentStaff);
                                          }

                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const StaffScreen(),
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
                                      child: Text(
                                        pageTitle,
                                        style: const TextStyle(
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
          title: Text(Strings.selectStaffsOccupation),
          content: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: Strings.staffsOccupations
                      .map((e) => CheckboxListTile(
                            title: Text(e),
                            onChanged: (value) {
                              if (value != null) {
                                _singleNotifiers.updateOccupation(e);
                                setState(() {
                                  occupation = e;
                                });
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
              child: Text(Strings.ok),
              onPressed: () {
                selectedOccupation = _singleNotifiers.currentCountry;
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(Strings.cancel),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: Text(Strings.ok),
      onPressed: () async {
        await userService.deleteStaffFromFirebase(super.widget.staff.email);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const StaffScreen(),
            ),
            ModalRoute.withName('/'));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Strings.deleteRoom),
      content:
          Text("Do you want to delete the staff ${super.widget.staff.name}?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

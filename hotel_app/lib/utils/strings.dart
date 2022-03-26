import 'package:first_app_flutter/models/gender.dart';
import 'package:flutter/material.dart';

class Strings {
  static String applicationTitle = "Grand Hotel";
  static String selectedFacilities = "Selected facilities";
  static String close = "CLOSE";
  static String approve = "APPROVE";
  static String bookingDetails = "Booking details";
  static String checkIn = "Check-in: ";
  static String checkOut = "Check-out: ";
  static String reservationDate = "Reservation date: ";
  static String guests = "Guests: ";
  static String otherDetails = "Other details: ";
  static String deleteReservationQuestion =
      "Do you want to delete this reservation?";
  static String cancelReservation = "Cancel reservation";
  static String yes = "YES";
  static String cancel = "Cancel";
  static String ok = "Ok";
  static String room = "ROOM";
  static String price = "Price";
  static String facilities = "Facilities";
  static String maxGuests = "Max guests";
  static String deleteRoom = "Delete room";
  static String addRoom = "Add new room";
  static String addStaff = "Add staff";
  static String updateStaff = "Update staff";
  static String staff = "Hotel Staff";
  static String maxGuestsSmall = "Max guests";
  static String roomDetails = "Room details";
  static String free = "free";
  static String email = "Email";
  static String register = "Register";
  static String password = "Password";
  static String rememberMe = "Remember me";
  static String forgotPassword = "Forgot Password ? ";
  static String fullName = "Full name";
  static String gender = "Gender";
  static String status = "Status";
  static String login = "Login";
  static String createAccountToContinue = "Create account to continue";
  static String alreadyHaveAnAccount = "Already have an account?";
  static String doYouHaveAnAccount = "Don't have an account?";
  static String selectStaffsOccupation = "Select the staff's occupation";
  static String errorFullName = "Please enter full name";
  static String errorEmail = "Please enter a valid email";
  static String errorEnterEmail = "Please enter a email address";
  static String enterMoreThanSixChars = "Enter more than 6 chars";
  static String enterStaffsName = "Enter staff's name";
  static String enterStaffsEmail = "Enter staff's email";
  static String enterStaffsOccupation = "Enter staff's occupation";
  static String enterStaffsPhoneNumber = "Enter staff's phone number";
  static String occupation = "Occupation";
  static String enterPhoneNumber = "Phone number must be 10 characters";
  static String enterOccupation = "Please enter occupation";
  static String enterSalary = "Please enter salary";
  static String adminMode = "ADMINISTRATOR PANNEL";
  static String choose = "Choose...";
  static String phoneNumber = "Phone number";
  static String priceSmall = "Price";
  static String updateRoom = "Update room";
  static String occupied = "occupied";
  static String roomsInformation =
      "Below you can see information about the room ";
  static String addRoomPageTitle = "Add a new room for your guests";
  static String welcomeBack = "Welcome back";
  static String modifyPriceForRoom = "Modify the price for room ";
  static String modifyMaxGuestsForRoom = "Modify max guests for room ";
  static String signInToContinue = "sign in to continue";
  static String roomsNumber = "Rooms' number";
  static String none = "none";
  static String salary = "Salary";
  static String noFeedbacks = "No feedbacks";
  static int darkTurquoise = 0xFF124559;
  static int orange = 0xFFF0972D;
  static const Color red = Color(0xFFFF0000);
  static const Color green = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFFF6E6E);
  static Map<String, String> genderMap = {'male': 'male', 'female': 'female'};
  static Map<String, String> statusMap = {
    'free': 'free',
    'occupied': 'occupied'
  };

  static List<String> staffsOccupations = [
    "Chef",
    "Manager",
    "Receptionist",
    "Room Service",
    "Maid",
    "Spa Manager",
    "Owner",
    "Kitchen Manager",
    "Room Service Server",
    "Valet",
  ];
}

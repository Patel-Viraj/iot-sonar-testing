import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'localization_en.dart';

class MyLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
      ].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) => _load(locale);

  static Future<Localization> _load(Locale locale) async {
    final String name =
        (locale.countryCode == null || locale.countryCode!.isEmpty)
            ? locale.languageCode
            : locale as String;

    final localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    return LocalizationEN();
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}

abstract class Localization {
  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  String get appName;
  String get comingSoon;
  //sing in
  String get signIn;
  String get enterCredentials;
  String get userNameCaps;
  String get email;
  String get password;
  String get login;
  String get or;
  String get msgEnterAddress;
  String get msgEnterValidAddress;
  String get emailVerificationSentSuccessfully;
  String get ok;
  String get rememberMe;
  String get forgotPassword;
  String get loginWithGoogle;
  String get loginWithApple;
  String get emailDoesNotExist;
  //reset password
  String get resetPassword;
  String get enterYourRegisterdEmailAddress;
  String get send;
  String get goBackTo;
  //dashboard
  String get dashboard;
  String get inventoryManagement;
  String get fenceBuilder;
  String get fenceBuilderSingle;
  String get markFance;
  String get startPolygon;
  String get markPolygonPoint;
  String get completePolygon;
  String get addPolygonDetails;
  String get next;
  String get selectPolygonType;
  String get selectColor;
  String get enterName;
  String get msgSelectPolygonType;
  String get msgSelectColor;
  String get msgEnterName;
  String get addDepartment;
  String get contactPerson;
  String get dealshipFancingDetails;
  String get name;
  String get color;
  String get polygon;
  String get startNewPolygon;
  String get addDepartmentDetails;
  String get enterDepartmentName;
  String get done;
  String get addFancing;
  String get fancingTester;
  String get finish;
  String get msgDeletePolyline;
  String get delete;
  String get cancel;
  String get reload;
  String get msgReload;
  String get msgOutsideFencing;
  String get msgInSideFencing;
  String get qRCode;
  String get rOSearch;
  String get unassignRO;
  String get assignBeacon;
  String get qRCodeWithMagnifyingGlass;
  String get detectBeacon;

  //ro-search
  String get enterTheROStockCustomer;
  String get rONumber;
  String get vehicleName;
  String get vINNumber;
  String get rOServiceDetails;
  String get rODetail;
  String get rOByUserName;
  String get rODateTime;
  String get beaconDetails;
  String get keyBeaconID;
  String get carBeaconID;
  String get vehicleDetails;
  String get manufacturerName;
  String get makerYear;
  String get model;
  String get colour;
  String get fuelType;
  String get currentMeterReading;
  String get lastServiceReading;
  String get firstName;
  String get lastName;
  String get emailID;
  String get mobileNumber;
  String get address;
  String get customerDetail;
  String get workDiary;
  String get serviceName;
  String get viewAssetLocation;
  String get quantity;
  String get supervisorRemark;
  String get clientComment;
  String get timeLine;
  String get totalHours;
  String get idealHours;
  String get workingHours;
  String get entry;
  String get start;
  String get hold;
  String get resume;
  String get stop;
  String get iDNumber;
  String get keyDetails;
  String get carDetails;
  String get assetLocation;
  String get assignCarBeacon;
  String get assignKeyBeacon;
  String get confirm;
  String getNo(String value);
  String get getBeaconMsg;
  String get unassignBeaconMsg;
  String get distance;
  String get activeLine;
  String get completed;
  String get onHold;
  String get inProgress;
  String get expartedTime;
  String get markDone;
  String get selectReason;
  String get selectHoldReason;
  String get startDirections;
  String get findCarKey;

  //inventory
  String get inventoryManagementSingle;
  String get scanQRCode;
  String get inventoryToShip;
  String get vendorDevice;
  String get qrDetails;
  String get beconDetail;
  String get vendorDetails;
  String get serialNumber;
  String get uuIdNumber;
  String get nearByYou;
  String get unassign;
  String get assign;
  String get bleBeaconDataNotFound;
  String get addInventory;
  String get selectProduct;
  String get msgSelectProduct;
  String get active;
  String get yourBLEBeaconDeviceActivated;
  String get listofAssignDevices;
  String get search;
  String get save;
  String get vendorList;
  String get skip;
  String get searchVendor;
  String beaconTitle(int value);
  String gateWayTitle(int value);
}

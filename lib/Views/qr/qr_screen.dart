// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:C4CARE/Provider/login.provider.dart';
import 'package:C4CARE/Utils/connectionstatus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Custom/texts.dart';
import '../../Provider/attendance_provider.dart';
import '../../values/values.dart';

class QrScreen extends StatefulWidget {
  final String action;

  const QrScreen({
    super.key,
    required this.action,
  });

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _isFlash = false;

  @override
  void initState() {
    super.initState();
    initNoInternetListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(color: AppColors.white, child: _buildQrView(context)),
        Positioned.fill(
          top: 70.0,
          left: 20,
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                child: const Icon(
                  Iconsax.arrow_left_1,
                  color: AppColors.white,
                ),
                backgroundColor: AppColors.white10.withOpacity(.03),
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: 80.0,
          child: Align(
              alignment: Alignment.topCenter,
              child: Texts.largeBold("Scan QR code", color: AppColors.white)),
        ),
        Positioned.fill(
          top: 110.0,
          child: Align(
              alignment: Alignment.topCenter,
              child: Texts.regularBold(
                  widget.action == "checkIn" ? "Clock In" : "Clock Out",
                  color: AppColors.hint)),
        ),
        Positioned.fill(
          bottom: 16.0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                controller.resumeCamera();
              },
              child: RawMaterialButton(
                constraints: BoxConstraints.tight(const Size(48, 48)),
                elevation: 0.0,
                onPressed: () {
                  controller.toggleFlash();
                  setState(() {
                    _isFlash = !_isFlash;
                  });
                },
                fillColor: AppColors.white,
                shape: const CircleBorder(
                  side: BorderSide.none,
                ),
                child: Icon(
                  _isFlash ? Icons.flash_on : Icons.flash_off,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width * 0.7;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 8,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    final positionProvider = Provider.of<LoginUser>(context, listen: false);
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      AttendanceProvider attendanceProvider =
          Provider.of(context, listen: false);
      bool hasLocationPermission = await checkLocationPermission();
      if (widget.action == 'checkIn') {
        if (hasLocationPermission &&
            positionProvider.currentposition?.latitude != null) {
          attendanceProvider.checkIn(
              scanData.code!,
              controller,
              positionProvider.currentposition!.latitude.toString(),
              positionProvider.currentposition!.longitude.toString());
        } else {
          controller.dispose();
          fetchPosition(context).whenComplete(() => controller.resumeCamera());
        }
      } else {
        if (hasLocationPermission &&
            positionProvider.currentposition?.latitude != null) {
          attendanceProvider.checkOut(
              scanData.code!,
              controller,
              positionProvider.currentposition!.latitude.toString(),
              positionProvider.currentposition!.longitude.toString());
        } else {
          controller.dispose();
          fetchPosition(context).whenComplete(() => controller.resumeCamera());
        }
      }
    });
  }

  Future<void> fetchPosition(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(msg: 'Location permission is required.');
      }
    } else if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Location permission is required.')
          .then((value) => Navigator.pop(context));
      // bool locationSettingsOpened = await Geolocator.openLocationSettings();
      // if (!locationSettingsOpened) {
      //   Fluttertoast.showToast(msg: 'Failed to open location settings.');
      // }
    } else {
      // Get the current position.
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Update the position provider.
      final positionProvider = Provider.of<LoginUser>(context, listen: false);
      positionProvider.currentposition = currentPosition;
    }
  }

  Future<bool> checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    var status = await Permission.location.status;
    if (serviceEnabled) {
      return true;
    } else if (status.isDenied ||
        status.isRestricted ||
        status.isPermanentlyDenied) {
      var result = await Permission.location.request();
      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

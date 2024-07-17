// ignore_for_file: prefer_const_constructors, avoid_print, constant_identifier_names

import 'package:C4CARE/Custom/avatar.dart';
import 'package:C4CARE/Custom/celevatedbutton.dart';
import 'package:C4CARE/Custom/custom_text.dart';
import 'package:C4CARE/Provider/login.provider.dart';
import 'package:C4CARE/Provider/profile.provider.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:C4CARE/Views/tab3/change_password.dart';
import 'package:C4CARE/Views/tab3/profile_template1.dart';
import 'package:C4CARE/Views/tab3/profile_template2.dart';
import 'package:C4CARE/components/profiletile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../Custom/slide_right_route.dart';
import '../../../Custom/texts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String email = "";
  String mobile = "";
  String versionName = "";

  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionName = "${packageInfo.version}(${packageInfo.buildNumber})";
    });
  }

  @override
  void initState() {
    setProfileData();
    getPackageInfo();
    Provider.of<ProfileProvider>(context, listen: false).getProData();
    super.initState();
  }

  Future<void> setProfileData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name")!;
      mobile = sharedPreferences.getString("mobile")!;
      email = sharedPreferences.getString("email")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginUser auth = Provider.of<LoginUser>(context);
    Size size = MediaQuery.of(context).size;
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      return SafeArea(
          child: Scaffold(
              backgroundColor: AppColors.white,
              body: Stack(children: [
                Container(
                    color: AppColors.white,
                    child:
                        ListView(physics: ClampingScrollPhysics(), children: [
                      Column(children: [
                        Stack(children: [
                          Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    AppColors.white,
                                    AppColors.primaryColor,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 25),
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.00, -1.00),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/logo.png',
                                          height: 50.0,
                                          fit: BoxFit.fitHeight,
                                          alignment: Alignment(0.00, 0.00),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Profile",
                                      style: GoogleFonts.lato(
                                        color: AppColors.black,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 16.0),
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            if (provider
                                                    .profileModel?.imageUrl !=
                                                null)
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                child: Image.network(
                                                  provider
                                                      .profileModel!.imageUrl!,
                                                  width: 75,
                                                  height: 95.0,
                                                  fit: BoxFit.fill,
                                                  alignment:
                                                      Alignment(0.00, 0.00),
                                                ),
                                              )
                                            else
                                              Avatar(size: 64.0),
                                            SizedBox(width: 12.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  customText(
                                                      text: name,
                                                      textSize: 19,
                                                      weight: FontWeight.bold,
                                                      id: 1),
                                                  Divider(),
                                                  customText(
                                                    text:
                                                        provider.profileModel !=
                                                                null
                                                            ? provider
                                                                .profileModel!
                                                                .employeeId!
                                                            : "",
                                                    id: 1,
                                                    textSize: 15,
                                                    weight: FontWeight.w600,
                                                    color: AppColors.black,
                                                  ),
                                                  customText(
                                                    text: provider.profileModel
                                                                ?.role?.name !=
                                                            null
                                                        ? provider.profileModel!
                                                            .role!.name!
                                                        : "",
                                                    id: 1,
                                                    textSize: 15,
                                                    color: AppColors.black,
                                                  ),
                                                  customText(
                                                    text: email,
                                                    id: 1,
                                                    textSize: 13,
                                                  ),
                                                  customText(
                                                      text: mobile,
                                                      textSize: 14,
                                                      id: 1),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: InkWell(
                                              onTap: () {
                                                if (kDebugMode) {
                                                  print(provider.profileModel
                                                      ?.role?.template?.name);
                                                }
                                                if (provider.profileModel?.role
                                                        ?.template?.name ==
                                                    "template_1") {
                                                  Navigator.push(
                                                      context,
                                                      SlideRightRoute(
                                                          page:
                                                              ProfileTemplate1(
                                                        profile: provider
                                                            .profileModel!,
                                                      )));
                                                } else if (provider
                                                        .profileModel
                                                        ?.role
                                                        ?.template
                                                        ?.name ==
                                                    "template_2") {
                                                  Navigator.push(
                                                      context,
                                                      SlideRightRoute(
                                                          page:
                                                              ProfileTemplate2(
                                                        profile: provider
                                                            .profileModel!,
                                                      )));
                                                } else {
                                                  Alerts.showError(
                                                      "An unexpected error occurred. Please try again later.");
                                                }
                                              },
                                              child: Icon(Iconsax.edit)),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                        SizedBox(height: 10),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 8, vertical: 3),
                        //   child: ProfileTile(
                        //       navigateto: () async {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => UpdateProfile()));
                        //       },
                        //       icon: Iconsax.user,
                        //       tiletext: "Profile"),
                        // ),

                        // : SizedBox(),

                        // : SizedBox(),
                        // widget.id == 1
                        //     ?

                        // : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          child: ProfileTile(
                              navigateto: () async {
                                const aboutus =
                                    "https://care4consulting.co.uk/about";
                                await canLaunchUrlString(aboutus)
                                    ? launchUrlString(aboutus)
                                    : print("error while opening aboutus");
                              },
                              icon: Iconsax.information,
                              tiletext: "About Us"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          child: ProfileTile(
                              navigateto: () async {
                                const terms =
                                    "https://care4consulting.co.uk/terms_and_conditions.html";
                                await canLaunchUrlString(terms)
                                    ? launchUrlString(terms)
                                    : print(
                                        "error while opening terms&condition");
                              },
                              icon: Iconsax.global,
                              tiletext: "Terms & Conditions"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          child: ProfileTile(
                              navigateto: () async {
                                const Policy =
                                    "https://care4consulting.co.uk/privacy_policy.html";
                                await canLaunchUrlString(Policy)
                                    ? launchUrlString(Policy)
                                    : print("error while opening Policy");
                              },
                              icon: Iconsax.lock,
                              tiletext: "Privacy Policy"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          child: ProfileTile(
                              navigateto: () async {
                                Navigator.push(context,
                                    SlideRightRoute(page: const ChangePwd()));
                              },
                              icon: Iconsax.verify,
                              tiletext: "Change Password"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          child: ProfileTile(
                              navigateto: () async {
                                const aboutus =
                                    "https://care4consulting.co.uk/contact";
                                await canLaunchUrlString(aboutus)
                                    ? launchUrlString(aboutus)
                                    : print("error while opening aboutus");
                              },
                              icon: Iconsax.call,
                              tiletext: "Contact Us"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          child: ProfileTile(
                              color: Colors.red,
                              navigateto: () {
                                logout(auth);
                              },
                              icon: Iconsax.logout,
                              tiletext: "Log Out"),
                        ),
                        SizedBox(height: 24.0),
                        Center(
                            child: Texts.thin("V$versionName",
                                color: Colors.black38)),
                      ])
                    ])),
              ])));
    });
  }

  Future<void> logout(LoginUser auth) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0))),
        context: context,
        builder: (context) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0)),
                color: AppColors.white10,
              ),
              height: 240,
              child: Column(
                children: [
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    color: AppColors.white10,
                    height: 45.0,
                    width: size.width,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Confirm Logout",
                            style: GoogleFonts.poppins(
                                color: AppColors.hint,
                                fontSize: Sizes.TEXT_SIZE_22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Are you sure you want to logout?",
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.poppins(
                                color: AppColors.black,
                                fontSize: Sizes.TEXT_SIZE_18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CElevatedButton(
                              onpressed: () {
                                Navigator.pop(context);
                              },
                              color: AppColors.white,
                              size: Size(170, 50),
                              text: Text(
                                "Cancel",
                                style: GoogleFonts.poppins(
                                    color: AppColors.primaryDarkColor,
                                    fontSize: Sizes.TEXT_SIZE_22),
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CElevatedButton(
                              onpressed: () {
                                auth.logout();
                              },
                              color: AppColors.primaryDarkColor,
                              size: Size(0, 50),
                              text: Text(
                                "Logout",
                                style: GoogleFonts.poppins(
                                    color: AppColors.white,
                                    fontSize: Sizes.TEXT_SIZE_22),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}

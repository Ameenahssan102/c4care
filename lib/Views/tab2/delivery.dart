// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:C4CARE/Custom/celevatedbutton.dart';
// import 'package:C4CARE/Custom/ctestformfield.dart';
// import 'package:C4CARE/Custom/ctext.dart';
// import 'package:C4CARE/Model/deliverymodel.dart';
// import 'package:C4CARE/Provider/purchaseprovider.dart';
// import 'package:C4CARE/Provider/store.provider.dart';
// import 'package:C4CARE/Values/values.dart';
// import 'package:empty_widget/empty_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:getwidget/components/checkbox/gf_checkbox.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:intl/intl.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class Delivery extends StatefulWidget {
//   final int id;
//   const Delivery({super.key, required this.id});

//   @override
//   State<Delivery> createState() => _DeliveryState();
// }

// class _DeliveryState extends State<Delivery> {
//   late Storedata datum;
//   String? selectedValue;
//   final TextEditingController _searchfilter = TextEditingController();
//   final TextEditingController _title = TextEditingController();
//   final TextEditingController _note = TextEditingController();
//   final TextEditingController _date = TextEditingController();
//   DateTime selectedDate = DateTime.now();
//   String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

//   List<Storedata> storedata = [];
//   Storedata? storedatas;
//   final RefreshController refreshCntrlr33 =
//       RefreshController(initialRefresh: true);
//   String dropdownvalue = 'Choose a Store';

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<PurchaseProvider>(context, listen: false).getdeliverylist(
//         context: context,
//       );
//       Provider.of<StoreProvider>(context, listen: false)
//           .getlistofStores(context: context, isRefresh: true);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     StoreProvider storedata =
//         Provider.of<StoreProvider>(context, listen: false);
//     Size size = MediaQuery.of(context).size;

//     return Consumer<PurchaseProvider>(builder: (context, provider, child) {
//       return SafeArea(
//         child: Scaffold(
//           backgroundColor: AppColors.white,
//           body: Column(
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(child: _searchbox(size, provider, storedata)),
//                     ]),
//               ),
//               Expanded(
//                   child: SmartRefresher(
//                       controller: refreshCntrlr33,
//                       enablePullUp: true,
//                       enablePullDown: true,
//                       footer: CustomFooter(
//                         builder: (BuildContext context, LoadStatus? mode) {
//                           Widget child;
//                           if (mode == LoadStatus.idle) {
//                             child = Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   CText(
//                                     text: "Swipe up to load more",
//                                     textcolor: AppColors.hint2,
//                                   )
//                                 ]);
//                           } else if (mode == LoadStatus.loading) {
//                             child = Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const CupertinoActivityIndicator(),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   CText(
//                                     text: "Loading..",
//                                     textcolor: AppColors.hint2,
//                                   )
//                                 ]);
//                           } else if (mode == LoadStatus.failed) {
//                             child = Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.error_outlined,
//                                     color: AppColors.hint2,
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   CText(
//                                       text: "No more Data",
//                                       textcolor: AppColors.hint2)
//                                 ]);
//                           } else if (mode == LoadStatus.canLoading) {
//                             child = Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   CText(
//                                     text: "Swipe up to load more",
//                                     textcolor: AppColors.hint2,
//                                   )
//                                 ]);
//                           } else {
//                             child = Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   CText(
//                                     text: "No more Data",
//                                     textcolor: AppColors.hint2,
//                                   )
//                                 ]);
//                           }
//                           return child;
//                         },
//                       ),
//                       onRefresh: () async {
//                         final result = await provider.getdeliverylist(
//                             context: context, isRefresh: true);
//                         if (result) {
//                           refreshCntrlr33.refreshCompleted();
//                         } else {
//                           refreshCntrlr33.refreshFailed();
//                         }
//                       },
//                       onLoading: () async {
//                         final result2 = await provider.getdeliverylist(
//                           context: context,
//                         );
//                         if (result2) {
//                           refreshCntrlr33.loadComplete();
//                         } else {
//                           refreshCntrlr33.loadFailed();
//                         }
//                       },
//                       child: provider.deliverydata == null
//                           ? SizedBox(
//                               height: size.height * 0.6,
//                               child: Center(
//                                   child: SpinKitChasingDots(
//                                       color: AppColors.primaryColor,
//                                       size: 50.0,
//                                       duration:
//                                           const Duration(milliseconds: 1200))),
//                             )
//                           : provider.deliverydata.isEmpty
//                               ? SizedBox(
//                                   height: size.height,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: size.height * 0.1,
//                                       ),
//                                       EmptyWidget(
//                                         hideBackgroundAnimation: false,
//                                         image: null,
//                                         title: 'No Delivery data',
//                                         subTitle:
//                                             'No Delivery data available yet',
//                                         titleTextStyle: GoogleFonts.poppins(
//                                           fontSize: 18,
//                                           color: Color(0xff9da9c7),
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         subtitleTextStyle: GoogleFonts.poppins(
//                                           fontStyle: FontStyle.italic,
//                                           fontSize: 14,
//                                           color: Color(0xffabb8d6),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               : ListView.separated(
//                                   itemBuilder: (context, index) {
//                                     var stors;
//                                     provider.deliverydata[index].store
//                                         ?.forEach((element) {
//                                       stors = element;
//                                     });
//                                     return Container(
//                                       color: Colors.transparent,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Slidable(
//                                           startActionPane: ActionPane(
//                                             motion: ScrollMotion(),
//                                             children: [
//                                               SizedBox(
//                                                 width: 5,
//                                               ),
//                                               widget.id == 1
//                                                   ? SlidableAction(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               12),
//                                                       backgroundColor:
//                                                           Color(0xFFC44040),
//                                                       foregroundColor:
//                                                           AppColors.white,
//                                                       icon: Iconsax.trash,
//                                                       label: 'Trash',
//                                                       onPressed: (BuildContext
//                                                           context) {
//                                                         removeItem(
//                                                             context,
//                                                             provider.deliverydata[
//                                                                 index],
//                                                             provider);
//                                                       },
//                                                     )
//                                                   : SizedBox(),
//                                               SizedBox(
//                                                 width: 5,
//                                               ),
//                                               SlidableAction(
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                                 backgroundColor:
//                                                     Color(0xFF40C756),
//                                                 foregroundColor:
//                                                     AppColors.white,
//                                                 icon: Iconsax.edit_2,
//                                                 label: 'Edit',
//                                                 onPressed:
//                                                     (BuildContext context) {
//                                                   _title.text = provider
//                                                       .deliverydata[index]
//                                                       .deliveryName!;
//                                                   _note.text = provider
//                                                       .deliverydata[index]
//                                                       .note!;
//                                                   _date.text = DateFormat(
//                                                           'dd-MM-yyyy')
//                                                       .format(provider
//                                                           .deliverydata[index]
//                                                           .deliveryDate!);
//                                                   addDeliverylog(
//                                                           context,
//                                                           _title,
//                                                           _date,
//                                                           _note,
//                                                           storedata,
//                                                           provider,
//                                                           2,
//                                                           provider
//                                                               .deliverydata[
//                                                                   index]
//                                                               .id)
//                                                       .then((value) =>
//                                                           refreshCntrlr33
//                                                               .requestRefresh());
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                 child: _customContainer(
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Flexible(
//                                                             child: Container(
//                                                               child: CText(
//                                                                 text: provider
//                                                                     .deliverydata[
//                                                                         index]
//                                                                     .deliveryName!,
//                                                                 size: 16,
//                                                                 fontw:
//                                                                     FontWeight
//                                                                         .w500,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .end,
//                                                         children: [
//                                                           Icon(
//                                                             Iconsax.clock,
//                                                             size: 16,
//                                                             color:
//                                                                 AppColors.hint,
//                                                           ),
//                                                           SizedBox(
//                                                             width: 3,
//                                                           ),
//                                                           Expanded(
//                                                             child: CText(
//                                                               text: DateFormat
//                                                                       .MMMd()
//                                                                   .addPattern(
//                                                                       "|")
//                                                                   .add_jm()
//                                                                   .format(
//                                                                     provider
//                                                                         .deliverydata[
//                                                                             index]
//                                                                         .deliveryDate!,
//                                                                   ),
//                                                               fontw: FontWeight
//                                                                   .w300,
//                                                               size: 12,
//                                                             ),
//                                                           ),
//                                                           Expanded(
//                                                             flex: 1,
//                                                             child: Container(
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                       gradient:
//                                                                           LinearGradient(
//                                                                               colors: [
//                                                                             AppColors.white10.withOpacity(.4),
//                                                                             AppColors.white10.withOpacity(.7),
//                                                                           ]),
//                                                                       borderRadius:
//                                                                           BorderRadius.circular(
//                                                                               7)),
//                                                               child: Row(
//                                                                 mainAxisSize:
//                                                                     MainAxisSize
//                                                                         .min,
//                                                                 children: [
//                                                                   CircleAvatar(
//                                                                     radius: 18,
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .transparent,
//                                                                     child: Icon(
//                                                                       FontAwesomeIcons
//                                                                           .shopify,
//                                                                       size: 18,
//                                                                       color: AppColors
//                                                                           .primaryDarkColor,
//                                                                     ),
//                                                                   ),
//                                                                   Flexible(
//                                                                     child: CText(
//                                                                         text: stors
//                                                                             .location),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       ExpansionTile(
//                                                         backgroundColor:
//                                                             Colors.transparent,
//                                                         collapsedBackgroundColor:
//                                                             Colors.transparent,
//                                                         collapsedIconColor:
//                                                             Colors.transparent,
//                                                         expandedCrossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         expandedAlignment:
//                                                             Alignment.topLeft,
//                                                         tilePadding:
//                                                             EdgeInsets.all(0),
//                                                         title: CText(
//                                                           text: '',
//                                                           size: 16,
//                                                           fontw:
//                                                               FontWeight.w500,
//                                                         ),
//                                                         children: [
//                                                           Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               CText(
//                                                                 text: provider
//                                                                     .deliverydata[
//                                                                         index]
//                                                                     .note!,
//                                                                 size: 16,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(width: 2),
//                                               if (provider.deliverydata[index]
//                                                       .status ==
//                                                   1)
//                                                 Expanded(
//                                                   flex: 0,
//                                                   child: _customContainer2(
//                                                     ontap: () {
//                                                       statusChange(
//                                                               size: size,
//                                                               provider:
//                                                                   provider,
//                                                               data: provider
//                                                                       .deliverydata[
//                                                                   index])
//                                                           .then((value) =>
//                                                               refreshCntrlr33
//                                                                   .requestRefresh());
//                                                     },
//                                                     colors: [
//                                                       Color(0xFFDA708A),
//                                                       Color(0xFFDB5173),
//                                                     ],
//                                                     child: Center(
//                                                       child: RotatedBox(
//                                                         quarterTurns: 3,
//                                                         child: Text(
//                                                           "Open",
//                                                           style: GoogleFonts
//                                                               .nunito(
//                                                             fontSize: 20,
//                                                             color:
//                                                                 AppColors.white,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               if (provider.deliverydata[index]
//                                                       .status ==
//                                                   2)
//                                                 Expanded(
//                                                   flex: 0,
//                                                   child: _customContainer2(
//                                                     ontap: () {
//                                                       statusChange(
//                                                               size: size,
//                                                               provider:
//                                                                   provider,
//                                                               data: provider
//                                                                       .deliverydata[
//                                                                   index])
//                                                           .then((value) =>
//                                                               refreshCntrlr33
//                                                                   .requestRefresh());
//                                                     },
//                                                     colors: [
//                                                       Color(0xFF5ED682),
//                                                       Color(0xFF4CBD6E),
//                                                     ],
//                                                     child: Center(
//                                                       child: RotatedBox(
//                                                         quarterTurns: 3,
//                                                         child: Text(
//                                                           "Inprogress",
//                                                           style: GoogleFonts
//                                                               .nunito(
//                                                             fontSize: 20,
//                                                             color:
//                                                                 AppColors.white,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               if (provider.deliverydata[index]
//                                                       .status ==
//                                                   3)
//                                                 Expanded(
//                                                   flex: 0,
//                                                   child: _customContainer2(
//                                                     ontap: () {
//                                                       statusChange(
//                                                               size: size,
//                                                               provider:
//                                                                   provider,
//                                                               data: provider
//                                                                       .deliverydata[
//                                                                   index])
//                                                           .then((value) =>
//                                                               refreshCntrlr33
//                                                                   .requestRefresh());
//                                                     },
//                                                     colors: [
//                                                       AppColors
//                                                           .primaryDarkColor,
//                                                       Colors.indigo.shade900,
//                                                     ],
//                                                     child: Center(
//                                                       child: RotatedBox(
//                                                         quarterTurns: 3,
//                                                         child: Text(
//                                                           "Done",
//                                                           style: GoogleFonts
//                                                               .nunito(
//                                                             fontSize: 20,
//                                                             color:
//                                                                 AppColors.white,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   separatorBuilder: (context, index) =>
//                                       SizedBox(
//                                         height: 1,
//                                       ),
//                                   itemCount: provider.deliverydata != null
//                                       ? provider.deliverydata.length
//                                       : 0)))
//             ],
//           ),
//           floatingActionButton: widget.id == 1
//               ? FloatingActionButton(
//                   elevation: 4,
//                   onPressed: () {
//                     addDeliverylog(context, _title, _date, _note, storedata,
//                             provider, 1, "")
//                         .then((value) => refreshCntrlr33.requestRefresh());
//                   },
//                   backgroundColor: Color(0xFF141849).withOpacity(.7),
//                   child: Icon(Icons.add),
//                 )
//               : SizedBox(),
//         ),
//       );
//     });
//   }

//   removeItem(
//       BuildContext context, Deliverydata item, PurchaseProvider provider) {
//     return showGeneralDialog(
//       context: context,
//       barrierLabel: "Remove item",
//       barrierDismissible: true,
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionDuration: Duration(milliseconds: 700),
//       pageBuilder: (filtercontext, __, ___) {
//         return StatefulBuilder(builder: (context, setState) {
//           return Center(
//             child: Container(
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(10)),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Material(
//                     color: AppColors.white,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         InkWell(
//                           highlightColor: Colors.transparent,
//                           hoverColor: Colors.transparent,
//                           onTap: () => Navigator.pop(context),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.all(6),
//                               decoration: BoxDecoration(
//                                   color: Colors.white10,
//                                   border: Border.all(
//                                     color:
//                                         AppColors.primaryColor.withOpacity(.3),
//                                   ),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Icon(
//                                 Iconsax.close_circle,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Material(
//                     color: AppColors.white,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         CText(
//                           text: "Confirm Delete",
//                           size: 15,
//                           fontw: FontWeight.bold,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Material(
//                     color: AppColors.white,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         CText(
//                           text: "Remove ${item.deliveryName}",
//                           textcolor: AppColors.hint,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: 60,
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Expanded(
//                         flex: 0,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 1.0),
//                           child: Container(
//                             height: 40.0,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: MaterialButton(
//                               elevation: 0,
//                               onPressed: () {
//                                 provider
//                                     .deletedeliveryitem(
//                                         context, item.id.toString())
//                                     .then((value) =>
//                                         refreshCntrlr33.requestRefresh());
//                               },
//                               color: AppColors.primaryDarkColor,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(28.0)),
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     CText(
//                                       text: "Remove Item",
//                                       textcolor: AppColors.white,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Icon(
//                                       Iconsax.arrow_up,
//                                       color: AppColors.white,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//       transitionBuilder: (_, anim, __, child) {
//         Tween<Offset> tween;
//         if (anim.status == AnimationStatus.reverse) {
//           tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
//         } else {
//           tween = Tween(begin: Offset(1, 0), end: Offset.zero);
//         }

//         return FadeTransition(
//           opacity: anim,
//           child: FadeTransition(
//             opacity: anim,
//             child: child,
//           ),
//         );
//       },
//     );
//   }

//   _purchasetitle(Size size, TextEditingController controller) {
//     return Container(
//         width: size.width,
//         height: 45,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.0),
//           color: Color(0xffA4A69C).withOpacity(0.4),
//         ),
//         padding: EdgeInsets.all(0.0),
//         child: CTextFormField(
//           controller: controller,
//           placeholder: "Device id",
//           decoration: BoxDecoration(
//               color: Color.fromARGB(255, 253, 255, 245).withOpacity(0)),
//         ));
//   }

//   Widget _searchbox(
//     Size size,
//     PurchaseProvider provider,
//     StoreProvider store,
//   ) {
//     return Container(
//         width: size.width,
//         height: 45,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.0),
//           color: Color(0xffA4A69C).withOpacity(0.1),
//         ),
//         padding: EdgeInsets.all(0.0),
//         child: CTextFormField(
//             controller: _searchfilter,
//             onChanged: (value) {
//               provider.getdeliverylist(
//                   context: context, title: value, isRefresh: true);
//             },
//             placeholder: widget.id == 1
//                 ? "Search by store location,title.."
//                 : "Search by title..",
//             icon: FaIcon(
//               Iconsax.search_normal_1,
//               color: Colors.grey,
//             ),
//             decoration: BoxDecoration(color: Color(0xffA4A69C).withOpacity(0)),
//             suffix: InkWell(
//                 highlightColor: Colors.transparent,
//                 hoverColor: Colors.transparent,
//                 onTap: () {
//                   _filterbottomsheet(context, size, store, provider);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Icon(
//                     Iconsax.setting_3,
//                     color: Color(0xFF141849).withOpacity(.7),
//                     size: 30,
//                   ),
//                 ))));
//   }

//   void _filterbottomsheet(
//       context, size, StoreProvider store, PurchaseProvider provider) {
//     String? storeid;
//     bool open = false;
//     bool inpro = false;
//     bool done = false;
//     String statusid = "";
//     String storesid = "";
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           Provider.of<StoreProvider>(context, listen: false)
//               .getlistofStores(context: context, isRefresh: true);
//           return StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState) {
//             return Container(
//               color: Colors.white,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Material(
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           CText(
//                             text: "Filters",
//                             fontw: FontWeight.w700,
//                             size: 18,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Divider(),
//                   widget.id == 1
//                       ? Material(
//                           color: AppColors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: AppColors.primaryColor
//                                             .withOpacity(.3),
//                                         borderRadius:
//                                             BorderRadius.circular(16)),
//                                     child: DropdownButtonHideUnderline(
//                                       child: ButtonTheme(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(16)),
//                                         buttonColor:
//                                             AppColors.hint.withOpacity(.3),
//                                         alignedDropdown: true,
//                                         child: DropdownButton(
//                                           dropdownColor: AppColors.white,
//                                           isExpanded: true,
//                                           style:
//                                               TextStyle(color: AppColors.hint),
//                                           iconEnabledColor:
//                                               AppColors.primaryColor,
//                                           items: store.storedata.map((item) {
//                                             return DropdownMenuItem(
//                                               value: item.id.toString(),
//                                               child: Center(
//                                                 child: Text(
//                                                   item != null
//                                                       ? item.location
//                                                       : "location",
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                             );
//                                           }).toList(),
//                                           hint: Text(
//                                             "Choose a store",
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 16.0,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                           onChanged: (String? value) {
//                                             setState(() {
//                                               storeid = value;
//                                               storesid = storesid;
//                                             });
//                                             print(value);
//                                           },
//                                           value: storeid,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : SizedBox(),
//                   widget.id == 1 ? Divider() : SizedBox(),

//                   Material(
//                       color: AppColors.white,
//                       child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Container(
//                                     child: Row(children: [
//                                   GFCheckbox(
//                                       size: GFSize.SMALL,
//                                       onChanged: (value) {
//                                         if (inpro == false && done == false) {
//                                           setState(() {
//                                             open = value;
//                                             statusid = "1";
//                                           });
//                                         }
//                                       },
//                                       value: open),
//                                   Chip(
//                                     backgroundColor: Color(0xFFDB5173),
//                                     label: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 3, vertical: 3),
//                                       child: CText(
//                                         text: "Open",
//                                         fontw: FontWeight.w500,
//                                         size: 16,
//                                         textcolor: AppColors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ])),
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       GFCheckbox(
//                                           size: GFSize.SMALL,
//                                           onChanged: (value) {
//                                             if (open == false &&
//                                                 done == false) {
//                                               setState(() {
//                                                 inpro = value;
//                                                 statusid = "2";
//                                               });
//                                             }
//                                           },
//                                           value: inpro),
//                                       Chip(
//                                         backgroundColor: Color(0xFF4CBD6E),
//                                         label: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 3, vertical: 3),
//                                           child: CText(
//                                             text: "InProgress",
//                                             fontw: FontWeight.w500,
//                                             size: 16,
//                                             textcolor: AppColors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                     child: Row(children: [
//                                   GFCheckbox(
//                                       size: GFSize.SMALL,
//                                       onChanged: (value) {
//                                         if (inpro == false && open == false) {
//                                           setState(() {
//                                             done = value;
//                                             statusid = "3";
//                                           });
//                                         }
//                                       },
//                                       value: done),
//                                   Chip(
//                                     backgroundColor: AppColors.primaryDarkColor,
//                                     label: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 3, vertical: 3),
//                                       child: CText(
//                                         text: "Done",
//                                         fontw: FontWeight.w500,
//                                         size: 16,
//                                         textcolor: AppColors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ]))
//                               ]))),
//                   _filterinner(size, context, () {
//                     Navigator.pop(context);
//                     provider.getdeliverylist(
//                         context: context,
//                         isRefresh: true,
//                         id: storeid != null ? storeid.toString() : "",
//                         status: statusid);
//                   }, () {
//                     Navigator.pop(context);
//                     provider.getlistofPurchases(
//                         context: context, isRefresh: true);
//                   })
//                 ],
//               ),
//             );
//           });
//         });
//   }

//   Future<void> statusChange(
//       {required Size size,
//       required PurchaseProvider provider,
//       required Deliverydata data}) {
//     return showGeneralDialog(
//         context: context,
//         barrierLabel: "Add Purchase",
//         barrierDismissible: true,
//         barrierColor: Colors.black.withOpacity(0.5),
//         transitionDuration: Duration(milliseconds: 700),
//         pageBuilder: (filtercontext, __, ___) {
//           return StatefulBuilder(builder: (context, setState) {
//             return Center(
//                 child: Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(horizontal: 20),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Column(mainAxisSize: MainAxisSize.min, children: [
//                       Material(
//                         color: AppColors.white,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               children: [
//                                 _customContainer3(
//                                   size: size,
//                                   ontap: () {
//                                     provider.updateDeliverystatus(
//                                         context: context,
//                                         storeId: data.storeId,
//                                         listid: data.id,
//                                         status: "1");
//                                   },
//                                   colors: [
//                                     Color(0xFFDA708A),
//                                     Color(0xFFDB5173),
//                                   ],
//                                   child: Center(
//                                     child: Text(
//                                       "Open",
//                                       style: GoogleFonts.nunito(
//                                         fontSize: 20,
//                                         color: AppColors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 _customContainer3(
//                                   size: size,
//                                   ontap: () {
//                                     provider.updateDeliverystatus(
//                                         context: context,
//                                         storeId: data.storeId,
//                                         listid: data.id,
//                                         status: "2");
//                                   },
//                                   colors: [
//                                     Color(0xFF5ED682),
//                                     Color(0xFF4CBD6E),
//                                   ],
//                                   child: Center(
//                                     child: Text(
//                                       "InProgress",
//                                       style: GoogleFonts.nunito(
//                                         fontSize: 20,
//                                         color: AppColors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 _customContainer3(
//                                   size: size,
//                                   ontap: () {
//                                     provider.updateDeliverystatus(
//                                         context: context,
//                                         storeId: data.storeId,
//                                         listid: data.id,
//                                         status: "3");
//                                   },
//                                   colors: [
//                                     AppColors.primaryDarkColor,
//                                     Colors.indigo.shade900,
//                                   ],
//                                   child: Center(
//                                     child: Text(
//                                       "Done",
//                                       style: GoogleFonts.nunito(
//                                         fontSize: 20,
//                                         color: AppColors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 InkWell(
//                                   highlightColor: Colors.transparent,
//                                   hoverColor: Colors.transparent,
//                                   onTap: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Container(
//                                       padding: EdgeInsets.all(6),
//                                       decoration: BoxDecoration(
//                                           color: Colors.white10,
//                                           border: Border.all(
//                                             color: AppColors.primaryColor
//                                                 .withOpacity(.3),
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(10)),
//                                       child: Icon(
//                                         Iconsax.close_circle,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 155,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                     ])));
//           });
//         });
//   }

//   Future<void> addDeliverylog(
//       BuildContext context,
//       TextEditingController _title,
//       TextEditingController _date,
//       TextEditingController _note,
//       StoreProvider store,
//       PurchaseProvider provider,
//       int v,
//       String listid) {
//     return showGeneralDialog(
//       context: context,
//       barrierLabel: "Add Purchase",
//       barrierDismissible: true,
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionDuration: Duration(milliseconds: 700),
//       pageBuilder: (filtercontext, __, ___) {
//         bool error = false;
//         bool noteerror = false;
//         bool dateerror = false;
//         String? storeid;
//         return StatefulBuilder(builder: (context, setState) {
//           Provider.of<StoreProvider>(context, listen: false)
//               .getlistofStores(context: context, isRefresh: true);
//           return Center(
//             child: Container(
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(10)),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Material(
//                     color: AppColors.white,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         InkWell(
//                           highlightColor: Colors.transparent,
//                           hoverColor: Colors.transparent,
//                           onTap: () {
//                             _title.clear();
//                             _note.clear();
//                             _date.clear();
//                             Navigator.pop(context);
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: EdgeInsets.all(6),
//                               decoration: BoxDecoration(
//                                   color: Colors.white10,
//                                   border: Border.all(
//                                     color:
//                                         AppColors.primaryColor.withOpacity(.3),
//                                   ),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Icon(
//                                 Iconsax.close_circle,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   widget.id == 1
//                       ? CTextFormField(
//                           controller: _title,
//                           onChanged: (value) {
//                             value != ""
//                                 ? setState(
//                                     () {
//                                       error = false;
//                                     },
//                                   )
//                                 : "";
//                           },
//                           placeholder: "Enter new Title",
//                           decoration: BoxDecoration(color: AppColors.white10),
//                         )
//                       : SizedBox(),
//                   widget.id == 1
//                       ? Visibility(
//                           visible: error,
//                           child: Material(
//                             color: AppColors.white,
//                             child: Row(
//                               children: [
//                                 CText(
//                                   text: "* Title is required.",
//                                   textcolor: Colors.red.shade800,
//                                   size: 12,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : SizedBox(),
//                   widget.id == 1
//                       ? SizedBox(
//                           height: 10,
//                         )
//                       : SizedBox(),
//                   CTextFormField(
//                     controller: _note,
//                     onChanged: (value) {
//                       // value != ""
//                       //     ? setState(
//                       //         () {
//                       //           noteerror = false;
//                       //         },
//                       //       )
//                       //     : "";
//                     },
//                     placeholder: "Enter Note",
//                     decoration: BoxDecoration(color: AppColors.white10),
//                   ),

//                   // Visibility(
//                   //   visible: noteerror,
//                   //   child: Material(
//                   //     color: AppColors.white,
//                   //     child: Row(
//                   //       children: [
//                   //         CText(
//                   //           text: "* Note is required.",
//                   //           textcolor: Colors.red.shade800,
//                   //           size: 12,
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   widget.id == 1
//                       ? SizedBox(
//                           height: 10,
//                         )
//                       : SizedBox(),
//                   widget.id == 1
//                       ? Row(
//                           children: [
//                             Material(
//                               color: AppColors.white,
//                               child: InkWell(
//                                 onTap: () {
//                                   _selectDate(context);
//                                 },
//                                 child: Container(
//                                   color: AppColors.white10,
//                                   padding: EdgeInsets.all(11),
//                                   child: Icon(Iconsax.calendar_add),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: CTextFormField(
//                                 controller: _date,
//                                 onChanged: (value) {
//                                   value != ""
//                                       ? setState(
//                                           () {
//                                             dateerror = false;
//                                           },
//                                         )
//                                       : "";
//                                 },
//                                 placeholder: "Enter Expected Date",
//                                 decoration:
//                                     BoxDecoration(color: AppColors.white10),
//                               ),
//                             ),
//                           ],
//                         )
//                       : SizedBox(),
//                   widget.id == 1
//                       ? Visibility(
//                           visible: dateerror,
//                           child: Material(
//                             color: AppColors.white,
//                             child: Row(
//                               children: [
//                                 CText(
//                                   text: "* Date is required.",
//                                   textcolor: Colors.red.shade800,
//                                   size: 12,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : SizedBox(),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   widget.id == 1
//                       ? Material(
//                           color: AppColors.white,
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 60,
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: AppColors.primaryColor
//                                           .withOpacity(.3),
//                                       borderRadius: BorderRadius.circular(16)),
//                                   child: DropdownButtonHideUnderline(
//                                     child: ButtonTheme(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(16)),
//                                       buttonColor:
//                                           AppColors.hint.withOpacity(.3),
//                                       alignedDropdown: true,
//                                       child: DropdownButton(
//                                         dropdownColor: AppColors.white,
//                                         isExpanded: true,
//                                         style: TextStyle(color: AppColors.hint),
//                                         iconEnabledColor:
//                                             AppColors.primaryColor,
//                                         items: store.storedata.map((item) {
//                                           return DropdownMenuItem(
//                                             value: item.id.toString(),
//                                             child: Center(
//                                               child: Text(
//                                                 item != null
//                                                     ? item.location!
//                                                     : "location",
//                                                 style: TextStyle(
//                                                     color: Colors.black),
//                                               ),
//                                             ),
//                                           );
//                                         }).toList(),
//                                         hint: Text(
//                                           "Choose a store",
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                         onChanged: (String? value) {
//                                           setState(() {
//                                             storeid = value;
//                                           });
//                                           print(value);
//                                         },
//                                         value: storeid,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : SizedBox(),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Expanded(
//                         flex: 0,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 1.0),
//                           child: Container(
//                             height: 40.0,
//                             width: MediaQuery.of(context).size.width * 0.40,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: MaterialButton(
//                               elevation: 0,
//                               onPressed: () {
//                                 if (widget.id == 1) {
//                                   if (_title.text == "") {
//                                     setState(
//                                       () {
//                                         error = true;
//                                       },
//                                     );
//                                   } else if (_date.text == "") {
//                                     setState(
//                                       () {
//                                         dateerror = true;
//                                       },
//                                     );
//                                   } else {
//                                     v == 1
//                                         ? provider.addDelivery(
//                                             context,
//                                             _title,
//                                             storeid!,
//                                             selectedDate.toString(),
//                                             _note.text)
//                                         : provider.updateDelivery(
//                                             context,
//                                             _title,
//                                             storeid!,
//                                             selectedDate.toString(),
//                                             _note.text,
//                                             listid);
//                                   }
//                                 } else {
//                                   provider.updateDelivery(
//                                       context,
//                                       _title,
//                                       storeid!,
//                                       selectedDate.toString(),
//                                       _note.text,
//                                       listid);
//                                 }
//                               },
//                               color: AppColors.primaryDarkColor,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(28.0)),
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     CText(
//                                       text: v == 1 ? "New List" : "Update",
//                                       textcolor: AppColors.white,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Icon(
//                                       Iconsax.arrow_up,
//                                       color: AppColors.white,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//       transitionBuilder: (_, anim, __, child) {
//         Tween<Offset> tween;
//         if (anim.status == AnimationStatus.reverse) {
//           tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
//         } else {
//           tween = Tween(begin: Offset(1, 0), end: Offset.zero);
//         }

//         return FadeTransition(
//           opacity: anim,
//           child: FadeTransition(
//             opacity: anim,
//             child: child,
//           ),
//         );
//       },
//     );
//   }

//   Widget _customContainer({required Widget child}) {
//     return Card(
//       elevation: 7,
//       shadowColor: Color(0xff3D394F).withOpacity(1),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           gradient: LinearGradient(
//             colors: [
//               AppColors.primaryColor,
//               Color.fromARGB(255, 183, 238, 252),
//             ],
//             begin: const FractionalOffset(0.0, 0.0),
//             end: const FractionalOffset(1.0, 0.0),
//             stops: [0.0, 1.0],
//             tileMode: TileMode.clamp,
//           ),
//         ),
//         child: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: child,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _customContainer2(
//       {required Widget child,
//       required List<Color> colors,
//       required void Function() ontap}) {
//     return Card(
//       elevation: 0,
//       shadowColor: AppColors.white10,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//       child: InkWell(
//         onTap: ontap,
//         child: Container(
//           height: 120,
//           margin: const EdgeInsets.only(bottom: 0),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: colors,
//               begin: const FractionalOffset(0.0, 0.0),
//               end: const FractionalOffset(1.0, 0.0),
//               stops: [0.0, 1.0],
//               tileMode: TileMode.mirror,
//             ),
//             borderRadius: BorderRadius.circular(0),
//           ),
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: child,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _customContainer3(
//       {required Widget child,
//       required List<Color> colors,
//       required void Function() ontap,
//       required Size size}) {
//     return InkWell(
//       onTap: ontap,
//       hoverColor: AppColors.white10,
//       child: Card(
//         elevation: 3,
//         shadowColor: AppColors.white10,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//         child: Container(
//           height: 60,
//           width: size.width * 0.5,
//           margin: const EdgeInsets.only(bottom: 0),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: colors,
//               begin: const FractionalOffset(0.0, 0.0),
//               end: const FractionalOffset(1.0, 0.0),
//               stops: [0.0, 1.0],
//               tileMode: TileMode.mirror,
//             ),
//             borderRadius: BorderRadius.circular(0),
//           ),
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: child,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _filterinner(
//       Size size, context, void Function() submit, void Function() cancel) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: CElevatedButton(
//               color: Color(0xffA4A69C).withOpacity(0.4),
//               discolor: CupertinoColors.darkBackgroundGray,
//               text: CText(
//                 text: "Clear All",
//                 textcolor: CupertinoColors.black,
//                 size: 14,
//               ),
//               size: Size(0, 45),
//               onpressed: cancel,
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             child: CElevatedButton(
//               color: AppColors.primaryDarkColor,
//               discolor: CupertinoColors.darkBackgroundGray,
//               text: CText(
//                 text: "Apply Filters",
//                 textcolor: CupertinoColors.white,
//                 size: 15,
//               ),
//               size: Size(0, 45),
//               onpressed: submit,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(2015, 8),
//         lastDate: DateTime(2101));
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
//         _date.text = formattedDate;
//       });
//     }
//   }
// }

// ignore_for_file: prefer_const_constructors, camel_case_types

part of Values;

class networkConnectivity {
  static network() {
    return showSimpleNotification(
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              radius: 14,
              child: const Icon(
                Icons.wifi_off_outlined,
                color: Colors.black,
              )),
          const SizedBox(
            width: 20,
          ),
          CText(
            text: "No Internet Connection",
            textcolor: AppColors.white,
          ),
        ]),
        background: AppColors.dark);
  }
}

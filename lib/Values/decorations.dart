part of 'values.dart';

class Decorations {
  static BoxDecoration boxDecorationColor(
      {Color color = const Color(0xFFFFFFFF), borderRadius = 8.0}) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)));
  }

  static BoxDecoration boxDecorationColorBorder(
      {Color color = const Color(0xFFFFFFFF), borderRadius = 8.0}) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ]);
  }
}

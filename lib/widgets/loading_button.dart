import 'package:flutter/material.dart';

class loadingButton extends StatelessWidget {
  final void Function()? onTap;
  final Color color;
  final double width;
  final double height;
  final String text;
  final TextStyle textStyle;
  final Widget child;
  final bool
      isLoading; // Thêm biến isLoading để xác định trạng thái loading của nút.

  const loadingButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
    required this.width,
    required this.height,
    required this.textStyle,
    this.isLoading = false,
    required this.child, // Mặc định là false, tức là không loading.
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: isLoading
            ? child
            : CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }
}

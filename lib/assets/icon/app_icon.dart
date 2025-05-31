import 'package:flutter/material.dart';

/// A custom icon for the Baloot Counter app
/// This can be used anywhere in the app where a widget is needed
class BalootIcon extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Color cardColor;
  final Color textColor;

  const BalootIcon({
    Key? key,
    this.size = 100,
    this.backgroundColor = const Color(0xFF121212),
    this.cardColor = const Color(0xFFFFC629),
    this.textColor = const Color(0xFF121212),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size * 0.2),
      ),
      child: CustomPaint(
        size: Size(size, size),
        painter: _BalootIconPainter(
          backgroundColor: backgroundColor,
          cardColor: cardColor,
          textColor: textColor,
        ),
      ),
    );
  }
}

class _BalootIconPainter extends CustomPainter {
  final Color backgroundColor;
  final Color cardColor;
  final Color textColor;

  _BalootIconPainter({
    required this.backgroundColor,
    required this.cardColor, 
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final center = Offset(width / 2, height / 2);
    
    // Draw the main card
    final cardPaint = Paint()
      ..color = cardColor
      ..style = PaintingStyle.fill;
    
    // First card - slightly rotated left
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-0.2);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx - width * 0.05, center.dy),
          width: width * 0.6,
          height: height * 0.8,
        ),
        Radius.circular(width * 0.08),
      ),
      cardPaint,
    );
    canvas.restore();
    
    // Second card - slightly rotated right
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(0.2);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx + width * 0.05, center.dy),
          width: width * 0.6,
          height: height * 0.8,
        ),
        Radius.circular(width * 0.08),
      ),
      cardPaint,
    );
    canvas.restore();
    
    // Draw the number text
    final textStyle = TextStyle(
      color: textColor,
      fontSize: width * 0.4,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(
      text: "152",
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: width,
    );
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// This function creates an icon widget that can be exported as an image
/// for app icon purposes
Widget buildExportableIcon({double size = 1024}) {
  return BalootIcon(
    size: size,
    backgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFFFFC629),
    textColor: const Color(0xFF121212),
  );
} 
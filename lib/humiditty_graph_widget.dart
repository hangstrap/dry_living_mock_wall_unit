import 'package:flutter/material.dart';

class HumidityGraphWidget extends StatelessWidget {
  final int humidity;
  final int targetHumidity;

  const HumidityGraphWidget({
    super.key,
    required this.humidity,
    required this.targetHumidity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 10, // Important: set height here
      child: CustomPaint(
        painter: _HumidityGraphPainter(humidity, targetHumidity),
      ),
    );
  }
}

class _HumidityGraphPainter extends CustomPainter {
  final int humidity;
  final int targetHumidity;

  _HumidityGraphPainter(this.humidity, this.targetHumidity);

  @override
  void paint(Canvas canvas, Size size) {
    final tickPaint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 1;
    final linePaint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2;
    final underPaint = Paint()..color = Colors.orange;
    final overPaint = Paint()..color = Colors.red;
    final targetPaint = Paint()..color = Colors.blue;
    final recommendedPaint = Paint()..color = Colors.lightGreen;

    final barY = size.height / 2;
    final scale = size.width / 100;

    // Base line
    canvas.drawLine(Offset(0, barY), Offset(size.width, barY), linePaint);
    
    // Recommended range
    {
      final lowX = 55 * scale;
      final width = 10 * scale;
      canvas.drawRect(
        Rect.fromLTWH(lowX, barY - 7, width, 7),
        recommendedPaint,
      );
    }
    // Ticks every 10%
    for (int i = 0; i <= 100; i += 10) {
      final x = i * scale;
      canvas.drawLine(Offset(x, barY - 5), Offset(x, barY + 5), tickPaint);
    }
    // Long ticks at 0%, 50%, 100%
    for (int i in [0, 50, 100]) {
      final x = i * scale;
      canvas.drawLine(Offset(x, barY - 10), Offset(x, barY + 10), tickPaint);
    }

    // Humidity bars
    var top = barY - 2;
    double thickness = 4;
    if (humidity < targetHumidity) {
      
      canvas.drawRect(
        Rect.fromLTWH(0, top, humidity * scale, thickness),
        underPaint,
      );
    } else {
      canvas.drawRect(
        Rect.fromLTWH(0, top, targetHumidity * scale, thickness),
        underPaint,
      );
      canvas.drawRect(
        Rect.fromLTWH(
          targetHumidity * scale,
          top,
          (humidity - targetHumidity) * scale,
          thickness,
        ),
        overPaint,
      );
    }

    // Target circle
    canvas.drawCircle(Offset(targetHumidity * scale, barY), 4, targetPaint);

    final textY = barY + 10;    
    _drawLabel(canvas, '0%',  Offset(0, textY));
    _drawLabel(canvas, '50%',  Offset(50*scale-8, textY));
    _drawLabel(canvas, '100%',  Offset(100*scale-22, textY));
  }

  void _drawLabel(
    Canvas canvas,
    String text,
    Offset offset,
  ) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: text,
      style:  TextStyle(color: Colors.grey[800], fontSize: 10),
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

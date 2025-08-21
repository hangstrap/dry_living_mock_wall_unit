import 'package:flutter/material.dart';

class HumidityGraphScaleHelper {
  final double width;
  static const int minHumidity = 40;
  static const int maxHumidity = 80;

  HumidityGraphScaleHelper(this.width);

  /// Converts humidity (40–80) to an x-coordinate
  double toX(int humidity) {
    final clamped = humidity.clamp(minHumidity, maxHumidity);
    return ((clamped - minHumidity) / (maxHumidity - minHumidity)) * width;
  }

  /// Converts an x-coordinate to a humidity value (40–80)
  int fromX(double x) {
    final ratio = (x / width).clamp(0.0, 1.0);
    final humidity = minHumidity + ratio * (maxHumidity - minHumidity);
    return humidity.round();
  }
}

class HumidityGraphWidget extends StatelessWidget {
  final int humidity;
  final int targetHumidity;
  final void Function(int)? onHumidityTap;
  final VoidCallback onEditRequested;
  final bool dislayLable;

  const HumidityGraphWidget({
    super.key,
    required this.humidity,
    required this.targetHumidity,
    this.onHumidityTap,
    required this.onEditRequested,
    this.dislayLable = true, 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(dislayLable)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8), // Move label in
              child: Text("Humidity"),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ), // Optional: move value in
              child: Text(
                '$humidity%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          height: 25,
          child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              final localX = details.localPosition.dx;
              final renderBox = context.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                final width = renderBox.size.width;
                final scaleHelper = HumidityGraphScaleHelper(width);
                final clickedHumidity = scaleHelper.fromX(localX);
                onHumidityTap?.call(clickedHumidity);
                onEditRequested.call();
              }
            },
            child: CustomPaint(
              painter: _HumidityGraphPainter(humidity, targetHumidity),
            ),
          ),
        ),
      ],
    );
  }
}

class _HumidityGraphPainter extends CustomPainter {
  final int humidity;
  final int targetHumidity;

  _HumidityGraphPainter(this.humidity, this.targetHumidity);

  @override
  void paint(Canvas canvas, Size size) {
    final scaleHelper = HumidityGraphScaleHelper(size.width);
    final barY = size.height / 2;

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

    // Only draw the base line from 40% to 80%
    final minLine = 40;
    final maxLine = 80;
    final minX = scaleHelper.toX(minLine);
    final maxX = scaleHelper.toX(maxLine);
    canvas.drawLine(Offset(minX, barY), Offset(maxX, barY), linePaint);

    // Recommended range: 55–65%
    final lowX = scaleHelper.toX(55);
    final highX = scaleHelper.toX(65);
    canvas.drawRect(
      Rect.fromLTWH(lowX, barY - 7, highX - lowX, 7),
      recommendedPaint,
    );

    // Ticks every 10% from 40 to 80
    for (int i = 40; i <= 80; i += 10) {
      final x = scaleHelper.toX(i);
      canvas.drawLine(Offset(x, barY - 5), Offset(x, barY + 5), tickPaint);
    }

    // Long ticks at 40, 60, 80
    for (int i in [40, 60, 80]) {
      final x = scaleHelper.toX(i);
      canvas.drawLine(Offset(x, barY - 10), Offset(x, barY + 10), tickPaint);
    }

    // Humidity bars (clip to 40-80%)
    final top = barY - 2;
    const thickness = 4.0;
    final hX = scaleHelper.toX(humidity.clamp(40, 80));
    final tX = scaleHelper.toX(targetHumidity.clamp(40, 80));

    if (humidity < targetHumidity) {
      canvas.drawRect(Rect.fromLTWH(minX, top, hX - minX, thickness), underPaint);
    } else {
      canvas.drawRect(Rect.fromLTWH(minX, top, tX - minX, thickness), underPaint);
      canvas.drawRect(Rect.fromLTWH(tX, top, hX - tX, thickness), overPaint);
    }

    // Target circle (clip to 40-80%)
    canvas.drawCircle(Offset(tX, barY), 4, targetPaint);

    // Labels at 40, 60, 80
    final textY = barY + 10;
    _drawLabel(canvas, '40%', Offset(scaleHelper.toX(40), textY));
    _drawLabel(canvas, '60%', Offset(scaleHelper.toX(60) - 8, textY));
    _drawLabel(canvas, '80%', Offset(scaleHelper.toX(80) - 18, textY));
  }

  void _drawLabel(Canvas canvas, String text, Offset offset) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(color: Colors.grey[800])),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

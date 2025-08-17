import 'package:flutter/material.dart';
import '../../label_value_widget.dart';

class HumidityGraphScaleHelper {
  final double width;
  static const int minHumidity = 20;
  static const int maxHumidity = 80;

  HumidityGraphScaleHelper(this.width);

  /// Converts humidity (20–80) to an x-coordinate
  double toX(int humidity) {
    final clamped = humidity.clamp(minHumidity, maxHumidity);
    return ((clamped - minHumidity) / (maxHumidity - minHumidity)) * width;
  }

  /// Converts an x-coordinate to a humidity value (20–80)
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

  const HumidityGraphWidget({
    super.key,
    required this.humidity,
    required this.targetHumidity,
    this.onHumidityTap,
    required this.onEditRequested,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelValueWidget(
          label: 'Humidity',
          value: '$humidity%',
          onTap: onEditRequested,
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

    // Base line
    canvas.drawLine(Offset(0, barY), Offset(size.width, barY), linePaint);

    // Recommended range: 55–65%
    final lowX = scaleHelper.toX(55);
    final highX = scaleHelper.toX(65);
    canvas.drawRect(
      Rect.fromLTWH(lowX, barY - 7, highX - lowX, 7),
      recommendedPaint,
    );

    // Ticks every 10%
    for (int i = 20; i <= 80; i += 10) {
      final x = scaleHelper.toX(i);
      canvas.drawLine(Offset(x, barY - 5), Offset(x, barY + 5), tickPaint);
    }

    // Long ticks at 20, 50, 80
    for (int i in [20, 50, 80]) {
      final x = scaleHelper.toX(i);
      canvas.drawLine(Offset(x, barY - 10), Offset(x, barY + 10), tickPaint);
    }

    // Humidity bars
    final top = barY - 2;
    const thickness = 4.0;
    final hX = scaleHelper.toX(humidity);
    final tX = scaleHelper.toX(targetHumidity);

    if (humidity < targetHumidity) {
      canvas.drawRect(Rect.fromLTWH(0, top, hX, thickness), underPaint);
    } else {
      canvas.drawRect(Rect.fromLTWH(0, top, tX, thickness), underPaint);
      canvas.drawRect(Rect.fromLTWH(tX, top, hX - tX, thickness), overPaint);
    }

    // Target circle
    canvas.drawCircle(Offset(tX, barY), 4, targetPaint);

    // Labels
    final textY = barY + 10;
    _drawLabel(canvas, '20%', Offset(scaleHelper.toX(20), textY));
    _drawLabel(canvas, '50%', Offset(scaleHelper.toX(50) - 8, textY));
    _drawLabel(canvas, '80%', Offset(scaleHelper.toX(100) - 18, textY));
  }

  void _drawLabel(Canvas canvas, String text, Offset offset) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: Colors.grey[800], fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

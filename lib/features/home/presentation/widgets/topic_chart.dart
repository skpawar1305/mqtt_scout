import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/tree/topic_node.dart';
import '../../../../domain/models/mqtt_message.dart';

class TopicChart extends StatelessWidget {
  final TopicNode topicNode;
  final bool isDark;

  const TopicChart({
    super.key,
    required this.topicNode,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final points = _getPoints();

    if (points.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 200,
      padding: const EdgeInsets.only(right: 16, left: 0, top: 24, bottom: 0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Theme.of(context).dividerColor.withOpacity(0.1),
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Theme.of(context).dividerColor.withOpacity(0.1),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: _calculateInterval(points),
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _formatTimestamp(value),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                    textAlign: TextAlign.left,
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.2)),
          ),
          minX: points.first.x,
          maxX: points.last.x,
          minY: _getMinY(points),
          maxY: _getMaxY(points),
          lineBarsData: [
            LineChartBarData(
              spots: points,
              isCurved: true,
              color: Theme.of(context).colorScheme.primary,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor:  (touchedSpot) => Theme.of(context).cardColor,
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  final flSpot = barSpot;
                  return LineTooltipItem(
                    '${flSpot.y}\n${_formatFullTimestamp(flSpot.x)}',
                    TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  List<FlSpot> _getPoints() {
    final points = <FlSpot>[];
    // Sort messages by timestamp
    final sortedMessages = List<MqttMessage>.from(topicNode.messages)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    for (var msg in sortedMessages) {
      final val = double.tryParse(msg.payload);
      if (val != null) {
        points.add(FlSpot(msg.timestamp.millisecondsSinceEpoch.toDouble(), val));
      }
    }
    return points;
  }

  double _getMinY(List<FlSpot> points) {
    if (points.isEmpty) return 0;
    return points.map((e) => e.y).reduce((a, b) => a < b ? a : b) * 0.95; 
  }

  double _getMaxY(List<FlSpot> points) {
    if (points.isEmpty) return 0;
    return points.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.05;
  }

  double _calculateInterval(List<FlSpot> points) {
    if (points.isEmpty) return 1;
    final duration = points.last.x - points.first.x;
    if (duration == 0) return 1;
    return duration / 5; // Aim for 5 labels
  }

  String _formatTimestamp(double value) {
    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    return DateFormat('HH:mm:ss').format(date);
  }

  String _formatFullTimestamp(double value) {
    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }
}

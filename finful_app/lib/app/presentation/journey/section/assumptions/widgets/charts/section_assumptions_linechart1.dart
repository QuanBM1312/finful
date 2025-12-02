import 'package:finful_app/app/theme/theme.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _CustomGlowDotPainter extends FlDotPainter {
  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    // Glow layer 1
    canvas.drawCircle(
      offsetInCanvas,
      16.0,
      Paint()..color = FinfulColor.dotGlowLayer1,
    );

    // Core
    canvas.drawCircle(
      offsetInCanvas,
      7.0,
      Paint()..color = FinfulColor.brandPrimary,
    );

    // Viền den (stroke)
    canvas.drawCircle(
      offsetInCanvas,
      8.0,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  Size getSize(FlSpot spot) => const Size(16.0, 16.0);

  @override
  Color get mainColor => const Color(0xFF00E0FF);

  @override
  List<Object?> get props => [
    mainColor,
  ];

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    return this;
  }
}

class SectionAssumptionsLineChart1 extends StatefulWidget {
  const SectionAssumptionsLineChart1({
    super.key,
    required this.spots,

  });

  final List<FlSpot> spots;

  @override
  State<SectionAssumptionsLineChart1> createState() => _SectionAssumptionsLineChart1State();
}

class _SectionAssumptionsLineChart1State extends State<SectionAssumptionsLineChart1> {
  final int startYear = DateTime.now().year - 1; // last year

  @override
  Widget build(BuildContext context) {
    final visibleSpots = [widget.spots[1], widget.spots[2], widget.spots[3]];

    final lineTouchData = LineTouchData(
      enabled: false,
    );

    final lineBarsData = [
      LineChartBarData(
        spots: [widget.spots.first],
        isCurved: true,
        color: Colors.transparent,
        barWidth: Dimens.p_2,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, bar, index) {
            return FlDotCirclePainter(
              radius: 0.0,
              color: Colors.transparent,
              strokeWidth: 0.0,
              strokeColor: Colors.transparent,
            );
          },
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: visibleSpots,
        isCurved: true,
        curveSmoothness: 0.3,
        color: FinfulColor.brandPrimary,
        barWidth: Dimens.p_2,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, bar, index) {
            return _CustomGlowDotPainter();
          },
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              FinfulColor.brandPrimary.withValues(alpha: 0.3),
              FinfulColor.brandPrimary.withValues(alpha: 0.05),
            ],
            stops: const [0.3, 1.0],
          ),
        ),
      ),
      LineChartBarData(
        spots: [widget.spots.last],
        isCurved: true,
        color: Colors.transparent,
        barWidth: Dimens.p_2,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, bar, index) {
            return FlDotCirclePainter(
              radius: 0.0,
              color: Colors.transparent,
              strokeWidth: 0.0,
              strokeColor: Colors.transparent,
            );
          },
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];

    final titlesData = FlTitlesData(
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 1 || index > 3) {
              return const SizedBox();
            }

            final moneyText = NumberFormat.currency(
              locale: 'vi_VN',
              symbol: '',
              decimalDigits: 0,
            ).format(widget.spots[index].y);

            return Text(
              moneyText,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                height: Dimens.p_15 / Dimens.p_12,
                fontWeight: FontWeight.w400,
              ),
            );
          },
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 1 || index > 3) {
              return const SizedBox();
            }

            return Padding(
              padding: EdgeInsets.only(
                top: Dimens.p_5,
              ),
              child: Text(
                '${startYear + index}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  height: Dimens.p_15 / Dimens.p_12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          },
        ),
      ),
    );

    final gridData = FlGridData(
      show: false,
      drawVerticalLine: true,
      horizontalInterval: 5000000,
      verticalInterval: 1,
      getDrawingHorizontalLine: (_) => FlLine(
        color: Colors.white10,
        strokeWidth: 1,
        dashArray: [8, 6],
      ),
      getDrawingVerticalLine: (_) => FlLine(
        color: Colors.white10,
        strokeWidth: 1,
        dashArray: [8, 6],
      ),
    );

    final borderData = FlBorderData(
      show: false,
    );

    return AspectRatio(
      aspectRatio: 1.7275,
      child: Container(
        decoration: BoxDecoration(
          color: FinfulColor.cardBg,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Dimens.p_16,
          horizontal: Dimens.p_16,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return LineChart(
            LineChartData(
              lineTouchData: lineTouchData,
              lineBarsData: lineBarsData,
              titlesData: titlesData,
              gridData: gridData,
              borderData: borderData,
              minY: 0,
              minX: 0,
            ),
          );
        }),
      ),
    );
  }
}

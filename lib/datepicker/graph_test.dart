import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphTest extends StatelessWidget {
  const GraphTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              // color: Colors.blue,
              child: LineChart(LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 3),
                        FlSpot(1, 5),
                        FlSpot(2, 2),
                        FlSpot(4.9, 5),
                        FlSpot(6.8, 3.1),
                        FlSpot(8, 4),
                        FlSpot(9.5, 3),
                        FlSpot(11, 4),
                      ],
                      isCurved: true, //선을 곡선으로
                      color: Colors.yellow,
                      barWidth: 4,
                      isStrokeCapRound: true, //선 끝을 둥글게
                      dotData: FlDotData(show: true), // 데이터 포인트의 점 표시
                      belowBarData: BarAreaData(show: false),
                    )
                  ],
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1,
                        getTitlesWidget: leftTitleWidget,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: true),
                  lineTouchData:
                      LineTouchData(touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpots) {
                        return LineTooltipItem('${touchedSpots.y.toInt()}',
                            TextStyle(color: Colors.blue));
                      }).toList();
                    },
                  )))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('뒤로가기'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget leftTitleWidget(double value, TitleMeta meta) {
    String text;

    switch (value.toInt()) {
      case 1:
        text = '10k';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      case 7:
        text = '70k';
        break;
      default:
        return Container();
    }
    return Text(text);
  }
}

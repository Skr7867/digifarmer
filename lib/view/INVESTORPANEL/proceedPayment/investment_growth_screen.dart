import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AttractivePieChart extends StatefulWidget {
  const AttractivePieChart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AttractivePieChartState createState() => _AttractivePieChartState();
}

class _AttractivePieChartState extends State<AttractivePieChart> {
  int touchedIndex = -1;
  final List<Color> gradientColors = [
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Pie Chart
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!
                              .touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 2,
                    centerSpaceRadius: 30,
                    sections: showingSections(),
                  ),
                ),
              ),

              // Center Text
              Positioned.fill(
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          '₹45.2k',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(6, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 14.0 : 11.0;
      final radius = isTouched ? 70.0 : 60.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: gradientColors[0],
            value: 35,
            title: '35%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: _buildBadge(Icons.shopping_cart, Colors.blue),
            badgePositionPercentageOffset: 1.2,
          );
        case 1:
          return PieChartSectionData(
            color: gradientColors[1],
            value: 25,
            title: '25%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: _buildBadge(Icons.food_bank, Colors.purple),
            badgePositionPercentageOffset: 1.2,
          );
        case 2:
          return PieChartSectionData(
            color: gradientColors[2],
            value: 18,
            title: '18%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: _buildBadge(Icons.directions_car, Colors.orange),
            badgePositionPercentageOffset: 1.2,
          );
        case 3:
          return PieChartSectionData(
            color: gradientColors[3],
            value: 12,
            title: '12%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: _buildBadge(Icons.movie, Colors.green),
            badgePositionPercentageOffset: 1.2,
          );
        case 4:
          return PieChartSectionData(
            color: gradientColors[4],
            value: 6,
            title: '6%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: _buildBadge(Icons.health_and_safety, Colors.pink),
            badgePositionPercentageOffset: 1.2,
          );
        case 5:
          return PieChartSectionData(
            color: gradientColors[5],
            value: 4,
            title: '4%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: _buildBadge(Icons.shopping_bag, Colors.teal),
            badgePositionPercentageOffset: 1.2,
          );
        default:
          throw Error();
      }
    });
  }

  Widget _buildBadge(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(icon, size: 16, color: color),
    );
  }
}

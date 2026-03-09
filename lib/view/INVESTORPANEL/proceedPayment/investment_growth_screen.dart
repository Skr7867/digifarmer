import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AttractivePieChart extends StatefulWidget {
  final double investment;
  final double returns;
  final double maturity;

  const AttractivePieChart({
    super.key,
    required this.investment,
    required this.returns,
    required this.maturity,
  });

  @override
  State<AttractivePieChart> createState() => _AttractivePieChartState();
}

class _AttractivePieChartState extends State<AttractivePieChart> {
  int touchedIndex = -1;

  final List<Color> gradientColors = [Colors.blue, Colors.green];

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
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              /// PIE CHART
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

              /// CENTER TEXT
              Positioned.fill(
                child: Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
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
                          "₹${widget.maturity.toStringAsFixed(0)}",
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

  /// Dynamic Pie Sections
  List<PieChartSectionData> showingSections() {
    final investment = widget.investment;
    final returns = widget.returns;

    final total = investment + returns;

    final investmentPercent = (investment / total) * 100;
    final returnPercent = (returns / total) * 100;

    return [
      /// INVESTMENT PORTION
      PieChartSectionData(
        color: gradientColors[0],
        value: investmentPercent,
        title: '${investmentPercent.toStringAsFixed(0)}%',
        radius: touchedIndex == 0 ? 70 : 60,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        badgeWidget: _buildBadge(Icons.account_balance_wallet, Colors.blue),
        badgePositionPercentageOffset: 1.2,
      ),

      /// RETURNS PORTION
      PieChartSectionData(
        color: gradientColors[1],
        value: returnPercent,
        title: '${returnPercent.toStringAsFixed(0)}%',
        radius: touchedIndex == 1 ? 70 : 60,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        badgeWidget: _buildBadge(Icons.trending_up, Colors.green),
        badgePositionPercentageOffset: 1.2,
      ),
    ];
  }

  Widget _buildBadge(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(4),
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

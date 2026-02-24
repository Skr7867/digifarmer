import 'package:flutter/material.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioState();
}

class _PortfolioState extends State<PortfolioScreen> {
  int selectedFilter = 0;

  final filters = ["All", "Active", "Matured", "Pending"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F5F7),
      body: Column(
        children: [
          /// ================= HEADER =================
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff1C5D9F), Color(0xff2FA463)],
              ),
            ),
            child: Column(
              children: [
                /// Top Bar
                Row(
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.white),
                    const Spacer(),
                    const Text(
                      "My Portfolio",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.filter_alt_outlined, color: Colors.white),
                  ],
                ),

                const SizedBox(height: 20),

                /// Portfolio Card
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.15),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Total Portfolio Value",
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "₹1,47,250",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Invested: ₹1,25,000",
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "Profit: ₹22,250",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// ================= FILTERS =================
          ///
          Container(
            margin: EdgeInsets.all(8),
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (_, index) => _filterChip(index),
            ),
          ),

          /// ================= LIST =================
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                PortfolioCard(
                  title: "Organic Rice Farm",
                  subtitle: "Invested 2 months ago",
                  invested: "₹25,000",
                  current: "₹26,750",
                  tenure: "3 Years",
                  returns: "12% p.a.",
                  progress: .45,
                  remaining: "8 months remaining",
                  gain: "+7.0% gain",
                ),

                SizedBox(height: 16),

                PortfolioCard(
                  title: "Wheat Cultivation",
                  subtitle: "Invested 5 months ago",
                  invested: "₹50,000",
                  current: "₹54,500",
                  tenure: "2 Years",
                  returns: "10% p.a.",
                  progress: .30,
                  remaining: "19 months remaining",
                  gain: "+9.0% gain",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ================= FILTER CHIP =================
  Widget _filterChip(int index) {
    bool selected = selectedFilter == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = index;
        });
      },
      child: Container(
        height: 20,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.green : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          filters[index],
          style: TextStyle(
            color: selected ? Colors.white : Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// ================= PORTFOLIO CARD =================
class PortfolioCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String invested;
  final String current;
  final String tenure;
  final String returns;
  final double progress;
  final String remaining;
  final String gain;

  const PortfolioCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.invested,
    required this.current,
    required this.tenure,
    required this.returns,
    required this.progress,
    required this.remaining,
    required this.gain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.eco, color: Colors.green),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Active",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Values
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _info("Invested Amount", invested),
              _info("Current Value", current, valueColor: Colors.green),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _info("Tenure", tenure),
              _info("Expected Returns", returns, valueColor: Colors.green),
            ],
          ),

          const SizedBox(height: 16),

          /// Progress
          Text("Progress", style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 6),

          LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
            color: Colors.blue,
          ),

          const SizedBox(height: 6),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              remaining,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// Bottom Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                gain,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "View Details",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(String title, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}

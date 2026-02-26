import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../../res/fonts/app_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= HEADER =================
            Container(
              padding: const EdgeInsets.fromLTRB(18, 50, 18, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: Theme.of(context).brightness == Brightness.dark
                      ? [Colors.black87, Colors.black54]
                      : [Color(0xff1C6C8C), Color(0xff2FA463)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  /// Top Row
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/150?img=5",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back,",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Sarah Johnson",
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.notifications_none,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// Portfolio Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Total Portfolio Value",
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "₹2,45,000",
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "+12.5% ↑",
                          style: TextStyle(color: Colors.lightGreenAccent),
                        ),
                        const SizedBox(height: 18),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Active Investments",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "8",
                                  style: TextStyle(
                                    color: Theme.of(context).cardColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Monthly Returns",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "₹12,400",
                                  style: TextStyle(
                                    color: Theme.of(context).cardColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ================= BODY =================
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Invested + Current Value
                  Row(
                    children: [
                      Expanded(
                        child: _smallCard(
                          icon: Icons.account_balance_wallet,
                          title: "Total Invested",
                          value: "₹2,18,000",
                          percent: "+8.2%",
                          color: const Color(0xffDFF3E7),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _smallCard(
                          icon: Icons.show_chart,
                          title: "Current Value",
                          value: "₹2,45,000",
                          percent: "+15.3%",
                          color: const Color(0xffE6EDFF),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  /// Expected Maturity
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xffF2ECFF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.event_available, color: Colors.purple),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Expected Maturity\nNext 3 months",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Text(
                              "₹3,25,000",
                              style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: .78,
                            minHeight: 8,
                            backgroundColor: Colors.purple.shade100,
                            valueColor: const AlwaysStoppedAnimation(
                              Colors.purple,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text("78%"),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Active Investments Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Active Investments",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  _investmentTile(
                    title: "Farm Name",
                    subtitle: "Maharashtra • 6 months",
                    value: "₹45,000",
                    roi: "+18% ROI",
                  ),

                  const SizedBox(height: 12),

                  _investmentTile(
                    title: "Wheat Cultivation",
                    subtitle: "Punjab • 4 months",
                    value: "₹32,000",
                    roi: "+15% ROI",
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Quick Actions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: _actionCard(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.newInvestmentScreen,
                            );
                          },
                          title: "New Investment",
                          subtitle: "Browse opportunities",
                          color: const Color(0xff2FA463),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _actionCard(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.portFolioScreen,
                            );
                          },
                          title: "Portfolio",
                          subtitle: "View details",
                          color: const Color(0xff3B6FD8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= Widgets =================

  Widget _smallCard({
    required IconData icon,
    required String title,
    required String value,
    required String percent,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(percent, style: const TextStyle(color: Colors.green)),
        ],
      ),
    );
  }

  Widget _investmentTile({
    required String title,
    required String subtitle,
    required String value,
    required String roi,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(child: Icon(Icons.eco)),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(roi, style: const TextStyle(color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_forward, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

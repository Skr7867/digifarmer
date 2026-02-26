import 'package:flutter/material.dart';

class WorkerHomeScreen extends StatelessWidget {
  const WorkerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= HEADER =================
            Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 16,
                right: 16,
                bottom: 20,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff1E88E5), Color(0xff2BB673)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/100",
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.notifications_none, color: Colors.white),
                          SizedBox(width: 5),
                          CircleAvatar(radius: 4, backgroundColor: Colors.red),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  const Text(
                    "Welcome Back!",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const Text(
                    "Rajesh Kumar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _TopStat(title: "Tasks Today", value: "5"),
                      _TopStat(title: "Completed", value: "2"),
                      _TopStat(title: "Pending", value: "3"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ================= TODAY TASKS =================
            _sectionTitle("Today's Tasks", "Dec 29, 2024"),

            _taskCard(
              statusColor: Colors.orange,
              statusText: "In Progress",
              title: "Irrigation System Check",
              plot: "Plot A1 - Nashik, Maharashtra",
              area: "5.2 Acres",
              time: "9:00 AM – 11:00 AM",
              buttonText: "Continue",
              buttonColor: Colors.orange,
            ),

            _taskCard(
              statusColor: Colors.green,
              statusText: "Completed",
              title: "Fertilizer Application",
              plot: "Plot B3 - Pune, Maharashtra",
              area: "3.8 Acres",
              time: "6:00 AM – 8:00 AM",
              buttonText: "View",
              buttonColor: Colors.green,
            ),

            _taskCard(
              statusColor: Colors.blue,
              statusText: "Pending",
              title: "Soil Testing & Analysis",
              plot: "Plot C2 - Nashik, Maharashtra",
              area: "4.5 Acres",
              time: "11:30 AM – 1:00 PM",
              buttonText: "Start Task",
              buttonColor: Colors.blue,
            ),

            _taskCard(
              statusColor: Colors.purple,
              statusText: "Pending",
              title: "Pest Control Inspection",
              plot: "Plot A1 - Nashik, Maharashtra",
              area: "5.2 Acres",
              time: "2:00 PM – 4:00 PM",
              buttonText: "Start Task",
              buttonColor: Colors.purple,
            ),

            const SizedBox(height: 20),

            /// ================= ASSIGNED LANDS =================
            _sectionTitle("Assigned Lands", "4 Active"),

            _assignedLandCard(
              title: "Plot A1 - Agricultural Land",
              location: "Nashik, Maharashtra",
              crop: "Wheat Crop",
              cropColor: Colors.green,
            ),

            _assignedLandCard(
              title: "Plot B3 - Organic Farm",
              location: "Pune, Maharashtra",
              crop: "Vegetables",
              cropColor: Colors.green,
            ),

            _assignedLandCard(
              title: "Plot C2 - Mixed Farming",
              location: "Nashik, Maharashtra",
              crop: "Corn & Soy",
              cropColor: Colors.orange,
            ),

            _assignedLandCard(
              title: "Plot D5 - Fruit Orchard",
              location: "Satara, Maharashtra",
              crop: "Mango Trees",
              cropColor: Colors.red,
            ),

            const SizedBox(height: 20),

            /// ================= QUICK ACTIONS =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Quick Actions",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.5,
                children: const [
                  _QuickAction(title: "Mark Attendance"),
                  _QuickAction(title: "Upload Photo"),
                  _QuickAction(title: "Daily Report"),
                  _QuickAction(title: "Contact Support"),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// ================= WIDGETS =================

  static Widget _sectionTitle(String title, String trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            trailing,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  static Widget _taskCard({
    required Color statusColor,
    required String statusText,
    required String title,
    required String plot,
    required String area,
    required String time,
    required String buttonText,
    required Color buttonColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(color: statusColor, fontSize: 11),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Priority: High",
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(plot, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 8),
          Text(time, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              onPressed: () {},
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _assignedLandCard({
    required String title,
    required String location,
    required String crop,
    required Color cropColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            location,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: cropColor.withOpacity(.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(crop, style: TextStyle(color: cropColor, fontSize: 12)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2BB673),
              ),
              onPressed: () {},
              child: const Text("View Land Details"),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= SMALL WIDGETS =================

class _TopStat extends StatelessWidget {
  final String title;
  final String value;

  const _TopStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String title;

  const _QuickAction({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

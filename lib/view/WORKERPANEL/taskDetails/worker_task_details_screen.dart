import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:flutter/material.dart';

import '../../../res/color/app_colors.dart';

class WorkerTaskDetailsScreen extends StatelessWidget {
  const WorkerTaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F8),
      appBar: CustomAppBar(
        title: "Task Details",
        gradient: LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// TASK CARD
            _taskCard(),

            const SizedBox(height: 16),

            /// LOCATION
            _locationCard(),

            const SizedBox(height: 16),

            /// INSTRUCTIONS
            _instructionsCard(),

            const SizedBox(height: 16),

            /// EQUIPMENT
            _equipmentCard(),

            const SizedBox(height: 16),

            /// PROGRESS
            _progressCard(),

            const SizedBox(height: 16),

            /// CONTACT
            _contactCard(),

            const SizedBox(height: 24),

            /// ACTION BUTTONS
            _bottomButtons(context),
          ],
        ),
      ),
    );
  }

  /// TASK HEADER CARD
  static Widget _taskCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "In Progress",
                  style: TextStyle(fontSize: 12, color: Colors.orange),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Priority: High",
                style: TextStyle(color: Colors.grey),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            "Irrigation System Check",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          const Text(
            "Plot A1 - Agricultural Land",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _infoBox(
                  Icons.access_time,
                  "Duration",
                  "9:00 AM - 11:00 AM\n2 hours",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoBox(
                  Icons.square_foot,
                  "Area",
                  "5.2 Acres\nAgricultural land",
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Started: 9:15 AM"),
              Text("Deadline: 11:00 AM", style: TextStyle(color: Colors.red)),
            ],
          ),
        ],
      ),
    );
  }

  /// LOCATION CARD
  static Widget _locationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on, color: Colors.green),
              SizedBox(width: 8),
              Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xffF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Plot A1 - Agricultural Land",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  "Village Shirdi, Tehsil Rahata, Nashik, Maharashtra 423109",
                ),
                SizedBox(height: 6),
                Text(
                  "Lat: 19.7645° N   Long: 74.4779° E",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.directions),
                  label: const Text("Get Directions"),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// INSTRUCTIONS
  static Widget _instructionsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.description, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                "Instructions",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 12),

          _instructionItem(
            "1",
            "Check all irrigation pipes and connections",
            "Inspect for leaks, blockages, or damaged components",
          ),

          _instructionItem(
            "2",
            "Test water pressure and flow rate",
            "Ensure optimal water distribution",
          ),

          _instructionItem(
            "3",
            "Clean and adjust sprinkler heads",
            "Remove debris and ensure proper spray patterns",
          ),

          _instructionItem(
            "4",
            "Document findings with photos",
            "Take pictures of issues or completed work",
          ),
        ],
      ),
    );
  }

  /// EQUIPMENT
  static Widget _equipmentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.build, color: Colors.purple),
              SizedBox(width: 8),
              Text(
                "Required Equipment",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 7,
            runSpacing: 10,
            children: const [
              _equipmentBox("Tools", "Wrench set, screwdrivers"),
              _equipmentBox("Meter", "Water pressure gauge"),
              _equipmentBox("Cleaning", "Brush, cleaning cloth"),
              _equipmentBox("Camera", "For documentation"),
            ],
          ),
        ],
      ),
    );
  }

  /// PROGRESS
  static Widget _progressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Progress", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("25%", style: TextStyle(color: Colors.green)),
            ],
          ),

          const SizedBox(height: 8),

          const LinearProgressIndicator(
            value: .25,
            backgroundColor: Color(0xffE5E7EB),
            color: Colors.green,
          ),

          const SizedBox(height: 16),

          _progressItem("Initial inspection", "Completed", Colors.green),
          _progressItem("Pressure testing", "In Progress", Colors.orange),
          _progressItem("Sprinkler adjustment", "Pending", Colors.grey),
          _progressItem("Documentation", "Pending", Colors.grey),
        ],
      ),
    );
  }

  /// CONTACT
  static Widget _contactCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
              "https://randomuser.me/api/portraits/men/32.jpg",
            ),
          ),

          const SizedBox(width: 12),

          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ramesh Patil",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Field Supervisor", style: TextStyle(color: Colors.grey)),
            ],
          ),

          const Spacer(),

          CircleAvatar(
            backgroundColor: Colors.green.shade100,
            child: const Icon(Icons.call, color: Colors.green),
          ),

          const SizedBox(width: 10),

          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: const Icon(Icons.chat, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  /// BUTTONS
  static Widget _bottomButtons(context) {
    return Row(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        RoundButton(
          height: 40,
          buttonColor: AppColors.redColor,
          title: 'Pause Task',
          onPress: () {},
        ),
        const SizedBox(width: 10),
        RoundButton(
          height: 40,
          buttonColor: AppColors.greenColor,
          title: 'Mark Complete',
          onPress: () {
            Navigator.pushNamed(context, RoutesName.workerTaskSubmit);
          },
        ),
      ],
    );
  }

  /// COMMON CARD STYLE
  static BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.grey.withOpacity(.1),
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static Widget _infoBox(IconData icon, String title, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  static Widget _instructionItem(String number, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(radius: 12, child: Text(number)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _progressItem(String title, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.circle, size: 12, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(title)),
          Text(status, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}

class _equipmentBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const _equipmentBox(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

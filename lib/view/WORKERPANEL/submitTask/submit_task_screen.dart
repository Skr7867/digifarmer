import 'package:flutter/material.dart';

import '../../../res/customeWidgets/custom_app_bar.dart';

class WorkerTaskSubmitScreen extends StatefulWidget {
  const WorkerTaskSubmitScreen({super.key});

  @override
  State<WorkerTaskSubmitScreen> createState() => _WorkerTaskSubmitScreenState();
}

class _WorkerTaskSubmitScreenState extends State<WorkerTaskSubmitScreen> {
  double progress = 25;

  final List<bool> checklist = [true, true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F8),

      appBar: CustomAppBar(
        title: "Work Update",
        gradient: LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(children: [Text('Save Draft')]),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _taskCard(),

            const SizedBox(height: 16),

            _progressSection(),

            const SizedBox(height: 16),

            _photoSection(),

            const SizedBox(height: 16),

            _notesSection(),

            const SizedBox(height: 16),

            _checklistSection(),

            const SizedBox(height: 16),

            _timeTrackingSection(),

            const SizedBox(height: 80),
          ],
        ),
      ),

      bottomNavigationBar: _bottomButtons(),
    );
  }

  Widget _taskCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
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

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Irrigation System Check",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  "Plot A1 - Agricultural Land",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 6),
                Text("Started: 9:15 AM"),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "In Progress",
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Progress Update",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 16),

          const Text("Current Progress"),

          Slider(
            value: progress,
            min: 0,
            max: 100,
            divisions: 4,
            activeColor: Colors.orange,
            onChanged: (value) {
              setState(() {
                progress = value;
              });
            },
          ),

          Center(
            child: Text(
              "${progress.toInt()}% Complete",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(child: _infoBox("Time Spent", "1h 30m")),
              const SizedBox(width: 10),
              Expanded(child: _infoBox("Est. Remaining", "30m")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _photoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Work Photos",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("2/5 uploaded", style: TextStyle(color: Colors.grey)),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              _photoBox(
                "https://images.unsplash.com/photo-1601315488950-3b5047998b38",
              ),
              const SizedBox(width: 10),
              _photoBox(
                "https://images.unsplash.com/photo-1501004318641-b39e6451bec6",
              ),
              const SizedBox(width: 10),

              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.grey),
                    Text(
                      "Add Photo",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "• Take clear, well-lit photos\n"
              "• Include before and after shots\n"
              "• Show any issues or completed tasks",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Work Notes",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Checked irrigation pipes in sections A and B. Found minor leak...",
              style: TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(child: _tag("Minor Issues")),
              const SizedBox(width: 10),
              Expanded(child: _tag("Excellent")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _checklistSection() {
    List<String> tasks = [
      "Checked all irrigation pipes and connections",
      "Tested water pressure and flow rate",
      "Cleaned and adjusted sprinkler heads",
      "Documented findings with photos",
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Task Checklist",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Column(
            children: List.generate(tasks.length, (index) {
              return CheckboxListTile(
                value: checklist[index],
                onChanged: (value) {
                  setState(() {
                    checklist[index] = value!;
                  });
                },
                title: Text(tasks[index]),
                controlAffinity: ListTileControlAffinity.leading,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _timeTrackingSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Time Tracking",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade100,
                  foregroundColor: Colors.orange,
                ),
                onPressed: () {},
                child: const Text("Take Break"),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: _timeBox("1h 30m", "Work Time", Colors.green)),
              const SizedBox(width: 10),
              Expanded(child: _timeBox("15m", "Break Time", Colors.orange)),
              const SizedBox(width: 10),
              Expanded(child: _timeBox("1h 45m", "Total Time", Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade200,
              ),
              onPressed: () {},
              child: const Text("Pause Task"),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {},
              child: const Text("Submit Update"),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _photoBox(String url) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(url, width: 80, height: 80, fit: BoxFit.cover),
        ),
        Positioned(
          right: 0,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.red,
            child: const Icon(Icons.close, size: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(text)),
    );
  }

  Widget _infoBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _timeBox(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          Text(label),
        ],
      ),
    );
  }
}

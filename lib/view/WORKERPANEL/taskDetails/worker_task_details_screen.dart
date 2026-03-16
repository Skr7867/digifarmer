import 'package:digifarmer/blocs/WORKERPANEL/taskDetails/task_details_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/component/internet_exception.dart';
import '../../../main.dart';
import '../../../model/WORKERPANEL/taskDetails/task_details_model.dart';
import '../../../res/color/app_colors.dart';

class WorkerTaskDetailsScreen extends StatefulWidget {
  final String taskId;
  const WorkerTaskDetailsScreen({super.key, required this.taskId});

  @override
  State<WorkerTaskDetailsScreen> createState() =>
      _WorkerTaskDetailsScreenState();
}

class _WorkerTaskDetailsScreenState extends State<WorkerTaskDetailsScreen> {
  late TaskDetailsBloc taskDetailsBloc;

  @override
  void initState() {
    super.initState();
    taskDetailsBloc = TaskDetailsBloc(taskDetailsRepository: getIt());
  }

  @override
  void dispose() {
    taskDetailsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F8),
      appBar: CustomAppBar(
        title: "Task Details",
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        automaticallyImplyLeading: true,
      ),
      body: BlocProvider(
        create: (_) => taskDetailsBloc..add(TaskDetailsFetched(widget.taskId)),
        child: BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
          builder: (BuildContext context, state) {
            switch (state.taskDetails.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());

              case Status.error:
                if (state.taskDetails.message == 'No Internet Connection') {
                  return Center(
                    child: InternetException(
                      onPress: () {
                        taskDetailsBloc.add(TaskDetailsFetched(widget.taskId));
                      },
                    ),
                  );
                }
                return Center(
                  child: Text(
                    state.taskDetails.message.toString(),
                    style: const TextStyle(fontFamily: AppFonts.popins),
                  ),
                );

              case Status.completed:
                if (state.taskDetails.data == null) {
                  return const Center(
                    child: Text(
                      'No data Found',
                      style: TextStyle(fontFamily: AppFonts.popins),
                    ),
                  );
                }
                final taskData = state.taskDetails.data!;
                return _buildTaskDetailsContent(context, taskData);

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildTaskDetailsContent(
    BuildContext context,
    TaskDetailModel taskData,
  ) {
    final task = taskData.dashboard?.task;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// TASK CARD
          _taskCard(task),

          const SizedBox(height: 16),

          /// LOCATION
          _locationCard(task),

          const SizedBox(height: 16),

          /// INSTRUCTIONS (Static - keep as is)
          _instructionsCard(),

          const SizedBox(height: 16),

          /// EQUIPMENT
          _equipmentCard(taskData.dashboard?.equipment),

          const SizedBox(height: 16),

          /// PROGRESS
          _progressCard(taskData.dashboard?.summary),

          const SizedBox(height: 16),

          /// CONTACT (Static - keep as is)
          _contactCard(),

          const SizedBox(height: 24),

          /// ACTION BUTTONS
          _bottomButtons(context, task?.status, task),
        ],
      ),
    );
  }

  /// TASK HEADER CARD with API data
  Widget _taskCard(Task? task) {
    // Determine status color and text
    String statusText = task?.status ?? 'PENDING';
    Color statusColor = _getStatusColor(statusText);
    String priorityText = task?.priority ?? 'MEDIUM';
    Color priorityColor = _getPriorityColor(priorityText);

    // Format dates
    String startTime = _formatTime(task?.dates?.start);
    String dueTime = _formatTime(task?.dates?.due);
    String startDate = _formatDate(task?.dates?.start);
    String dueDate = _formatDate(task?.dates?.due);

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
                  color: statusColor.withOpacity(.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: priorityColor.withOpacity(.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Priority: $priorityText",
                  style: TextStyle(
                    fontSize: 12,
                    color: priorityColor,
                    fontFamily: AppFonts.popins,
                  ),
                ),
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

          Text(
            task?.taskTitle ?? "Irrigation System Check",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            task?.taskId ?? "Plot A1 - Agricultural Land",
            style: const TextStyle(
              color: Colors.grey,
              fontFamily: AppFonts.popins,
            ),
          ),

          if (task?.taskDescription != null) ...[
            const SizedBox(height: 8),
            Text(
              task!.taskDescription!,
              style: const TextStyle(fontSize: 14, fontFamily: AppFonts.popins),
            ),
          ],

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _infoBox(
                  Icons.access_time,
                  "Duration",
                  task?.dates != null
                      ? "$startTime -$dueTime"
                      : "9:00 AM - 11:00 AM\n2 hours",
                  context,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoBox(
                  Icons.square_foot,
                  "Task Type",
                  task?.taskType ?? "Agricultural\nland",
                  context,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (task?.dates != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Started: $startDate",
                  style: const TextStyle(
                    fontFamily: AppFonts.popins,
                    fontSize: 10,
                  ),
                ),
                Text(
                  "Deadline: $dueDate",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// LOCATION CARD with API data
  Widget _locationCard(Task? task) {
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
              Text(
                "Location",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xffF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (task?.location != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    "Country: ${task!.location!.country}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  Text(
                    "Timezone: ${task.location!.timezone}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// INSTRUCTIONS (Static - unchanged but with font family)
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
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

  /// EQUIPMENT with API data
  Widget _equipmentCard(List<dynamic>? equipment) {
    // If no equipment data from API, show static equipment
    if (equipment == null || equipment.isEmpty) {
      return _staticEquipmentCard();
    }

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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // If equipment is from API and has data, display it
          // For now, we'll show static equipment since API equipment is empty
          Wrap(
            spacing: 7,
            runSpacing: 10,
            children: const [
              _EquipmentBox("Tools", "Wrench set, screwdrivers"),
              _EquipmentBox("Meter", "Water pressure gauge"),
              _EquipmentBox("Cleaning", "Brush, cleaning cloth"),
              _EquipmentBox("Camera", "For documentation"),
            ],
          ),
        ],
      ),
    );
  }

  /// Static equipment card (fallback)
  static Widget _staticEquipmentCard() {
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 7,
            runSpacing: 10,
            children: const [
              _EquipmentBox("Tools", "Wrench set, screwdrivers"),
              _EquipmentBox("Meter", "Water pressure gauge"),
              _EquipmentBox("Cleaning", "Brush, cleaning cloth"),
              _EquipmentBox("Camera", "For documentation"),
            ],
          ),
        ],
      ),
    );
  }

  /// PROGRESS with API data
  Widget _progressCard(TaskSummary? summary) {
    double progressValue = summary?.completionPercentage != null
        ? summary!.completionPercentage! / 100
        : 0.25;

    int completed = summary?.completedItems ?? 0;
    int total = summary?.totalItems ?? 0;
    int hoursWorked = summary?.totalHoursWorked ?? 0;

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
                "Progress",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
              Text(
                "${summary?.completionPercentage ?? 25}%",
                style: const TextStyle(
                  color: Colors.green,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: const Color(0xffE5E7EB),
            color: Colors.green,
          ),

          const SizedBox(height: 16),

          if (summary != null) ...[
            _progressItem(
              "Completed Items",
              "$completed/$total",
              completed == total ? Colors.green : Colors.orange,
            ),
            _progressItem(
              "Hours Worked",
              "$hoursWorked hrs",
              hoursWorked > 0 ? Colors.green : Colors.grey,
            ),
          ] else ...[
            _progressItem("Initial inspection", "Completed", Colors.green),
            _progressItem("Pressure testing", "In Progress", Colors.orange),
            _progressItem("Sprinkler adjustment", "Pending", Colors.grey),
            _progressItem("Documentation", "Pending", Colors.grey),
          ],
        ],
      ),
    );
  }

  /// CONTACT (Static - unchanged but with font family)
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
              Text(
                "Field Supervisor",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: AppFonts.popins,
                ),
              ),
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

  /// BUTTONS with status-based logic
  /// BUTTONS with status-based logic
  Widget _bottomButtons(BuildContext context, String? status, Task? task) {
    bool isCompleted = status?.toUpperCase() == 'COMPLETED';
    bool isInProgress = status?.toUpperCase() == 'IN_PROGRESS';

    // Get the task ID from the task object
    String taskId = task?.id ?? ''; // or task?.taskId based on your model

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!isCompleted)
          RoundButton(
            height: 40,
            buttonColor: AppColors.redColor,
            title: isInProgress ? 'Update Task' : 'Start Task',
            onPress: () {
              if (taskId.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  RoutesName.workerTaskUpdateScreen,
                  arguments: {'taskId': taskId},
                );
              } else {
                // Show error if task ID is missing
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Task ID not found'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        if (!isCompleted) const SizedBox(width: 10),
        RoundButton(
          width: 300,
          height: 40,
          buttonColor: AppColors.greenColor,
          title: isCompleted ? 'Task Completed' : 'Mark Complete',
          onPress: () {
            if (isCompleted) {
              // Navigate to summary screen
            } else {
              //Navigator.pushNamed(context, RoutesName.workerTaskSubmit);
              Navigator.pushNamed(
                context,
                RoutesName.completeTaskScreen,
                arguments: {'taskId': taskId, 'taskTitle': task!.taskTitle},
              );
            }
          },
        ),
      ],
    );
  }

  /// Helper methods
  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
        return Colors.green;
      case 'IN_PROGRESS':
        return Colors.orange;
      case 'PENDING':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toUpperCase()) {
      case 'HIGH':
        return Colors.red;
      case 'MEDIUM':
        return Colors.orange;
      case 'LOW':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatTime(String? dateTimeString) {
    if (dateTimeString == null) return '9:00 AM';
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final hour = dateTime.hour;
      final minute = dateTime.minute;
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      return '9:00 AM';
    }
  }

  String _formatDate(String? dateTimeString) {
    if (dateTimeString == null) return 'Mar 14, 2026';
    try {
      final dateTime = DateTime.parse(dateTimeString);
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
    } catch (e) {
      return 'Mar 14, 2026';
    }
  }

  /// COMMON CARD STYLE (Static - unchanged)
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

  static Widget _infoBox(IconData icon, String title, String text, context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.popins,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _instructionItem(String number, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            child: Text(
              number,
              style: const TextStyle(fontFamily: AppFonts.popins),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: AppFonts.popins,
                  ),
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
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontFamily: AppFonts.popins),
            ),
          ),
          Text(
            status,
            style: TextStyle(color: color, fontFamily: AppFonts.popins),
          ),
        ],
      ),
    );
  }
}

class _EquipmentBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const _EquipmentBox(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, fontFamily: AppFonts.popins),
          ),
        ],
      ),
    );
  }
}

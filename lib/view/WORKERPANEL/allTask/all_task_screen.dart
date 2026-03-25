import 'package:digifarmer/blocs/WORKERPANEL/alltask/all_task_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/model/WORKERPANEL/alltask/all_task_model.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/WORKERPANEL/startTask/start_task_bloc.dart';
import '../../../config/component/internet_exception.dart';
import '../../../main.dart';
import '../../../res/color/app_colors.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  late AllTaskBloc allTaskBloc;

  @override
  void initState() {
    super.initState();
    allTaskBloc = AllTaskBloc(allTaskRepository: getIt());
  }

  @override
  void dispose() {
    allTaskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'All Task',
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      backgroundColor: const Color(0xffF4F6F9),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => allTaskBloc..add(AllTaskFetched())),
          BlocProvider(create: (context) => StartTaskBloc(repository: getIt())),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<StartTaskBloc, StartTaskState>(
              listener: (context, startState) {
                if (startState.startTaskResponse.status == Status.loading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                }

                if (startState.startTaskResponse.status == Status.completed) {
                  Navigator.pop(context); // close loader

                  final taskId = startState.startTaskResponse.data?.task?.id;

                  allTaskBloc.add(AllTaskFetched());

                  Navigator.pushNamed(
                    context,
                    RoutesName.workerTaskDetails,
                    arguments: {'leadId': taskId},
                  );
                }

                if (startState.startTaskResponse.status == Status.error) {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        startState.startTaskResponse.message.toString(),
                        style: const TextStyle(fontFamily: AppFonts.popins),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<AllTaskBloc, AllTaskState>(
            builder: (BuildContext context, state) {
              switch (state.allTask.status) {
                /// ================= ALL TASK LOADING =================
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());

                /// ================= ALL TASK ERROR =================
                case Status.error:
                  if (state.allTask.message == 'No Internet Connection') {
                    return Center(
                      child: InternetException(
                        onPress: () {
                          allTaskBloc.add(AllTaskFetched());
                        },
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      state.allTask.message.toString(),
                      style: const TextStyle(fontFamily: AppFonts.popins),
                    ),
                  );

                /// ================= ALL TASK COMPLETED =================
                case Status.completed:
                  if (state.allTask.data == null) {
                    return const Center(
                      child: Text(
                        'No data Found',
                        style: TextStyle(fontFamily: AppFonts.popins),
                      ),
                    );
                  }

                  final allTaskData = state.allTask.data!;
                  return _buildTaskContent(context, allTaskData);

                /// ================= DEFAULT =================
                case Status.initial:
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTaskContent(BuildContext context, AllTaskModel allTaskData) {
    final tasks = allTaskData.tasks ?? [];
    final stats = allTaskData.stats;

    // Separate tasks by status
    final inProgressTasks = tasks
        .where((task) => task.status == 'inProgress')
        .toList();
    final completedTasks = tasks
        .where((task) => task.status == 'completed')
        .toList();
    final pendingTasks = tasks
        .where((task) => task.status == 'pending')
        .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          /// ================= STATS SECTION =================
          if (stats != null) _buildStatsSection(context, stats),

          const SizedBox(height: 20),

          /// ================= TODAY'S TASKS SECTION =================
          _buildTodayTasksSection(
            context,
            inProgressTasks,
            completedTasks,
            pendingTasks,
          ),

          const SizedBox(height: 20),

          /// ================= ASSIGNED LANDS SECTION =================
          _buildAssignedLandsSection(context, tasks),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, Stats stats) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total', stats.total ?? 0, Colors.blue),
          _buildStatItem('In Progress', stats.inProgress ?? 0, Colors.orange),
          _buildStatItem('Pending', stats.pending ?? 0, Colors.red),
          _buildStatItem('Completed', stats.completed ?? 0, Colors.green),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: color,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontFamily: AppFonts.popins,
          ),
        ),
      ],
    );
  }

  Widget _buildTodayTasksSection(
    BuildContext context,
    List<Tasks> inProgressTasks,
    List<Tasks> completedTasks,
    List<Tasks> pendingTasks,
  ) {
    // Get today's date
    String todayDate = _getFormattedDate();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Tasks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: AppFonts.popins,
                ),
              ),
              Text(
                todayDate,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ),

        /// In Progress Section
        if (inProgressTasks.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "In Progress",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const Spacer(),
                Text(
                  "${inProgressTasks.length} Tasks",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 16, thickness: 1, indent: 16, endIndent: 16),
          ...inProgressTasks.map((task) {
            return _buildInProgressTaskCard(context, task);
          }),
        ],

        const SizedBox(height: 16),

        /// Pending Section
        if (pendingTasks.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Pending",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const Spacer(),
                Text(
                  "${pendingTasks.length} Tasks",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 16, thickness: 1, indent: 16, endIndent: 16),
          ...pendingTasks.map((task) {
            return _buildPendingTaskCard(context, task);
          }),
        ],

        const SizedBox(height: 16),

        /// Completed Section
        if (completedTasks.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Completed",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const Spacer(),
                Text(
                  "${completedTasks.length} Tasks",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 16, thickness: 1, indent: 16, endIndent: 16),
          ...completedTasks.map((task) {
            return _buildCompletedTaskCard(context, task);
          }),
        ],

        if (inProgressTasks.isEmpty &&
            completedTasks.isEmpty &&
            pendingTasks.isEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Center(
              child: Text(
                "No tasks available",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInProgressTaskCard(BuildContext context, Tasks task) {
    // Format time range based on task type
    String timeRange = _formatTimeRange(task.taskType ?? 'Daily');

    // Format due date if available
    String dueDateText = '';
    if (task.dueDate != null) {
      final dueDate = DateTime.parse(task.dueDate!);
      final now = DateTime.now();
      final difference = dueDate.difference(now).inDays;

      if (difference > 0) {
        dueDateText = 'Due in $difference day${difference > 1 ? 's' : ''}';
      } else if (difference == 0) {
        dueDateText = 'Due today';
      } else {
        dueDateText =
            'Overdue by ${-difference} day${-difference > 1 ? 's' : ''}';
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.taskTitle ?? 'No Title',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: AppFonts.popins,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  task.priority?.toUpperCase() ?? 'MEDIUM',
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPriorityColor(task.priority),
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            task.land?.landTitle ?? 'No Land',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontFamily: AppFonts.popins,
            ),
          ),
          if (task.land?.address != null) ...[
            const SizedBox(height: 2),
            Text(
              _getLocationFromLand(task.land),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontFamily: AppFonts.popins,
              ),
            ),
          ],
          const SizedBox(height: 12),

          /// Time and Type Row
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                timeRange,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: AppFonts.popins,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.category, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                task.taskType ?? 'Task',
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),

          /// Due Date
          if (dueDateText.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.event,
                  size: 16,
                  color: dueDateText.contains('Overdue')
                      ? Colors.red
                      : Colors.orange,
                ),
                const SizedBox(width: 4),
                Text(
                  dueDateText,
                  style: TextStyle(
                    fontSize: 13,
                    color: dueDateText.contains('Overdue')
                        ? Colors.red
                        : Colors.orange,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 12),

          /// Continue Button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutesName.workerTaskDetails,
                  arguments: {'leadId': task.id},
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontFamily: AppFonts.popins,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingTaskCard(BuildContext context, Tasks task) {
    String timeRange = _formatTimeRange(task.taskType ?? 'Daily');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.taskTitle ?? 'No Title',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: AppFonts.popins,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  task.priority?.toUpperCase() ?? 'MEDIUM',
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPriorityColor(task.priority),
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            task.land?.landTitle ?? 'No Land',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                timeRange,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: AppFonts.popins,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.category, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                task.taskType ?? 'Task',
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutesName.workerTaskDetails,
                  arguments: {'leadId': task.id},
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                  fontFamily: AppFonts.popins,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedTaskCard(BuildContext context, Tasks task) {
    String timeRange = _formatTimeRange(task.taskType ?? 'Daily');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.taskTitle ?? 'No Title',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: AppFonts.popins,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'DONE',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            task.land?.landTitle ?? 'No Land',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                timeRange,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: AppFonts.popins,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.category, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                task.taskType ?? 'Task',
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutesName.workerTaskDetails,
                  arguments: {'leadId': task.id},
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: const Text(
                'View',
                style: TextStyle(
                  fontFamily: AppFonts.popins,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedLandsSection(BuildContext context, List<Tasks> tasks) {
    // Get unique lands from tasks
    final uniqueLands = <String, Map<String, dynamic>>{};

    for (var task in tasks) {
      if (task.land != null && task.land!.sId != null) {
        final landId = task.land!.sId!;
        if (!uniqueLands.containsKey(landId)) {
          uniqueLands[landId] = {'land': task.land!, 'taskCount': 1};
        } else {
          uniqueLands[landId]!['taskCount'] =
              uniqueLands[landId]!['taskCount'] + 1;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Assigned Lands",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: AppFonts.popins,
                ),
              ),
              Text(
                "${uniqueLands.length} Active",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ),

        if (uniqueLands.isEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Center(
              child: Text(
                "No lands assigned",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),
          ),
        ] else ...[
          ...uniqueLands.values.map((landData) {
            final land = landData['land'] as Land;
            final taskCount = landData['taskCount'] as int;
            final matchedTask = tasks.firstWhere(
              (task) => task.land?.sId == land.sId,
              orElse: () => Tasks(),
            );
            final taskId = matchedTask.id;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    land.landTitle ?? 'Unknown Land',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getLocationFromLand(land),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "$taskCount Task${taskCount > 1 ? 's' : ''}",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  RoundButton(
                    width: double.infinity,
                    buttonColor: AppColors.greenColor,
                    title: 'View Land Details',
                    onPress: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.landDetailScreen,
                        arguments: taskId,
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }

  Color _getPriorityColor(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    return "${_getMonthAbbr(now.month)} ${now.day}, ${now.year}";
  }

  String _getMonthAbbr(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }

  String _formatTimeRange(String taskType) {
    // You can customize this based on your task type
    switch (taskType.toLowerCase()) {
      case 'daily':
        return '6:00 AM - 2:00 PM';
      case 'weekly':
        return '9:00 AM - 5:00 PM';
      case 'monthly':
        return 'Full Day';
      default:
        return '6:00 AM - 2:00 PM';
    }
  }

  String _getLocationFromLand(Land? land) {
    // Combine address components
    List<String> locationParts = [];
    if (land?.city != null && land!.city!.isNotEmpty) {
      locationParts.add(land.city!);
    }
    if (land?.state != null && land!.state!.isNotEmpty) {
      locationParts.add(land.state!);
    }
    if (land?.address != null && land!.address!.isNotEmpty) {
      locationParts.add(land.address!);
    }

    return locationParts.isNotEmpty
        ? locationParts.join(', ')
        : 'Location not specified';
  }
}

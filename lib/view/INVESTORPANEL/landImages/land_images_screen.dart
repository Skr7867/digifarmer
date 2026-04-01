import 'package:cached_network_image/cached_network_image.dart';
import 'package:digifarmer/model/INVESTORPANEL/investmentDetails/investment_details_model.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LandImagesScreen extends StatefulWidget {
  // ✅ Now accepts TaskImage list instead of String list
  final List<TaskImage>? taskImages;
  final List<String>? images; // keep for backward compat
  final String? landTitle;
  final int? initialIndex;

  const LandImagesScreen({
    super.key,
    this.taskImages,
    this.images,
    this.landTitle,
    this.initialIndex = 0,
  });

  @override
  State<LandImagesScreen> createState() => _LandImagesScreenState();
}

class _LandImagesScreenState extends State<LandImagesScreen> {
  List<TaskImageGroup> _imageGroups = [];

  @override
  void initState() {
    super.initState();
    _organizeTaskImagesByDate();
  }

  // ✅ Group task images by submission date
  void _organizeTaskImagesByDate() {
    final taskImages = widget.taskImages ?? [];

    if (taskImages.isEmpty) {
      _imageGroups = [];
      return;
    }

    final Map<String, List<TaskImage>> groupedByDate = {};

    for (final image in taskImages) {
      String dateKey = 'Unknown';
      if (image.submittedAt != null) {
        try {
          final date = DateTime.parse(image.submittedAt!);
          dateKey = DateFormat('yyyy-MM-dd').format(date);
        } catch (_) {}
      }

      if (!groupedByDate.containsKey(dateKey)) {
        groupedByDate[dateKey] = [];
      }
      groupedByDate[dateKey]!.add(image);
    }

    // ✅ Convert to sorted list (newest first)
    _imageGroups = groupedByDate.entries.map((entry) {
      DateTime date = DateTime.now();
      try {
        date = DateTime.parse(entry.key);
      } catch (_) {}

      return TaskImageGroup(
        dateKey: entry.key,
        date: date,
        images: entry.value,
      );
    }).toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Widget build(BuildContext context) {
    final landTitle = widget.landTitle ?? 'Task Photos';
    final taskImages = widget.taskImages ?? [];

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: CustomAppBar(
        title: landTitle,
        automaticallyImplyLeading: true,
        centerTitle: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: taskImages.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                _buildHeaderStats(taskImages.length),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _imageGroups.length,
                    itemBuilder: (context, index) {
                      return _buildImageGroup(_imageGroups[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHeaderStats(int totalPhotos) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff2FA463), Color(0xff1C5D9F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$totalPhotos ${totalPhotos == 1 ? 'Task Photo' : 'Task Photos'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_imageGroups.length} work session${_imageGroups.length == 1 ? '' : 's'}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.task_alt,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGroup(TaskImageGroup group) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          // ✅ Date header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            decoration: BoxDecoration(
              color: const Color(0xffF8F9FA),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE').format(group.date), // e.g., "Monday"
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('dd MMM yyyy').format(group.date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${group.images.length} photos',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ✅ Task info banner (show task title + work done from first image)
          if (group.images.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.work_outline, size: 16, color: Colors.blue.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.images.first.taskTitle ?? 'Task',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        if (group.images.first.workDone != null)
                          Text(
                            'Work done: ${group.images.first.workDone}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.blue.shade600,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (group.images.first.hoursWorked != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${group.images.first.hoursWorked}h worked',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                ],
              ),
            ),

          // ✅ Image grid with captions
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8, // ✅ slightly taller to show caption
              ),
              itemCount: group.images.length,
              itemBuilder: (context, index) {
                return _buildTaskImageTile(
                  group.images[index],
                  group.images,
                  index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskImageTile(
    TaskImage taskImage,
    List<TaskImage> groupImages,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        // ✅ Pass all image URLs for full screen gallery
        final urls = groupImages
            .map((img) => img.imageUrl ?? '')
            .where((url) => url.isNotEmpty)
            .toList();
        _showPhotoGallery(urls, index, groupImages);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: taskImage.imageUrl ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // ✅ Show caption below image
          if (taskImage.caption != null && taskImage.caption!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                taskImage.caption!,
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.grey.shade600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  void _showPhotoGallery(
    List<String> images,
    int startIndex,
    List<TaskImage> taskImages,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenGallery(
          images: images,
          initialIndex: startIndex,
          title: widget.landTitle ?? 'Task Photos',
          taskImages: taskImages, // ✅ pass for showing caption in full screen
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No task photos available',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Photos will appear here after task completion',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}

// ✅ Updated FullScreenGallery — shows caption
class FullScreenGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  final String title;
  final List<TaskImage>? taskImages;

  const FullScreenGallery({
    super.key,
    required this.images,
    required this.initialIndex,
    required this.title,
    this.taskImages,
  });

  @override
  State<FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<FullScreenGallery> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final currentTaskImage = widget.taskImages != null &&
            _currentIndex < widget.taskImages!.length
        ? widget.taskImages![_currentIndex]
        : null;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${_currentIndex + 1} / ${widget.images.length}',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // ✅ Swipeable image viewer
          PageView.builder(
            controller: PageController(initialPage: widget.initialIndex),
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: CachedNetworkImage(
                  imageUrl: widget.images[index],
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              );
            },
          ),

          // ✅ Bottom info bar showing caption + task info
          if (currentTaskImage != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (currentTaskImage.caption != null &&
                        currentTaskImage.caption!.isNotEmpty)
                      Text(
                        currentTaskImage.caption!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(height: 4),
                    if (currentTaskImage.taskTitle != null)
                      Text(
                        currentTaskImage.taskTitle!,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    if (currentTaskImage.submittedAt != null)
                      Text(
                        DateFormat('dd MMM yyyy, hh:mm a').format(
                          DateTime.parse(currentTaskImage.submittedAt!),
                        ),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 11,
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ✅ Updated data model
class TaskImageGroup {
  final String dateKey;
  final DateTime date;
  final List<TaskImage> images;

  TaskImageGroup({
    required this.dateKey,
    required this.date,
    required this.images,
  });
}
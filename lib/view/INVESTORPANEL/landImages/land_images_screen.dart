// ignore_for_file: unused_element

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LandImagesScreen extends StatefulWidget {
  final List<String>? images;
  final String? landTitle;
  final int? initialIndex;

  const LandImagesScreen({
    super.key,
    this.images,
    this.landTitle,
    this.initialIndex = 0,
  });

  @override
  State<LandImagesScreen> createState() => _LandImagesScreenState();
}

class _LandImagesScreenState extends State<LandImagesScreen> {
  List<ImageGroup> _imageGroups = [];

  @override
  void initState() {
    super.initState();
    _organizeImagesByDate();
  }

  void _organizeImagesByDate() {
    final images = widget.images ?? [];

    if (images.isEmpty) {
      _imageGroups = [];
      return;
    }

    // For now, since we don't have timestamps for each image, we'll group them by weeks
    // In a real app, you would have timestamps for each image from the API
    // For demo, we'll create a single group with all images
    // You can modify this logic based on your actual data structure

    // Create a single group with all images
    // If you have timestamps, you can parse them from the image URLs or have a separate list
    final allPhotos = <PhotoItem>[];

    // Since we don't have timestamps for individual images, we'll group them in batches
    // You can modify this based on your actual data structure
    final batchSize = 9; // Show 9 images per time slot
    for (var i = 0; i < images.length; i += batchSize) {
      final end = (i + batchSize) < images.length
          ? i + batchSize
          : images.length;
      final batchImages = images.sublist(i, end);

      // Create a mock time for each batch (you should replace this with actual timestamps)
      final mockTime = DateTime.now().subtract(Duration(days: i));

      allPhotos.add(PhotoItem(time: mockTime, imageUrls: batchImages));
    }

    // Group photos by week
    final Map<int, List<PhotoItem>> groupedByWeek = {};

    for (var photo in allPhotos) {
      final weekNumber = _getWeekNumber(photo.time);
      if (!groupedByWeek.containsKey(weekNumber)) {
        groupedByWeek[weekNumber] = [];
      }
      groupedByWeek[weekNumber]!.add(photo);
    }

    // Convert to list of ImageGroup and sort by date (newest first)
    _imageGroups = groupedByWeek.entries.map((entry) {
      // Get the most recent date in this week group
      final latestDate = entry.value
          .map((p) => p.time)
          .reduce((a, b) => a.isAfter(b) ? a : b);
      return ImageGroup(
        weekNumber: entry.key,
        date: latestDate,
        photos: entry.value..sort((a, b) => b.time.compareTo(a.time)),
      );
    }).toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  int _getWeekNumber(DateTime date) {
    // Calculate week number based on the date
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return ((daysSinceFirstDay / 7).floor() + 1);
  }

  @override
  Widget build(BuildContext context) {
    final landTitle = widget.landTitle ?? 'Land Images';
    final images = widget.images ?? [];

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
      body: images.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                // Header Stats
                _buildHeaderStats(),
                const SizedBox(height: 8),
                // Image Groups List
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

  Widget _buildHeaderStats() {
    final images = widget.images ?? [];
    final totalPhotos = images.length;

    // Calculate last updated date
    String lastUpdated = 'Today';
    if (_imageGroups.isNotEmpty && _imageGroups.first.photos.isNotEmpty) {
      final lastPhoto = _imageGroups.first.photos.first;
      final now = DateTime.now();
      final diff = now.difference(lastPhoto.time);

      if (diff.inHours < 24) {
        lastUpdated = '${diff.inHours} hours ago';
      } else if (diff.inDays < 7) {
        lastUpdated = '${diff.inDays} days ago';
      } else {
        lastUpdated = '${diff.inDays ~/ 7} weeks ago';
      }
    }

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
                '$totalPhotos ${totalPhotos == 1 ? 'Photo' : 'Photos'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Last updated: $lastUpdated',
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
              Icons.photo_library,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGroup(ImageGroup group) {
    final totalPhotosInWeek = group.photos.fold(
      0,
      (sum, photo) => sum + photo.imageUrls.length,
    );

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
          // Week Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            decoration: BoxDecoration(
              color: const Color(0xffF8F9FA),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Week ${group.weekNumber}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM dd, yyyy').format(group.date),
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
                    '$totalPhotosInWeek photos',
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
          // Photo Items
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: group.photos.map((photo) {
                return _buildPhotoItem(photo);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoItem(PhotoItem photo) {
    final imageCount = photo.imageUrls.length;
    final showAllImages = imageCount <= 3;
    final displayImages = showAllImages
        ? photo.imageUrls
        : photo.imageUrls.take(3).toList();
    final remainingCount = imageCount - 3;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Header
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff34A853), Color(0xff0D47A1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                DateFormat('hh:mm a').format(photo.time),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                '$imageCount ${imageCount == 1 ? 'photo' : 'photos'}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Image Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: displayImages.length,
            itemBuilder: (context, index) {
              return _buildImageTile(displayImages[index], photo.imageUrls);
            },
          ),

          // Show remaining count if more than 3 images
          if (!showAllImages && remainingCount > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () => _showPhotoGallery(photo.imageUrls, 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Center(
                    child: Text(
                      '+$remainingCount more photos',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageTile(String imageUrl, List<String> allImages) {
    final index = allImages.indexOf(imageUrl);

    return GestureDetector(
      onTap: () => _showPhotoGallery(allImages, index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
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
    );
  }

  int _getTotalPhotos() {
    int total = 0;
    for (var group in _imageGroups) {
      for (var photo in group.photos) {
        total += photo.imageUrls.length;
      }
    }
    return total;
  }

  String _getLastUpdated() {
    if (_imageGroups.isEmpty) return 'Never';
    final lastGroup = _imageGroups.first;
    final lastPhoto = lastGroup.photos.first;
    final now = DateTime.now();
    final diff = now.difference(lastPhoto.time);

    if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${diff.inDays ~/ 7} weeks ago';
    }
  }

  int _getWeekPhotosCount(ImageGroup group) {
    int count = 0;
    for (var photo in group.photos) {
      count += photo.imageUrls.length;
    }
    return count;
  }

  void _showPhotoGallery(List<String> images, int startIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenGallery(
          images: images,
          initialIndex: startIndex,
          title: widget.landTitle ?? 'Land Images',
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No images available',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Images will be added soon',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}

// FullScreen Gallery Widget
class FullScreenGallery extends StatelessWidget {
  final List<String> images;
  final int initialIndex;
  final String title;

  const FullScreenGallery({
    super.key,
    required this.images,
    required this.initialIndex,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: PageController(initialPage: initialIndex),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: CachedNetworkImage(
              imageUrl: images[index],
              fit: BoxFit.contain,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.broken_image, color: Colors.white, size: 50),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Data Models
class ImageGroup {
  final int weekNumber;
  final DateTime date;
  final List<PhotoItem> photos;

  ImageGroup({
    required this.weekNumber,
    required this.date,
    required this.photos,
  });
}

class PhotoItem {
  final DateTime time;
  final List<String> imageUrls;

  PhotoItem({required this.time, required this.imageUrls});
}

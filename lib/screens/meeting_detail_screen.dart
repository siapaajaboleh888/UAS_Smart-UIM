import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/course_content.dart';

class MeetingDetailScreen extends StatelessWidget {
  final String courseName;
  final String courseCode;
  final CourseContent content;

  const MeetingDetailScreen({
    super.key,
    required this.courseName,
    required this.courseCode,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Background Header Color
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
            ),
            
            Column(
              children: [
                // Top Navigation Bar
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              courseName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '$courseCode [ADV]',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Content Card
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        // Title
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            content.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Description section
                        _buildDescription(),
                        
                        const SizedBox(height: 16),
                        
                        // Tabs
                        const TabBar(
                          labelColor: AppColors.primary,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: AppColors.primary,
                          indicatorWeight: 3,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          tabs: [
                            Tab(text: 'Lampiran Materi'),
                            Tab(text: 'Tugas dan Kuis'),
                          ],
                        ),
                        
                        // Tab Content
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildSubItemList(content.subItems),
                              _buildRelatedTasksList(content.relatedTasks),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedTasksList(List<CourseContent> tasks) {
    if (tasks.isEmpty) {
      return const Center(child: Text('Tidak ada tugas atau kuis untuk pertemuan ini.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return _buildTaskCard(task);
      },
    );
  }

  Widget _buildTaskCard(CourseContent item) {
    // Determine color based on badge text (info)
    Color badgeColor = Colors.blue.shade400;
    if (item.info.toLowerCase().contains('kuis')) {
      badgeColor = Colors.blue.shade400;
    } else if (item.info.toLowerCase().contains('tugas')) {
      badgeColor = Colors.cyan.shade400;
    } else if (item.info.toLowerCase().contains('pertemuan')) {
      badgeColor = Colors.blue.shade600;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.info.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon placeholder
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: item.info.toLowerCase().contains('kuis') 
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.quiz_outlined, size: 18, color: AppColors.textPrimary),
                            Text('Quiz', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                          ],
                        )
                      : const Icon(Icons.assignment_outlined, size: 24, color: AppColors.textPrimary),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (item.deadline.isNotEmpty)
                        Text(
                          'Tanggal Waktu : ${item.deadline}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                        ),
                    ],
                  ),
                ),
                if (item.isCompleted)
                  const Icon(Icons.check_circle, color: AppColors.success, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deskripsi',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content.description.isNotEmpty 
                ? content.description 
                : 'Belum ada deskripsi untuk pertemuan ini.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildSubItemList(List<MeetingSubItem> items) {
    if (items.isEmpty) {
      return const Center(
        child: Text('Belum ada materi lampiran.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: Icon(item.icon, color: AppColors.textPrimary, size: 20),
            title: Text(
              item.title,
              style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
            ),
            trailing: item.isCompleted
                ? const Icon(Icons.check_circle, color: AppColors.success, size: 20)
                : Icon(Icons.circle_outlined, color: Colors.grey.shade300, size: 20),
            onTap: () {
              // Handle open material
            },
          ),
        );
      },
    );
  }
}

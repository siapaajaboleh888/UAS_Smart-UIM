import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/course.dart';
import '../models/course_content.dart';
import '../models/quiz.dart';
import 'meeting_detail_screen.dart';
import 'quiz_info_screen.dart';
import 'assignment_detail_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late CourseDetailData _detailData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Load data for this specific course ID, fallback to empty if not found
    _detailData = CourseDetailData.getSampleContent()[widget.course.id] ?? 
                  CourseDetailData(materials: [], tasks: []);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          _buildHeader(context),
          
          // Tab Selection
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: 'Materi'),
                Tab(text: 'Tugas Dan Kuis'),
              ],
            ),
          ),
          
          const Divider(height: 1, thickness: 1),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildContentList(_detailData.materials),
                _buildContentList(_detailData.tasks),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.only(top: 40, bottom: 24, left: 16, right: 16),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Detail Kuliah',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48), // Placeholder to center title
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.course.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.course.code} [ADV]',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentList(List<CourseContent> items) {
    if (items.isEmpty) {
      return const Center(
        child: Text('Belum ada konten untuk saat ini.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildContentCard(item);
      },
    );
  }

  Widget _buildContentCard(CourseContent item) {
    if (item.type == ContentType.task) {
      return _buildTaskCard(item);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MeetingDetailScreen(
                  courseName: widget.course.name,
                  courseCode: widget.course.code,
                  content: item,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Week Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Pertemuan ${item.week}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Title and checkmark
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${item.week.toString().padLeft(2, '0')} - ${item.title}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (item.isCompleted)
                      const Icon(Icons.check_circle, color: AppColors.success, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Info text
                Text(
                  item.info,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (item.info.toLowerCase().contains('kuis') || item.title.toLowerCase().contains('kuis')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizInfoScreen(
                    quiz: Quiz.getSampleQuizzes().first,
                  ),
                ),
              );
            } else if (item.info.toLowerCase().contains('tugas') || item.title.toLowerCase().contains('tugas')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssignmentDetailScreen(
                    title: item.title,
                    deadline: item.deadline,
                    description: item.description,
                  ),
                ),
              );
            }
          },
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
                    // Icon placeholder mimicking the image
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
        ),
      ),
    );
  }
}



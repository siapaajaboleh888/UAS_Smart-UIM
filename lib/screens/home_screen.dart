import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/course.dart';
import '../models/assignment.dart';
import '../models/announcement.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';
import 'package:intl/intl.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current user from UserService
    final userService = UserService();
    final UserModel? currentUser = userService.currentUser;
    
    // Extract user details
    final String userName = currentUser?.nama.toUpperCase() ?? 'USER';
    final String userInitials = currentUser?.getInitials() ?? 'U';
    final String userRole = currentUser?.role ?? 'GUEST';
    
    final courses = Course.getSampleCourses();
    final assignments = Assignment.getSampleAssignments();
    final announcements = Announcement.getSampleAnnouncements();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                          Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigate to Profile screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileScreen(),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Text(
                                  userInitials,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hallo,',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                  Text(
                                    userName,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    userRole,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings_outlined, color: Colors.white),
                              tooltip: 'Pengaturan',
                              onPressed: () {
                                // Navigate to Profile/Settings
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Total Kelas',
                          '${courses.length}',
                          Icons.class_outlined,
                          AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Tugas Aktif',
                          '${assignments.where((a) => !a.isSubmitted).length}',
                          Icons.assignment_outlined,
                          AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Upcoming Assignments
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tugas Yang Akan Datang',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Lihat Semua'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  if (assignments.where((a) => !a.isSubmitted).isEmpty)
                    _buildEmptyState(context, 'Tidak Ada Tugas Dan Kuis Hari Ini', Icons.task_alt)
                  else
                    ...assignments.where((a) => !a.isSubmitted).map(
                      (assignment) => _buildAssignmentCard(context, assignment),
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Latest Announcements
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pengumuman Terakhir',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Lihat Semua'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  ...announcements.take(3).map(
                    (announcement) => _buildAnnouncementCard(context, announcement),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // My Classes Progress
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progres Kelas',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Lihat Semua'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  ...courses.take(3).map(
                    (course) => _buildCourseProgressCard(context, course),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard(BuildContext context, Assignment assignment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: assignment.isDueSoon 
                  ? AppColors.warning.withOpacity(0.1)
                  : AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.assignment,
              color: assignment.isDueSoon ? AppColors.warning : AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assignment.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: AppColors.textLight),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('EEEE, dd MMMM yyyy, HH:mm').format(assignment.deadline) + ' WIB',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context, Announcement announcement) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: const Icon(Icons.campaign, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.author,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      announcement.timeAgo,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            announcement.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            announcement.content,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildCourseProgressCard(BuildContext context, Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.code,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${course.progress}%',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: course.progress / 100,
              backgroundColor: AppColors.textLight.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String message, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(icon, size: 60, color: AppColors.textLight),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

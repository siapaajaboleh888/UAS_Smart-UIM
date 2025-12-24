import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/notification_item.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final NotificationItem notification;

  const AnnouncementDetailScreen({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Detail Pengumuman'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Logos & Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.school, color: AppColors.primary, size: 30),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Smart UIM',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            'Universitas Islam Madura',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    'Smart UIM',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textLight,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Title Section
              Center(
                child: Text(
                  notification.title.toUpperCase().contains('MAINTENANCE') ? 'Maintenance LMS' : 'Pengumuman',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Main Content Area (Layout like Image 1)
              LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text Description
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildParagraph(
                              notification.message.isNotEmpty 
                                  ? notification.message 
                                  : 'Tidak ada detail pesan untuk pengumuman ini.',
                            ),
                            if (notification.title.contains('Maintenance')) ...[
                              const SizedBox(height: 16),
                              _buildParagraph(
                                'Dengan adanya kegiatan maintenance tersebut maka situs LMS (smart-uim.ac.id) tidak dapat diakses untuk sementara waktu.',
                              ),
                            ],
                            const SizedBox(height: 32),
                            const Text(
                              'Hormat Kami,\nAdmin Smart UIM',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 20),

                      // Illustration
                      Expanded(
                        flex: 2,
                        child: _buildMaintenanceIllustration(),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 14,
        height: 1.6,
        color: Color(0xFF4A5568),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildMaintenanceIllustration() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Laptop Base
            Container(
              height: 120,
              width: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 90,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D3748),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Icon(Icons.settings, color: AppColors.primary, size: 40),
                    ),
                  ),
                ],
              ),
            ),
            // Yellow Tape (Diagonal)
            Transform.rotate(
              angle: -0.15,
              child: Container(
                width: 200,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6E05E),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(8, (index) => 
                    Container(width: 15, color: Colors.black.withOpacity(0.8))
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Mini Assets
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 30),
             const SizedBox(width: 10),
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
               decoration: BoxDecoration(
                 color: AppColors.primary,
                 borderRadius: BorderRadius.circular(20),
               ),
               child: const Text('FIXING', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
             ),
          ],
        ),
      ],
    );
  }
}

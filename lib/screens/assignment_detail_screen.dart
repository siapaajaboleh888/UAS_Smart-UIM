import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/user_service.dart';

class AssignmentDetailScreen extends StatelessWidget {
  final String title;
  final String deadline;
  final String description;

  const AssignmentDetailScreen({
    super.key,
    required this.title,
    required this.deadline,
    this.description = '',
  });

  @override
  Widget build(BuildContext context) {
    final userService = UserService();
    final user = userService.currentUser;
    final userName = user?.nama ?? 'MOH. SYAIFUL ANAM';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _buildInstructionItem('1. Buatlah desain tampilan (antarmuka) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan.'),
                   _buildInstructionItem('2. Desain yang dibuat harus melingkupi seluruh tampilan pada aplikasi game, dari pertama kali aplikasi dibuka sampai tutup kembali, serta desain untuk tampilan-tampilan fungsi yang mendukung permainan seperti pop up, alert, chat dan lain-lain.'),
                   _buildInstructionItem('3. Desain bisa dibuat menggunakan aplikasi khusus desain atau secara manual dengan tetap menjunjung kerapihan dan kejelasan setiap elemen dalam desain.'),
                   _buildInstructionItem('4. Berikan identitas aplikasi game yang dibuat, seperti Nama Game, Genre, dan Platform. Serta berikan penjelasan pada setiap elemen pada desain, seperti gambar, teks, tombol, icon, dan lain-lain.'),
                   _buildInstructionItem('5. File dikumpulkan dalam format PDF dengan size maksimal 5MB.'),
                   _buildInstructionItem('6. Tugas dikumpulkan paling lambat hari Jum\'at, 21 Februari 2025 jam 23:59 WIB (akan tertutup otomatis) dan akan dipresentasikan pada pertemuan selanjutnya via Zoom Meeting.'),
                ],
              ),
            ),

            // Status Tugas Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              color: AppColors.primary.withOpacity(0.8),
              child: const Text(
                'Status Tugas',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),

            // Status Table
            _buildStatusTable(userName),

            const SizedBox(height: 32),
            
            // Add Task Button
            Center(
              child: ElevatedButton(
                onPressed: () => _navigateToUpload(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Tambahkan tugas',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildStatusTable(String userName) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        children: [
          _buildStatusRow('Status', 'Sudah mengirim untuk dinilai'),
          _buildStatusRow('Status Nilai', 'Belum Dinilai'),
          _buildStatusRow('batas tanggal', 'Jumat, 25 Februari 2025, 23:59 WIB'),
          _buildStatusRow('hari terakhir', 'Tugas sudah dikirim 4 hari 2 jam Sebelum nya'),
          _buildStatusRow('File Tugas', '${userName}_Tugas01.PDF', isFile: true),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, {bool isFile = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: label == 'Status' || label == 'batas tanggal' || label == 'File Tugas' 
            ? Colors.grey.shade50 
            : Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                if (isFile) const Icon(Icons.picture_as_pdf, size: 16, color: Colors.grey),
                if (isFile) const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 11,
                      color: isFile ? AppColors.primary : Colors.grey.shade800,
                      fontWeight: isFile ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToUpload(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UploadAssignmentScreen(),
      ),
    );
  }
}

class UploadAssignmentScreen extends StatelessWidget {
  const UploadAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Upload File',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header Info
            const Text(
              'Maksimum file 5MB, Maksimum jumlah file 20',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            
            // Upload Dropzone
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 80, color: AppColors.primary.withOpacity(0.7)),
                  const SizedBox(height: 16),
                  const Text(
                    'Pilih yang mau di upload buat kursor di sini',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Buttons
            SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  foregroundColor: Colors.grey.shade700,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Pilih File', style: TextStyle(fontSize: 11)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  foregroundColor: Colors.grey.shade700,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Simpan', style: TextStyle(fontSize: 11)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

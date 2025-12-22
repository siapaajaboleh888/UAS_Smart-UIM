import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/quiz.dart';

class QuizReviewScreen extends StatelessWidget {
  final Quiz quiz;

  const QuizReviewScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    int correctAnswers = quiz.questions.where((q) => q.selectedAnswerIndex == q.correctAnswerIndex).length;
    double score = (correctAnswers / quiz.questions.length) * 100;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Review Jawaban', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Result Summary Table
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.2),
                  1: FlexColumnWidth(2),
                },
                border: TableBorder.symmetric(inside: BorderSide(color: Colors.grey.shade200)),
                children: [
                  _buildTableRow('Di Mulai Pada', 'Kamis, 25 Desember 2025, 10:00'),
                  _buildTableRow('Status', 'Selesai'),
                  _buildTableRow('Selesai Pada', 'Kamis, 25 Desember 2025, 10:45'),
                  _buildTableRow('Waktu Penyelesaian', '45 Menit 22 Detik'),
                  _buildTableRow('Nilai', '${score.toStringAsFixed(1)} / 100'),
                ],
              ),
            ),
          ),
          
          const Divider(height: 1),
          
          // Questions List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: quiz.questions.length,
              separatorBuilder: (context, index) => const Divider(height: 32),
              itemBuilder: (context, index) {
                final question = quiz.questions[index];
                bool isCorrect = question.selectedAnswerIndex == question.correctAnswerIndex;
                String label = question.selectedAnswerIndex != null 
                    ? String.fromCharCode(65 + question.selectedAnswerIndex!) 
                    : '-';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pertanyaan ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Logic to view specific question if needed, 
                            // or just a snackbar for demo
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Menampilkan detail soal ${index + 1}')),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Lihat Soal',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      question.text,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jawaban Tersimpan:',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            question.selectedAnswerIndex != null 
                                ? '$label. ${question.options[question.selectedAnswerIndex!]}' 
                                : 'Tidak Dijawab',
                            style: TextStyle(
                              fontSize: 12, 
                              fontWeight: FontWeight.w600,
                              color: isCorrect ? AppColors.primary : Colors.red.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            ': $value',
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}

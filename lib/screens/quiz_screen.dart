import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/quiz.dart';
import 'quiz_review_screen.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;

  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  late Timer _timer;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.quiz.duration.inSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          _submitQuiz();
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _submitQuiz() {
    _timer.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizReviewScreen(quiz: widget.quiz),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.quiz.questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(top: 40, bottom: 20, left: 16, right: 16),
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.quiz.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.alarm, color: Colors.white, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(_secondsRemaining),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Question Navigation (Circles)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            color: Colors.white,
            child: Wrap(
              spacing: 8,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: List.generate(widget.quiz.questions.length, (index) {
                bool isCurrent = index == _currentQuestionIndex;
                bool isAnswered = widget.quiz.questions[index].selectedAnswerIndex != null;
                
                return GestureDetector(
                  onTap: () => setState(() => _currentQuestionIndex = index),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: (isCurrent || isAnswered) ? AppColors.primary : Colors.white,
                      border: Border.all(
                        color: (isCurrent || isAnswered) ? AppColors.primary : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        if (isCurrent)
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: (isCurrent || isAnswered) ? Colors.white : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const Divider(height: 1, thickness: 1),

          // Question Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Soal Nomor ${_currentQuestionIndex + 1} / ${widget.quiz.questions.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    currentQuestion.text,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ...List.generate(currentQuestion.options.length, (index) {
                    String option = currentQuestion.options[index];
                    String label = String.fromCharCode(65 + index); // A, B, C, D, E
                    bool isSelected = currentQuestion.selectedAnswerIndex == index;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentQuestion.selectedAnswerIndex = index;
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text(
                                '$label.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: isSelected ? Colors.white : AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isSelected ? Colors.white : AppColors.textPrimary,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Bottom Navigation Buttons
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _currentQuestionIndex--),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Soal Sebelumnya',
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  )
                else
                  const Spacer(),
                
                const SizedBox(width: 16),
                
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentQuestionIndex < widget.quiz.questions.length - 1) {
                        setState(() => _currentQuestionIndex++);
                      } else {
                        _submitQuiz();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentQuestionIndex == widget.quiz.questions.length - 1 
                          ? Colors.green.shade600 
                          : AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentQuestionIndex == widget.quiz.questions.length - 1 ? 'Selesai' : 'Soal Selanjutnya',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/router/app_routes.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

// ═══════════════════════════════════════════════════════════════════════════
// ملف واحد — افصله بيدك حسب هالأقسام:
//   1) MODELS            → data/models/
//   2) SMALL WIDGETS     → widget/ (قابلة لإعادة الاستخدام)
//   3) COMPOSED WIDGETS  → widget/
//   4) SCREEN            → screens/
// ═══════════════════════════════════════════════════════════════════════════

// ───────────────────────────────────────────────────────────────────────────
// 1) MODELS
// ───────────────────────────────────────────────────────────────────────────

class QuizInfo {
  final String moduleLabel; // MODULE ASSESSMENT
  final String title;
  final String description;
  final int passingPercent;
  final Duration duration;

  const QuizInfo({
    required this.moduleLabel,
    required this.title,
    required this.description,
    required this.passingPercent,
    required this.duration,
  });
}

class QuizQuestion {
  final String id;
  final String title;
  final int points;
  final List<String> options;

  /// اختياري: فهرس الإجابة الصحيحة (إذا بدك تصحيح محلي).
  final int? correctIndex;

  const QuizQuestion({
    required this.id,
    required this.title,
    required this.options,
    this.points = 2,
    this.correctIndex,
  });
}

// ───────────────────────────────────────────────────────────────────────────
// 2) SMALL WIDGETS (قابلة لإعادة الاستخدام)
// ───────────────────────────────────────────────────────────────────────────

/// AppBar: رجوع + عنوان + مؤقّت + صورة المستخدم.
class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QuizAppBar({
    super.key,
    this.title = 'Quiz',
    required this.timeText,
    this.onBack,
    this.onProfile,
    this.avatar,
  });

  final String title;
  final String timeText;
  final VoidCallback? onBack;
  final VoidCallback? onProfile;
  final ImageProvider? avatar;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundWhiteWidget,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        onPressed: onBack ?? () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(AppRoutes.home);
          }
        },
        icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textBlack),
      ),
      title: Text(
        title,
        style: AppTextStyles.s16w600.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textBlack,
        ),
      ),
      actions: [
        TimerChip(text: timeText),
        SizedBox(width: 8.w),
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: GestureDetector(
            onTap: onProfile,
            child: CircleAvatar(
              radius: 15.r,
              backgroundColor: AppColors.primary,
              backgroundImage: avatar,
              child: avatar == null
                  ? Icon(Icons.person, size: 16.sp, color: AppColors.iconWhite)
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

/// Chip المؤقّت: ⏱ 10:00
class TimerChip extends StatelessWidget {
  const TimerChip({super.key, required this.text, this.warning = false});

  final String text;

  /// لون تحذيري (مثلاً بآخر دقيقة).
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final color = warning ? AppColors.textRed : AppColors.primaryDark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: warning ? AppColors.textRed.withAlpha(25) : AppColors.primarySoft,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer_outlined, size: 14.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            text,
            style: AppTextStyles.s12w400.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Chip معلومات صغير (5 Questions / 10 Points / Passing: 80%).
class QuizInfoChip extends StatelessWidget {
  const QuizInfoChip({
    super.key,
    required this.label,
    required this.icon,
    this.outlined = false,
  });

  final String label;
  final IconData icon;

  /// الشكل المحدّد بإطار (مثل Passing).
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final color = outlined ? AppColors.primary : AppColors.primaryDark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : AppColors.primarySoft,
        borderRadius: BorderRadius.circular(20.r),
        border: outlined ? Border.all(color: AppColors.primary) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: color),
          SizedBox(width: 5.w),
          Text(
            label,
            style: AppTextStyles.s12w400.copyWith(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// شريط تقدّم: Completion Progress ........ 1 of 5 Answered
class QuizProgress extends StatelessWidget {
  const QuizProgress({
    super.key,
    required this.answered,
    required this.total,
    this.label = 'Completion Progress',
  });

  final int answered;
  final int total;
  final String label;

  @override
  Widget build(BuildContext context) {
    final value = total == 0 ? 0.0 : answered / total;
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.s12w400.copyWith(
                fontSize: 11.sp,
                color: AppColors.textGrey,
              ),
            ),
            const Spacer(),
            Text(
              '$answered of $total Answered',
              style: AppTextStyles.s12w400.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            builder: (_, v, __) => LinearProgressIndicator(
              value: v,
              minHeight: 6.h,
              backgroundColor: AppColors.track,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}

/// Badge النقاط: 2 Points
class PointsBadge extends StatelessWidget {
  const PointsBadge({super.key, required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        '$points Points',
        style: AppTextStyles.s12w400.copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}

/// خيار إجابة واحد: [A] نص ........ ○
class AnswerOption extends StatelessWidget {
  const AnswerOption({
    super.key,
    required this.letter,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String letter;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primarySoft : AppColors.backgroundDisabled,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            _LetterBadge(letter: letter, selected: selected),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.s14w500.copyWith(
                  fontSize: 13.sp,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: AppColors.textBlack,
                ),
              ),
            ),
            _RadioDot(selected: selected),
          ],
        ),
      ),
    );
  }
}

class _LetterBadge extends StatelessWidget {
  const _LetterBadge({required this.letter, required this.selected});

  final String letter;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 28.r,
      height: 28.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.backgroundWhiteWidget,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.borderBrand,
        ),
      ),
      child: Text(
        letter,
        style: AppTextStyles.s12w400.copyWith(
          fontWeight: FontWeight.w700,
          color: selected ? AppColors.textWhite : AppColors.textBlack,
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 20.r,
      height: 20.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.borderSecondary,
          width: 1.5,
        ),
      ),
      child: selected
          ? Icon(Icons.check_rounded, size: 13.sp, color: AppColors.iconWhite)
          : null,
    );
  }
}

/// زر بتدرّج برتقالي (يدعم أيقونة قبل أو بعد النص).
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.colors = const [AppColors.primary, AppColors.secondary],
    this.height = 52,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  /// لون سادة: مرّر نفس اللون مرتين.
  final List<Color> colors;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        height: height.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withAlpha(70),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(28.r),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, size: 18.sp, color: AppColors.textWhite),
                SizedBox(width: 8.w),
              ],
              Text(
                label,
                style: AppTextStyles.s14w600
                    .copyWith(color: AppColors.textWhite),
              ),
              if (trailingIcon != null) ...[
                SizedBox(width: 8.w),
                Icon(trailingIcon, size: 18.sp, color: AppColors.textWhite),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// 3) COMPOSED WIDGETS
// ───────────────────────────────────────────────────────────────────────────

/// هيدر الاختبار: عنوان + وصف + chips + تقدّم.
class QuizHeader extends StatelessWidget {
  const QuizHeader({
    super.key,
    required this.info,
    required this.questionsCount,
    required this.totalPoints,
    required this.answered,
  });

  final QuizInfo info;
  final int questionsCount;
  final int totalPoints;
  final int answered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhiteWidget,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.borderBrand),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info.moduleLabel.toUpperCase(),
            style: AppTextStyles.s12w400.copyWith(
              fontSize: 10.sp,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            info.title,
            style: AppTextStyles.s20w600.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            info.description,
            style: AppTextStyles.s12w400.copyWith(
              height: 1.5,
              color: AppColors.textGrey,
            ),
          ),
          SizedBox(height: 14.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              QuizInfoChip(
                label: '$questionsCount Questions',
                icon: Icons.help_outline_rounded,
              ),
              QuizInfoChip(
                label: '$totalPoints Points',
                icon: Icons.bolt_rounded,
              ),
              QuizInfoChip(
                label: 'Passing: ${info.passingPercent}%',
                icon: Icons.verified_outlined,
                outlined: true,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          QuizProgress(answered: answered, total: questionsCount),
        ],
      ),
    );
  }
}

/// بطاقة سؤال: عنوان + نقاط + الخيارات.
class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.number,
    required this.question,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int number; // يبدأ من 1
  final QuizQuestion question;
  final int? selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhiteWidget,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderBrand),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${number.toString().padLeft(2, '0')} - ${question.title}',
                  style: AppTextStyles.s14w600.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                    color: AppColors.textBlack,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              PointsBadge(points: question.points),
            ],
          ),
          SizedBox(height: 14.h),
          for (var i = 0; i < question.options.length; i++) ...[
            if (i > 0) SizedBox(height: 10.h),
            AnswerOption(
              letter: String.fromCharCode(65 + i), // A B C D ...
              text: question.options[i],
              selected: selectedIndex == i,
              onTap: () => onSelected(i),
            ),
          ],
        ],
      ),
    );
  }
}

/// بطاقة "Ready to wrap up?" بنهاية القائمة.
class QuizSubmitCard extends StatelessWidget {
  const QuizSubmitCard({super.key, required this.onSubmit});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColors.ligthPrimary,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primarySoft),
      ),
      child: Column(
        children: [
          Text(
            'Ready to wrap up?',
            style: AppTextStyles.s14w600.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Double check your selections. You can review your detailed '
            'explanation and earn course XP right away.',
            textAlign: TextAlign.center,
            style: AppTextStyles.s12w400.copyWith(
              height: 1.5,
              color: AppColors.textGrey,
            ),
          ),
          SizedBox(height: 16.h),
          GradientButton(
            label: 'Submit Answers',
            trailingIcon: Icons.arrow_forward_rounded,
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}

/// شريط التسليم الثابت أسفل الشاشة.
class QuizSubmitBar extends StatelessWidget {
  const QuizSubmitBar({super.key, required this.onSubmit});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhiteWidget,
        border: Border(top: BorderSide(color: AppColors.borderBrand)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
          child: GradientButton(
            label: 'Submit Answers',
            leadingIcon: Icons.check_circle_outline_rounded,
            colors: const [AppColors.primaryDark, AppColors.primaryDark],
            onPressed: onSubmit,
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// 4) SCREEN
// ───────────────────────────────────────────────────────────────────────────

/// الشاشة: تجمع الـ widgets وتدير الإجابات والمؤقّت فقط.
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // بيانات تجريبية — استبدلها بالـ API
  static const _info = QuizInfo(
    moduleLabel: 'Module Assessment',
    title: 'Chapter’s Title - Quiz',
    description: 'Test your comprehension across core foundational '
        'principles before advancing.',
    passingPercent: 80,
    duration: Duration(minutes: 10),
  );

  static const _options = [
    'First Answer',
    'Second Answer',
    'Third Answer',
    'Forth Answer',
  ];

  static const _questions = <QuizQuestion>[
    QuizQuestion(
      id: 'q1',
      title: 'Question Full Title Question Title Question Title ?',
      options: _options,
      correctIndex: 1,
    ),
    QuizQuestion(
        id: 'q2', title: 'Question Full Title Question ?', options: _options),
    QuizQuestion(
        id: 'q3', title: 'Question Full Title Question ?', options: _options),
    QuizQuestion(
        id: 'q4', title: 'Question Full Title Question ?', options: _options),
    QuizQuestion(
        id: 'q5', title: 'Question Full Title Question ?', options: _options),
  ];

  /// questionId -> index الخيار المختار
  final Map<String, int> _answers = {};

  late int _remaining = _info.duration.inSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining <= 1) {
        _timer?.cancel();
        setState(() => _remaining = 0);
        _submit(force: true); // انتهى الوقت: تسليم تلقائي
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timeText {
    final m = (_remaining ~/ 60).toString().padLeft(2, '0');
    final s = (_remaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  int get _totalPoints => _questions.fold(0, (sum, q) => sum + q.points);

  Future<void> _submit({bool force = false}) async {
    final unanswered = _questions.length - _answers.length;

    if (!force && unanswered > 0) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.backgroundWhiteWidget,
          title: Text('Unanswered questions', style: AppTextStyles.s16w600),
          content: Text(
            'You still have $unanswered unanswered question(s). Submit anyway?',
            style: AppTextStyles.s14w400,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text('Review',
                  style: AppTextStyles.s14w600
                      .copyWith(color: AppColors.textGrey)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text('Submit',
                  style: AppTextStyles.s14w600
                      .copyWith(color: AppColors.primary)),
            ),
          ],
        ),
      );
      if (ok != true || !mounted) return;
    }

    _timer?.cancel();

    // TODO: أرسل _answers للـ API أو انتقل لشاشة النتيجة.
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Submitted ${_answers.length}/${_questions.length}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // عناصر القائمة: هيدر + الأسئلة + بطاقة التسليم
    final itemCount = _questions.length + 2;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: QuizAppBar(timeText: _timeText, onProfile: () {}),
      bottomNavigationBar: QuizSubmitBar(onSubmit: _submit),
      body: ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
        itemCount: itemCount,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (_, i) {
          if (i == 0) {
            return QuizHeader(
              info: _info,
              questionsCount: _questions.length,
              totalPoints: _totalPoints,
              answered: _answers.length,
            );
          }
          if (i == itemCount - 1) {
            return QuizSubmitCard(onSubmit: _submit);
          }
          final q = _questions[i - 1];
          return QuestionCard(
            number: i,
            question: q,
            selectedIndex: _answers[q.id],
            onSelected: (opt) => setState(() => _answers[q.id] = opt),
          );
        },
      ),
    );
  }
}
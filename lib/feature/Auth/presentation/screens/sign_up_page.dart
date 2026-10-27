import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/router/app_routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberDevice = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Please enter your email';
    final regex = RegExp(r'^[\w\.\-+]+@([\w\-]+\.)+[\w\-]{2,}$');
    if (!regex.hasMatch(email)) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // TODO: استدعاء الـ API
    if (!mounted) return;
    setState(() => _isLoading = false);
    _goHome();
  }

  void _goHome() => context.go(AppRoutes.home);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE6DC), Color(0xFFFFF8F5), Colors.white],
            stops: [0, .3, .6],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const AuthLogo(
                    appName: 'Study',
                    badgeLabel: 'SMART COURSE SUITE',
                  ),
                  const SizedBox(height: 20),
                  const AuthHeading(
                    title: 'Welcome Back!',
                    subtitle:
                        'Please enter your email and password\nto access your courses.',
                  ),
                  const SizedBox(height: 22),
                  AuthFormCard(
                    children: [
                      AuthTextField(
                        label: 'Email',
                        labelIcon: Icons.mail_outline,
                        hint: 'name@example.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 14),
                      PasswordTextField(
                        controller: _passwordController,
                        validator: _validatePassword,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _onLogin(),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LabeledCheckbox(
                            label: 'Remember device',
                            value: _rememberDevice,
                            onChanged: (v) =>
                                setState(() => _rememberDevice = v),
                          ),
                          AuthTextLink(label: 'Forgot Password?', onTap: () {}),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  GradientButton(
                    label: 'Log In',
                    icon: Icons.arrow_forward,
                    isLoading: _isLoading,
                    onPressed: _onLogin,
                  ),
                  const SizedBox(height: 12),
                  SecondaryButton(
                    label: 'Continue as a Guest',
                    icon: Icons.explore_outlined,
                    onPressed: _goHome,
                  ),
                  const SizedBox(height: 22),
                  const LabeledDivider(label: 'OR CONTINUE WITH'),
                  const SizedBox(height: 18),
                  // SocialButtonsRow(onApple: () {}, onGoogle: () {}),
                  // const InfoBanner(
                  //   tag: 'SYRIAN CURRICULUM',
                  //   year: '2024',
                  //   message: 'Interactive lessons & certified video tracks',
                  // ),
                  const SizedBox(height: 22),
                  AuthFooter(
                    question: "Don't have an account?",
                    actionLabel: 'Sign Up',
                    onActionTap: () {
                      context.go(AppRoutes.createAccount);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// جميع widgets الخاصة بشاشات المصادقة (Sign In / Sign Up / Forgot Password)
// في ملف واحد، وكل widget مستقل وقابل لإعادة الاستخدام.

// import 'package:flutter/material.dart';
// import '../../core/app_colors.dart';

/// ───────────────────────── Logo + اسم التطبيق + الشارة ─────────────────────────
class AuthLogo extends StatelessWidget {
  const AuthLogo({
    super.key,
    required this.appName,
    required this.badgeLabel,
    this.icon = Icons.menu_book_rounded,
  });

  final String appName, badgeLabel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [AppColors.primary, Color(0xFFFF8A5B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha(90),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              appName,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 8),
              child: CircleAvatar(
                radius: 3,
                backgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AuthBadge(label: badgeLabel),
      ],
    );
  }
}

/// ───────────────────────── شارة صغيرة (SMART COURSE SUITE) ─────────────────────────
class AuthBadge extends StatelessWidget {
  const AuthBadge({
    super.key,
    required this.label,
    this.icon = Icons.school_outlined,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withAlpha(40)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.primaryDark),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}

/// ───────────────────────── عنوان + وصف ─────────────────────────
class AuthHeading extends StatelessWidget {
  const AuthHeading({super.key, required this.title, required this.subtitle});

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textGrey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

/// ───────────────────────── البطاقة الرمادية التي تحوي الحقول ─────────────────────────
class AuthFormCard extends StatelessWidget {
  const AuthFormCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            spreadRadius: 4,
            offset: Offset(0, 3),
            blurRadius: 4,
            color: const Color.fromARGB(14, 0, 0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

/// ───────────────────────── حقل نص عام (label + أيقونة + حقل) ─────────────────────────
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.labelIcon,
    required this.hint,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.suffix,
    this.validator,
    this.textInputAction,
    this.onSubmitted,
  });

  final String label, hint;
  final IconData labelIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(labelIcon, size: 14, color: AppColors.primaryDark),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          textInputAction: textInputAction,
          onFieldSubmitted: onSubmitted,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFBDBDC3), fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffix,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),
            border: _border(Colors.transparent),
            enabledBorder: _border(Colors.transparent),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(Colors.redAccent),
            focusedErrorBorder: _border(Colors.redAccent),
            errorStyle: const TextStyle(fontSize: 11),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(24),
    borderSide: BorderSide(color: color, width: 1.2),
  );
}

/// ───────────────────────── حقل كلمة المرور مع إظهار/إخفاء ─────────────────────────
class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.label = 'Password',
    this.hint = '••••••••••••',
    this.controller,
    this.validator,
    this.textInputAction,
    this.onSubmitted,
  });

  final String label, hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      label: widget.label,
      labelIcon: Icons.lock_outline,
      hint: widget.hint,
      controller: widget.controller,
      obscureText: _obscure,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      onSubmitted: widget.onSubmitted,
      suffix: IconButton(
        onPressed: () => setState(() => _obscure = !_obscure),
        icon: Icon(
          _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 20,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}

/// ───────────────────────── Checkbox بعنوان (Remember device) ─────────────────────────
class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: value ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.primary, width: 1.5),
            ),
            child: value
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }
}

/// ───────────────────────── رابط نصي (Forgot Password? / Sign Up) ─────────────────────────
class AuthTextLink extends StatelessWidget {
  const AuthTextLink({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}

/// ───────────────────────── الزر الرئيسي بتدرّج لوني ─────────────────────────
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFFFF8A5B)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(90),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(26),
          onTap: isLoading ? null : onPressed,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (icon != null) ...[
                        const SizedBox(width: 6),
                        Icon(icon, color: Colors.white, size: 18),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// ───────────────────────── الزر الثانوي الرمادي (Continue as a Guest) ─────────────────────────
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE6E6EB),
          foregroundColor: AppColors.textDark,
          elevation: 0,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(label),
          ],
        ),
      ),
    );
  }
}

/// ───────────────────────── فاصل "OR CONTINUE WITH" ─────────────────────────
class LabeledDivider extends StatelessWidget {
  const LabeledDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: .8,
              fontWeight: FontWeight.w600,
              color: AppColors.textGrey,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}

/// أيقونة Google بسيطة بدون أي package.

/// ───────────────────────── صفّ الأزرار الاجتماعية ─────────────────────────

/// ───────────────────────── سطر التذييل (Don't have an account? Sign Up) ─────────────────────────
class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.question,
    required this.actionLabel,
    this.onActionTap,
  });

  final String question, actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$question ',
          style: const TextStyle(fontSize: 13, color: AppColors.textGrey),
        ),
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionLabel,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryDark,
            ),
          ),
        ),
      ],
    );
  }
}

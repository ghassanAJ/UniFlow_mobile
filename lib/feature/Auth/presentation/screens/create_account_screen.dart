import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/design/app_spacing.dart';
import 'package:uniflow/feature/Auth/presentation/screens/sign_up_page.dart';
import 'package:uniflow/feature/Auth/presentation/widget/drop_down_app_widget.dart';
import 'package:uniflow/feature/Auth/presentation/widget/header_card.dart';
import 'package:uniflow/feature/Auth/presentation/widget/input_form_field.dart';
import 'package:uniflow/feature/Auth/presentation/widget/primary_button_app.dart';
import 'package:uniflow/feature/Auth/presentation/widget/year_selector_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  String? _university;
  String? _faculty;
  int _year = 0;
  bool _hidePass = true;
  bool _hideConfirm = true;
  bool _agree = true;

  final _universities = const [
    'Damascus University',
    'Aleppo University',
    'Tishreen University',
  ];
  final _faculties = const ['Engineering', 'Medicine', 'Science', 'Law'];
  final _years = const ['1st', '2nd', '3rd', '4th', '5th'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  // 0..3
  int get _strength {
    final p = _passCtrl.text;
    int s = 0;
    if (p.length >= 8) s++;
    if (RegExp(r'[A-Z]').hasMatch(p) && RegExp(r'\d').hasMatch(p)) s++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(p)) s++;
    return s;
  }

  String get _strengthLabel => ['', 'Weak', 'Good', 'Strong'][_strength];

  Color get _strengthColor => [
    AppColors.track,
    const Color(0xFFE53935),
    AppColors.primary,
    AppColors.green,
  ][_strength];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      // appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.screenVertical,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _headerCard(),
              HeaderCardWidget(),
              const SizedBox(height: AppSpacing.xxl),
              // _syllabusCard(),
              const SizedBox(height: 22),
              _label('Full Name', trailing: 'As on student card'),

              // _inputField(
              //   controller: _nameCtrl,
              //   hint: 'e.g. ghassan aj',
              //   icon: Icons.person_outline,
              // ),
              InputFormField(
                controller: _nameCtrl,
                hint: 'e.g. ghassan aj',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 18),
              _label('Phone Number'),
              _phoneField(),
              const SizedBox(height: 18),
              _label(
                'Choose University',
                trailing: 'Required',
                trailingColor: AppColors.primary,
              ),
              // _dropdown(
              //   hint: 'Select your university',
              //   icon: Icons.account_balance_outlined,
              //   value: _university,
              //   items: _universities,
              //   onChanged: (v) => setState(() => _university = v),
              // ),
              DropDownAppWidget(
                boxDecoration: _boxDecoration,
                hint: 'Select your university',
                icon: Icons.account_balance_outlined,
                items: _universities,
                onChanged: (v) =>
                    () => _university = v,
              ),
              const SizedBox(height: 18),
              _label('Choose College / Faculty'),
              // _dropdowns(
              //   hint: 'Select your faculty',
              //   icon: Icons.menu_book_outlined,
              //   value: _faculty,
              //   items: _faculties,
              //   onChanged: (v) => setState(() => _faculty = v),
              // ),
                DropDownAppWidget(
                boxDecoration: _boxDecoration,
                hint: 'Select your Collage',
                icon: Icons.account_balance_outlined,
                items: _universities,
                onChanged: (v) =>
                    () => _university = v,
              ),
              const SizedBox(height: 18),
              _label('Choose Study Year', trailing: 'Academic Level'),

              YearSelectorWidget(),
              const SizedBox(height: 18),
              _label('Create Password'),
              // InputFormField(controller:_passCtrl , hint: 'At least 8 characters', icon: Icons.lock_outline,
              // onChanged: (value) {

              // },
              // ),
              _inputField(
                controller: _passCtrl,
                hint: 'At least 8 characters',
                icon: Icons.lock_outline,
                obscure: _hidePass,
                onChanged: (_) => setState(() {}),
                suffix: IconButton(
                  icon: Icon(
                    _hidePass
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.muted,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _hidePass = !_hidePass),
                ),
              ),
              const SizedBox(height: 12),
              _strengthMeter(),
              const SizedBox(height: 18),
              _label('Confirm Password'),
              _inputField(
                controller: _confirmCtrl,
                hint: 'Repeat your password',
                icon: Icons.sync_lock_outlined,
                obscure: _hideConfirm,
                suffix: IconButton(
                  icon: Icon(
                    _hideConfirm
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.muted,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _hideConfirm = !_hideConfirm),
                ),
              ),
              const SizedBox(height: 18),
              _termsRow(),
              const SizedBox(height: 22),
              _submitButton(),
              const SizedBox(height: 18),
              _loginRow(),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────── Reusable pieces ─────────────
  Widget _label(
    String text, {
    String? trailing,
    Color trailingColor = AppColors.muted,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (trailing != null)
            Text(
              trailing,
              style: TextStyle(
                color: trailingColor,
                fontSize: 11,
                fontWeight: trailingColor == AppColors.muted
                    ? FontWeight.w400
                    : FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  BoxDecoration get _boxDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.09),
        blurRadius: 10,
        offset: const Offset(0, 3),
      ),
    ],
  );

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
    ValueChanged<String>? onChanged,
  }) {
    return Container(
      height: 54,
      padding: const EdgeInsets.only(left: 10, right: 6),
      decoration: _boxDecoration,
      child: Row(
        children: [
          IconBadgeWidget(icon: icon),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              onChanged: onChanged,
              style: const TextStyle(fontSize: 14, color: AppColors.text),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: AppColors.hint, fontSize: 13),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (suffix != null) suffix,
        ],
      ),
    );
  }

  Widget _phoneField() {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 16, right: 14),
      decoration: _boxDecoration,
      child: Row(
        children: [
          IconBadgeWidget(icon: Icons.phone_outlined),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF1EFF6),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Text(
                  '+963',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 14,
                  color: AppColors.muted,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 14, color: AppColors.text),
              decoration: const InputDecoration(
                hintText: 'xxx xxx xxx',
                hintStyle: TextStyle(color: AppColors.hint, fontSize: 13),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdowns({
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropDownAppWidget(
      boxDecoration: _boxDecoration,
      hint: hint,
      icon: icon,
      items: items,
      onChanged: onChanged,
    );
  }

  Widget _strengthMeter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Password Strength',
              style: TextStyle(fontSize: 11, color: AppColors.text),
            ),
            Text(
              _strengthLabel,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _strengthColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: List.generate(3, (i) {
            final active = i < _strength;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 5,
                margin: EdgeInsets.only(right: i == 2 ? 0 : 5),
                decoration: BoxDecoration(
                  color: active ? _strengthColor : AppColors.track,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _termsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _agree = !_agree),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _agree ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary, width: 1.5),
            ),
            child: _agree
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 11.5,
                color: AppColors.muted,
                height: 1.5,
              ),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms & Conditions',
                  style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' and acknowledge the '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' of the platform.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: _agree
          ? () {
              /* TODO: submit */
              print('HAlA Gh');
            }
          : null,
      child: Opacity(
        opacity: _agree ? 1 : 0.5,
        child: PrimaryButtonAppWidget(),
      ),
    );
  }

  Widget _loginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?  ',
          style: TextStyle(fontSize: 12.5, color: AppColors.muted),
        ),
        GestureDetector(
          onTap: () {
            /* TODO: navigate to login */
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SignInScreen()),
            );
          },
          child: const Text(
            'Log In',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryDark,
            ),
          ),
        ),
      ],
    );
  }
}

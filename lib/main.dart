import 'package:flutter/material.dart';

void main() => runApp(const LoginApp());

const _ink = Color(0xFF172D32);
const _mint = Color(0xFFCEEDDE);
const _muted = Color(0xFF657576);

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Forma · Sign in',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      fontFamily: 'AppRoboto',
      colorScheme: ColorScheme.fromSeed(seedColor: _ink, primary: _ink),
      scaffoldBackgroundColor: const Color(0xFFF2F4F0),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F7F5),
        hintStyle: const TextStyle(color: _muted, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE1E7E2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _ink, width: 1.5),
        ),
      ),
    ),
    home: const LoginPage(),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  void _signIn() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    // Demo only. Connect your authentication service here.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Demo complete. Your details passed validation.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: (constraints.maxHeight - 40).clamp(0, double.infinity),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: ColoredBox(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _WelcomeHeader(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                26,
                                28,
                                26,
                                28,
                              ),
                              child: AutofillGroup(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        'Sign in',
                                        style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700,
                                          color: _ink,
                                          letterSpacing: -0.7,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'A fresh start, right where you left off.',
                                        style: TextStyle(
                                          color: _muted,
                                          fontSize: 14,
                                          height: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 28),
                                      const _FieldLabel('Email address'),
                                      const SizedBox(height: 9),
                                      Semantics(
                                        label: 'Email address',
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            hintText: 'you@example.com',
                                            prefixIcon: Icon(
                                              Icons.alternate_email_rounded,
                                              size: 20,
                                            ),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                          autofillHints: const [
                                            AutofillHints.username,
                                            AutofillHints.email,
                                          ],
                                          autocorrect: false,
                                          validator: (value) {
                                            final email = value?.trim() ?? '';
                                            return RegExp(
                                                  r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                                                ).hasMatch(email)
                                                ? null
                                                : 'Enter a valid email address.';
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 22),
                                      const _FieldLabel('Password'),
                                      const SizedBox(height: 9),
                                      Semantics(
                                        label: 'Password',
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Enter your password',
                                            prefixIcon: const Icon(
                                              Icons.lock_outline_rounded,
                                              size: 20,
                                            ),
                                            suffixIcon: IconButton(
                                              tooltip: _obscurePassword
                                                  ? 'Show password'
                                                  : 'Hide password',
                                              onPressed: () => setState(
                                                () => _obscurePassword =
                                                    !_obscurePassword,
                                              ),
                                              icon: Icon(
                                                _obscurePassword
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                          .visibility_off_outlined,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          obscureText: _obscurePassword,
                                          autocorrect: false,
                                          enableSuggestions: false,
                                          autofillHints: const [
                                            AutofillHints.password,
                                          ],
                                          textInputAction: TextInputAction.done,
                                          onFieldSubmitted: (_) => _signIn(),
                                          validator: (value) =>
                                              (value?.length ?? 0) < 6
                                              ? 'Use at least 6 characters.'
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(height: 28),
                                      FilledButton(
                                        onPressed: _signIn,
                                        style: FilledButton.styleFrom(
                                          minimumSize: const Size.fromHeight(
                                            56,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'Sign in',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 19,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 23),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.code_rounded,
                                            size: 16,
                                            color: _muted,
                                          ),
                                          SizedBox(width: 7),
                                          Flexible(
                                            child: Text(
                                              'UI demo · No account required',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: _muted,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'LESS FRICTION. MORE POSSIBILITY.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.6,
                        color: _muted,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: _ink,
      ),
    ),
  );
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: _ink,
    child: Stack(
      children: [
        Positioned(
          right: -56,
          top: -48,
          child: ExcludeSemantics(
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2D4548), width: 36),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.layers_rounded, size: 25, color: _mint),
                  SizedBox(width: 8),
                  Text(
                    'forma',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 31),
              const Text(
                'GOOD TO HAVE YOU BACK',
                style: TextStyle(
                  color: _mint,
                  fontSize: 10,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your space.\nYour next chapter.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                  height: 1.13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: _mint,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

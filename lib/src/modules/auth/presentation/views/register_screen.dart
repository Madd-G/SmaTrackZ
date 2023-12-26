import 'package:smatrackz/core.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final companyNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final String companyId = const Uuid().v8();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<AuthBloc>()),
          BlocProvider(create: (context) => sl<CompanyBloc>()),
        ],
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is SignedUp) {
              context.read<AuthBloc>().add(
                    SignInEvent(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    ),
                  );
            } else if (state is SignedIn) {
              context.read<UserProvider>().initUser(state.user as UserModel);
              Navigator.pushReplacementNamed(context, MainNavigation.routeName);
            }
          },
          builder: (context, state) {
            return BackgroundImage(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 450.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20.0),
                            const Center(
                              child: WelcomeText(
                                title: 'Sign Up',
                                subtitle: 'Let\'s create your account.',
                              ),
                            ),
                            const SizedBox(height: 25),
                            SignUpForm(
                              emailController: emailController,
                              passwordController: passwordController,
                              confirmPasswordController:
                                  confirmPasswordController,
                              companyNameController: usernameController,
                              formKey: formKey,
                            ),
                            const SizedBox(height: 30),
                            (state is AuthLoading)
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : RoundedButton(
                                    label: 'Sign Up',
                                    onPressed: () async {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      FirebaseAuth.instance.currentUser
                                          ?.reload();
                                      if (formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(
                                              SignUpEvent(
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim(),
                                                companyId: companyId,
                                                name: usernameController.text
                                                    .trim(),
                                              ),
                                            );
                                      }
                                    },
                                  ),
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: CustomTextStyle.textBigRegular,
                                ),
                                const SizedBox(width: 7.0),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, SignInScreen.routeName);
                                  },
                                  child: Text(
                                    'Login',
                                    style: CustomTextStyle.textBigRegular
                                        .copyWith(
                                            color: AppColors.primaryColor),
                                  ),
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
            );
          },
        ),
      ),
    );
  }
}

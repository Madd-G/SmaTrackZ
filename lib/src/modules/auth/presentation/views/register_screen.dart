import 'package:smatrackz/core.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyWebsiteController = TextEditingController();
  final companyAddressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (_, state) {
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
                context
                    .read<UserProvider>()
                    .initUser(state.user as LocalUserModel);

                Navigator.pushReplacementNamed(
                    context, BottomNavigation.routeName);
              }
            },
            builder: (context, state) {
              return Center(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const WelcomeText(
                          title: 'Sign Up',
                          subtitle: 'Let\'s create your account.',
                        ),
                        const SizedBox(height: 25),
                        SignUpForm(
                          emailController: emailController,
                          fullNameController: fullNameController,
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
                          companyNameController: companyNameController,
                          companyWebsiteController: companyWebsiteController,
                          companyAddressController: companyAddressController,
                          formKey: formKey,
                        ),
                        const SizedBox(height: 30),
                        if (state is AuthLoading)
                          const Center(child: CircularProgressIndicator())
                        else
                          RoundedButton(
                            label: 'Create Account',
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              FirebaseAuth.instance.currentUser?.reload();
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      SignUpEvent(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        name: fullNameController.text.trim(),
                                      ),
                                    );
                              }
                            },
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: CustomTextStyle.textRegular,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  SignInScreen.routeName,
                                );
                              },
                              child: const Text(
                                'Login',
                                style: CustomTextStyle.textRegular,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

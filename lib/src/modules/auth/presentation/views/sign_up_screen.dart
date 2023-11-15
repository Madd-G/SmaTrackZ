import 'package:smatrackz/core.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
              /// TODO:
              Navigator.pushReplacementNamed(
                  context, BottomNavigation.routeName);
            }
          },
          builder: (context, state) {
            return Center(
              child: Stack(
                children: [
                  Container(
                    color: Colors.blue,
                    width: context.width,
                    height: 50.0,
                    child: CustomPaint(
                      painter: CustomShape(),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 290.0,
                          ),
                          const WelcomeText(
                            title: 'Hi, Welcome',
                            subtitle: 'Let\'s create your account.',
                          ),
                          const SizedBox(height: 25),
                          SignUpForm(
                            emailController: emailController,
                            fullNameController: fullNameController,
                            passwordController: passwordController,
                            confirmPasswordController:
                                confirmPasswordController,
                            formKey: formKey,
                          ),
                          const SizedBox(height: 30),
                          if (state is AuthLoading)
                            const Center(child: CircularProgressIndicator())
                          else
                            RoundedButton(
                              label: 'Register',
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:smatrackz/core.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (_, state) {
            if (state is AuthError) {
              CoreUtils.showSnackBar(context, state.message);
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
                            title: 'Welcome Back!',
                            subtitle:
                                'Happy to see you again, please login here.',
                          ),
                          const SizedBox(height: 35),
                          SignInForm(
                            emailController: emailController,
                            passwordController: passwordController,
                            formKey: formKey,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot password?',
                                style: CustomTextStyle.textRegular,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (state is AuthLoading)
                            const Center(child: CircularProgressIndicator())
                          else
                            RoundedButton(
                              label: 'LOGIN',
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                FirebaseAuth.instance.currentUser?.reload();
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                        SignInEvent(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                        ),
                                      );
                                }
                              },
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account',
                                style: CustomTextStyle.textRegular,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    SignUpScreen.routeName,
                                  );
                                },
                                child: const Text(
                                  'Register account?',
                                  style: CustomTextStyle.textRegular,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

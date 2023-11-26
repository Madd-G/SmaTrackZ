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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    fullNameController: fullNameController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    companyNameController: companyNameController,
                    companyWebsiteController: companyWebsiteController,
                    companyAddressController: companyAddressController,
                    formKey: formKey,
                  ),
                  const SizedBox(height: 30),
                  RoundedButton(
                    label: 'Next',
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      FirebaseAuth.instance.currentUser?.reload();
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                            create: (context) =>
                                                sl<AuthBloc>()),
                                        BlocProvider(
                                            create: (context) => OfficeBloc()),
                                      ],
                                      child: RegisterCompanyLocationScreen(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        name: fullNameController.text.trim(),
                                        officeName:
                                            companyNameController.text.trim(),
                                        address: companyAddressController.text
                                            .trim(),
                                        website: companyWebsiteController.text
                                            .trim(),
                                      ),
                                    )));
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
                            context,
                            SignInScreen.routeName,
                          );
                        },
                        child: Text(
                          'Login',
                          style: CustomTextStyle.textBigRegular
                              .copyWith(color: AppColors.primaryColor),
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
    );
  }
}

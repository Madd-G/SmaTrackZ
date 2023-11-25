import 'package:smatrackz/core.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.fullNameController,
    required this.companyNameController,
    required this.companyWebsiteController,
    required this.companyAddressController,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController companyNameController;
  final TextEditingController companyWebsiteController;
  final TextEditingController companyAddressController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    widget.fullNameController.dispose();
    widget.emailController.dispose();
    widget.passwordController.dispose();
    widget.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'User Information',
            style: CustomTextStyle.textLargeSemiBold
                .copyWith(color: AppColors.greyColor, fontSize: 18.0),
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: widget.fullNameController,
            hintText: 'Full Name',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: widget.emailController,
            hintText: 'Email address',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: widget.passwordController,
            hintText: 'Password',
            obscureText: obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword ? IconlyLight.show : IconlyLight.hide,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: widget.confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: obscureConfirmPassword,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },
              icon: Icon(
                obscureConfirmPassword ? IconlyLight.show : IconlyLight.hide,
                color: Colors.grey,
              ),
            ),
            overrideValidator: true,
            validator: (value) {
              if (value != widget.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Company Information',
            style: CustomTextStyle.textLargeSemiBold
                .copyWith(color: AppColors.greyColor, fontSize: 18.0),
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: widget.fullNameController,
            hintText: 'Company Name',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: widget.companyWebsiteController,
            hintText: 'Company Website',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: widget.companyAddressController,
            hintText: 'Company Address',
            keyboardType: TextInputType.name,
          ),
        ],
      ),
    );
  }
}

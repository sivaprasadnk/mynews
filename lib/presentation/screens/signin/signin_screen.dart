import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/common_colors.dart';
import 'package:news_app/presentation/provider/user_auth_provider.dart';
import 'package:news_app/presentation/screens/signup/signup_screen.dart';
import 'package:news_app/presentation/widgets/common_btn.dart';
import 'package:news_app/presentation/widgets/textfield_container.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final String _email = "";
  final String _password = "";

  login() async {
    FocusScope.of(context).unfocus();
    var result = _formKey.currentState!.validate();
    if (result) {
      _formKey.currentState!.save();
      context.read<UserAuthProvider>().signIn(_email, _password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 80),
              Text(
                'kAppName',
                style: TextStyle(
                  color: kBlueColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 200),
              const SizedBox(height: 15),
              TextfieldContainer(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: ' Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextfieldContainer(
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: ' Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<UserAuthProvider>(builder: (_, provider, __) {
                    return CommonBtn(
                      onTap: () {
                        login();
                      },
                      title: 'Login',
                      isLoading: provider.isLoading,
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'New here?',
                      children: [
                        TextSpan(
                          text: ' Signup ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              FocusScope.of(context).unfocus();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                return const SignUpScreen();
                              }));
                            },
                          style: TextStyle(
                            color: kBlueColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

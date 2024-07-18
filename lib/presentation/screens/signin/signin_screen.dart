import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_news/core/utils/common_colors.dart';
import 'package:my_news/core/utils/common_strings.dart';
import 'package:my_news/presentation/provider/firebase_provider.dart';
import 'package:my_news/presentation/screens/signup/signup_screen.dart';
import 'package:my_news/presentation/widgets/common_btn.dart';
import 'package:my_news/presentation/widgets/textfield_container.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  login() async {
    FocusScope.of(context).unfocus();
    var result = _formKey.currentState!.validate();
    if (result) {
      _formKey.currentState!.save();
      context.read<FirebaseProvider>().signIn(_email, _password, context);
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
                kAppName,
                style: TextStyle(
                  color: kBlueColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 200),
              const SizedBox(height: 15),
              TextfieldContainer(
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    _email = value;
                    login();
                  },
                  onSaved: (newValue) {
                    _email = newValue!;
                  },
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
                  onFieldSubmitted: (value) {
                    _password = value;
                    login();
                  },
                  onSaved: (newValue) {
                    _password = newValue!;
                  },
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
                  Consumer<FirebaseProvider>(builder: (_, provider, __) {
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

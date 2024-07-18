import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_news/core/utils/common_colors.dart';
import 'package:my_news/core/utils/common_strings.dart';
import 'package:my_news/presentation/provider/firebase_provider.dart';
import 'package:my_news/presentation/screens/signin/signin_screen.dart';
import 'package:my_news/presentation/widgets/common_btn.dart';
import 'package:my_news/presentation/widgets/textfield_container.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _email = "";
  String _password = "";

  saveData() async {
    FocusScope.of(context).unfocus();
    var result = _formKey.currentState!.validate();
    if (result) {
      _formKey.currentState!.save();
      context
          .read<FirebaseProvider>()
          .signUp(_name, _email, _password, context);
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
              const SizedBox(height: 150),
              TextfieldContainer(
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    _name = value;
                    saveData();
                  },
                  onSaved: (newValue) {
                    _name = newValue ?? "";
                  },
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: ' Name',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextfieldContainer(
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    _email = value;
                    saveData();
                  },
                  onSaved: (newValue) {
                    _email = newValue ?? "";
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
                  onFieldSubmitted: (value) {
                    _password = value;
                    saveData();
                  },
                  onSaved: (newValue) {
                    _password = newValue ?? "";
                  },
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
                  Consumer<FirebaseProvider>(builder: (_, provider, __) {
                    return CommonBtn(
                      onTap: () {
                        saveData();
                      },
                      isLoading: provider.isLoading,
                      title: 'SignUp',
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
                      text: 'Already have an account?',
                      children: [
                        TextSpan(
                          text: ' Login ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              FocusScope.of(context).unfocus();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                return const SignInScreen();
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

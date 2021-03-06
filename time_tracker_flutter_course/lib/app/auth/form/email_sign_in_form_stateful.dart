import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/form_submit_button.dart';
import '../../../common/show_exception_alert_dialog.dart';
import '../../../validator/email_and_password_validator.dart';
import '../model/email_sign_in_form_type.dart';
import '../service/auth_base.dart';

class EmailSignInFormStateful extends StatefulWidget
    with EmailAndPasswordValidator {
  final VoidCallback onSignIn;

  EmailSignInFormStateful({this.onSignIn});

  @override
  _EmailSignInFormStatefulState createState() =>
      _EmailSignInFormStatefulState();
}

class _EmailSignInFormStatefulState extends State<EmailSignInFormStateful> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();

  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    bool submitEnabled = !_isLoading &&
        widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password);

    return [
      _emailTextField(),
      SizedBox(height: 8.0),
      _passwordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(height: 8.0),
      TextButton(
        child: Text(secondaryText),
        onPressed: !_isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _emailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);

    return TextField(
      controller: _emailController,
      focusNode: _emailNode,
      autocorrect: false,
      key: Key('email'),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'user@example.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),
    );
  }

  TextField _passwordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);

    return TextField(
      controller: _passwordController,
      focusNode: _passwordNode,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      key: Key('password'),
      obscureText: true,
      onEditingComplete: _submit,
      onChanged: (email) => _updateState(),
    );
  }

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });

    try {
      final auth = Provider.of<AuthBase>(context, listen: false);

      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      if (widget.onSignIn != null) {
        widget.onSignIn();
      }
    } on FirebaseAuthException catch (exc) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: exc,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete() {
    final newFocus =
        widget.emailValidator.isValid(_email) ? _passwordNode : _emailNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _updateState() {
    setState(() {});
  }
}

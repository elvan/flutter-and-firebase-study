import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/form_submit_button.dart';
import '../../../common/show_exception_alert_dialog.dart';
import '../model/email_sign_in_notifier_model.dart';
import '../service/auth_base.dart';

class EmailSignInFormNotifierBased extends StatefulWidget {
  final EmailSignInNotifierModel model;

  EmailSignInFormNotifierBased({@required this.model});

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInNotifierModel>(
      create: (context) => EmailSignInNotifierModel(auth: auth),
      child: Consumer<EmailSignInNotifierModel>(
        builder: (_, model, __) => EmailSignInFormNotifierBased(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormNotifierBasedState createState() =>
      _EmailSignInFormNotifierBasedState();
}

class _EmailSignInFormNotifierBasedState
    extends State<EmailSignInFormNotifierBased> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();

  EmailSignInNotifierModel get model => widget.model;

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
    return [
      _emailTextField(),
      SizedBox(height: 8.0),
      _passwordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: model.primaryButtonText,
        disabledColor: Theme.of(context).disabledColor,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(model.secondaryButtonText),
        onPressed: !model.isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _emailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailNode,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'user@example.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      onEditingComplete: () => _emailEditingComplete(),
      onChanged: model.updateEmail,
    );
  }

  TextField _passwordTextField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordNode,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      onEditingComplete: _submit,
      onChanged: model.updatePassword,
    );
  }

  void _submit() async {
    try {
      await model.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (exc) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: exc,
      );
    }
  }

  void _toggleFormType() {
    model.toggleFormType();

    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete() {
    final newFocus =
        model.emailValidator.isValid(model.email) ? _passwordNode : _emailNode;
    FocusScope.of(context).requestFocus(newFocus);
  }
}

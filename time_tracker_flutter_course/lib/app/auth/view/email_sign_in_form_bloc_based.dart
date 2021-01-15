import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/form_submit_button.dart';
import '../../../common/show_exception_alert_dialog.dart';
import '../bloc/email_sign_in_bloc.dart';
import '../model/email_sign_in_model.dart';
import '../service/auth_base.dart';

class EmailSignInFormBlocBased extends StatefulWidget {
  final EmailSignInBloc bloc;

  EmailSignInFormBlocBased({@required this.bloc});

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (context) => EmailSignInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<EmailSignInBloc>(
        builder: (context, bloc, widget) =>
            EmailSignInFormBlocBased(bloc: bloc),
      ),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();

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
    return StreamBuilder<EmailSignInModel>(
      stream: widget.bloc.modelStream,
      initialData: EmailSignInModel(),
      builder: (context, snapshot) {
        final model = snapshot.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildChildren(model),
          ),
        );
      },
    );
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _emailTextField(model),
      SizedBox(height: 8.0),
      _passwordTextField(model),
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

  TextField _emailTextField(EmailSignInModel model) {
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
      onEditingComplete: () => _emailEditingComplete(model),
      onChanged: widget.bloc.updateEmail,
    );
  }

  TextField _passwordTextField(EmailSignInModel model) {
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
      onChanged: widget.bloc.updatePassword,
    );
  }

  void _submit() async {
    try {
      await widget.bloc.submit();
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
    widget.bloc.toggleFormType();

    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus =
        model.emailValidator.isValid(model.email) ? _passwordNode : _emailNode;
    FocusScope.of(context).requestFocus(newFocus);
  }
}

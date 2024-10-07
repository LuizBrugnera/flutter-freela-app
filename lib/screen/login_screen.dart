import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum UserType { client, freelancer }

final userTypeProvider = StateProvider<UserType>((ref) => UserType.client);

class LoginScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = useFormKey();
    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();
    final userType = ref.watch(userTypeProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(text: 'Cliente'),
                          Tab(text: 'Freelancer'),
                        ],
                        onTap: (index) {
                          ref.read(userTypeProvider.notifier).state =
                          index == 0 ? UserType.client : UserType.freelancer;
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Entrar como ${userType == UserType.client ? 'Cliente' : 'Freelancer'}',
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Implement login logic here
                      print('Login como ${userType == UserType.client ? 'Cliente' : 'Freelancer'}');
                      print('Email: ${_emailController.text}');
                      print('Senha: ${_passwordController.text}');
                    }
                  },
                  child: Text('Entrar'),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Implement forgot password logic
                  },
                  child: Text('Esqueceu a senha?'),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to registration screen
                  },
                  child: Text('Criar uma conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom hook for creating a GlobalKey<FormState>
GlobalKey<FormState> useFormKey() {
  return useMemoized(() => GlobalKey<FormState>());
}
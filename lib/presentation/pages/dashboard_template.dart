import 'package:digit/presentation/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardPageTemplate extends StatefulWidget {
  static const routeName = "/dashboard";
  const DashboardPageTemplate({super.key});
  @override
  State<DashboardPageTemplate> createState() => DashboardPageTemplateState();
}

class DashboardPageTemplateState extends State<DashboardPageTemplate> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {},
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<AuthCubit>().logout();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Welcome to Dashboard!'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    print("go");
                    context.goNamed('transaksi');
                    // context.go('/transaksi');
                  },
                  child: const Text('Go to Transaksi'),
                ),
              ],
            ),
          ),
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_video_call_app/features/users/presentation/video_screen.dart';
// import '../bloc/users_bloc.dart';
// import '../bloc/users_event.dart';
// import '../bloc/users_state.dart';
// import '../data/users_repository.dart';
//
// class UsersScreen extends StatelessWidget {
//   const UsersScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Users")),
//       body: BlocProvider(
//         create: (context) => UsersBloc(UserRepository())..add(LoadUsers()),
//         child: BlocBuilder<UsersBloc, UsersState>(
//           builder: (context, state) {
//             if (state is UsersLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is UsersLoaded) {
//               return ListView.builder(
//                 itemCount: state.users.length,
//                 itemBuilder: (context, index) {
//                   final user = state.users[index];
//                   return ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(user['avatar']),
//                     ),
//                     title: Text("${user['first_name']} ${user['last_name']}"),
//                     subtitle: Text(user['email']),
//                     onTap:
//                         () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => VideoScreen(),
//                           ),
//                         ),
//                   );
//                 },
//               );
//             } else {
//               return const Center(child: Text("Failed to load users"));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/users_bloc.dart';
import '../bloc/users_event.dart';
import '../bloc/users_state.dart';
import '../data/users_repository.dart';
import 'video_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: BlocProvider(
        create: (context) => UsersBloc(UserRepository())..add(LoadUsers()),
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UsersLoaded) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user['avatar']),
                    ),
                    title: Text("${user['first_name']} ${user['last_name']}"),
                    subtitle: Text(user['email']),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  VideoScreen(),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("Failed to load users"));
            }
          },
        ),
      ),
    );
  }
}

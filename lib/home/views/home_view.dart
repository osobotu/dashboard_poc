import 'package:dashboard_poc/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeInitial) {
            return const ShowProgress();
          } else if (state is HomeLoading) {
            return const ShowProgress();
          } else if (state is HomeSuccess) {
            return Row(
              children: [
                Container(
                  width: 255,
                  height: MediaQuery.of(context).size.height,
                  color: const Color(0xFF363740),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      ListTile(
                        leading: const Icon(
                          Icons.dashboard,
                          color: Colors.deepPurple,
                          size: 30,
                        ),
                        title: Text(
                          "Bellum",
                          style: textTheme.headline5!.copyWith(
                            color: const Color(0xFFA4A6B3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      ListTile(
                        leading: const Icon(
                          Icons.pie_chart,
                          color: Color(0xFFA4A6B3),
                        ),
                        title: Text(
                          'Overview',
                          style: textTheme.headline6!.copyWith(
                            color: const Color(0xFFA4A6B3),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.airplane_ticket,
                          color: Color(0xFFA4A6B3),
                        ),
                        title: Text(
                          'Tickets',
                          style: textTheme.headline6!.copyWith(
                            color: const Color(0xFFA4A6B3),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.bubble_chart,
                          color: Color(0xFFA4A6B3),
                        ),
                        title: Text(
                          'Ideas',
                          style: textTheme.headline6!.copyWith(
                            color: const Color(0xFFA4A6B3),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.people,
                          color: Color(0xFFA4A6B3),
                        ),
                        title: Text(
                          'Contacts',
                          style: textTheme.headline6!.copyWith(
                            color: const Color(0xFFA4A6B3),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.person_add_alt_1,
                          color: Color(0xFFA4A6B3),
                        ),
                        title: Text(
                          'Agents',
                          style: textTheme.headline6!.copyWith(
                            color: const Color(0xFFA4A6B3),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.article,
                          color: Color(0xFFA4A6B3),
                        ),
                        title: Text(
                          'Articles',
                          style: textTheme.headline6!.copyWith(
                            color: const Color(0xFFA4A6B3),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF7F8FC),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Overview',
                                style: textTheme.headline4!
                                    .copyWith(color: Colors.black),
                              ),
                              Row(
                                children: [
                                  const Text('Log Out'),
                                  IconButton(
                                    tooltip: 'Log Out',
                                    icon: const Icon(Icons.logout),
                                    color: Colors.deepPurple,
                                    onPressed: () {
                                      context.go('/');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const OverviewCard(
                                title: 'Unresolved',
                                value: 60,
                              ),
                              const OverviewCard(
                                title: 'Overdue',
                                value: 16,
                              ),
                              const OverviewCard(
                                title: 'Open',
                                value: 43,
                              ),
                              const OverviewCard(
                                title: 'On Hold',
                                value: 64,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 0),
                          child: Card(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 400,
                                child: const Center(
                                    child: Text('Today\'s trends'))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 255,
                  height: MediaQuery.of(context).size.height,
                  color: const Color(0xFFA4A6B3),
                  child: Column(
                    children: [
                      ...state.users
                          .map(
                            (user) => ListTile(
                              title: Text(
                                '${user.firstName} ${user.lastName}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(user.email),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(user.avatar)),
                            ),
                          )
                          .toList()
                    ],
                  ),
                ),
              ],
            );
          } else if (state is HomeFailure) {
            return ErrorView(errorMessage: state.errorMessage);
          } else {
            return const InitialView();
          }
        },
      ),
    );
  }
}

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 258,
      height: 134,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDFE0EB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          Text(
            value.toString(),
            style: textTheme.displaySmall,
          )
        ],
      ),
    );
  }
}

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Fetch Users List'),
        onPressed: () {
          context.read<HomeCubit>().getUsers();
        },
      ),
    );
  }
}

class ShowProgress extends StatelessWidget {
  const ShowProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  const UsersList({super.key, required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: ((context, index) {
          final user = users[index];
          return ListTile(
            title: Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Text(user.email),
            leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
          );
        }),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.redAccent),
      ),
    );
  }
}

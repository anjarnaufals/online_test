import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_test/data/model/contact_model.dart';
import 'package:online_test/presentation/contact/cubit/contact_cubit.dart';
import 'package:online_test/presentation/contact/ui/contact_screen.dart';

class CustomSearchDelegate extends SearchDelegate<ContactModel> {
  // These methods are mandatory you cannot skip them.

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          // When pressed here the query will be cleared from the search bar.
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
      // Exit from the search screen.
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final contactList = context.read<ContactCubit>();

    final List<ContactModel> searchResults = contactList.state.listContact
        .where((item) =>
            item.firstName!.toLowerCase().contains(query.toLowerCase()) ||
            item.lastName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: ContactGridList(data: searchResults),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchList = context.read<ContactCubit>().state.listContact;

    final List<ContactModel> suggestionList = query.isEmpty
        ? []
        : searchList
            .where((item) =>
                item.firstName!.toLowerCase().contains(query.toLowerCase()) ||
                item.lastName!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (_, i) {
        return ListTile(
          title: Text('${suggestionList[i].firstName}'),
          onTap: () {
            query = suggestionList[i].firstName ?? '';
            showResults(context);
          },
        );
      },
    );
  }
}

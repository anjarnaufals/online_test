import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_test/data/model/contact_model.dart';
import 'package:online_test/presentation/contact/cubit/contact_cubit.dart';
import 'package:online_test/presentation/contact_manage/extra/contact_manage_type.dart';
import 'package:online_test/theme/app_color.dart';

@RoutePage()
class ContactManageScreen extends StatelessWidget {
  const ContactManageScreen({
    super.key,
    this.contact,
    required this.manageType,
  });

  final ContactModel? contact;
  final String manageType;

  @override
  Widget build(BuildContext context) {
    return _Content(
      contact,
      manageType,
    );
  }
}

class _Content extends StatefulWidget {
  const _Content(
    this.data,
    this.type,
  );

  final ContactModel? data;
  final String type;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController dob = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstName.text = widget.data?.firstName ?? '';
    lastName.text = widget.data?.lastName ?? '';
    email.text = widget.data?.email ?? '';
    dob.text = widget.data?.dob ?? '';
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    dob.dispose();
    super.dispose();
  }

  void onSaveContact() {
    if (firstName.text.isEmpty) {
      ScaffoldMessenger.maybeOf(context)?.removeCurrentSnackBar();
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(
          content: Text(
            'First Name cannot empty',
          ),
        ),
      );
      return;
    }
    if (lastName.text.isEmpty) {
      ScaffoldMessenger.maybeOf(context)?.removeCurrentSnackBar();
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(
          content: Text(
            'Last Name cannot empty',
          ),
        ),
      );
      return;
    }

    ContactModel contact = ContactModel(
      id: widget.data != null
          ? widget.data!.id
          : '${Random().nextInt(9999) + 999999}',
      firstName: firstName.text,
      lastName: lastName.text,
      email: email.text,
      dob: dob.text,
    );

    if (widget.type == ContactManageType.edit) {
      context.read<ContactCubit>().updateContact(contact);
      ScaffoldMessenger.maybeOf(context)?.removeCurrentSnackBar();
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(
          content: Text(
            'Contact Updated',
          ),
        ),
      );
    }
    if (widget.type == ContactManageType.create) {
      context.read<ContactCubit>().create(contact);
      ScaffoldMessenger.maybeOf(context)?.removeCurrentSnackBar();
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(
          content: Text(
            'Contact Created',
          ),
        ),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: FittedBox(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: const Color(0xFFff8c00),
                  ),
            ),
          ),
        ),
        actions: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 56,
              minWidth: 56,
            ),
            child: FittedBox(
              child: TextButton(
                onPressed: () {
                  onSaveContact();
                },
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: const Color(0xFFff8c00),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.width * .5,
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.mainColor,
                    shape: BoxShape.circle,
                  ),
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[400],
              ),
              child: Text(
                'Main Information',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            sliver: SliverList.list(
              children: [
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: FittedBox(child: Text('First Name')),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      flex: 7,
                      child: TextField(
                        controller: firstName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: FittedBox(
                        child: Text('Last Name'),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      flex: 7,
                      child: TextField(
                        controller: lastName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[400],
              ),
              child: Text(
                'Sub Information',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            sliver: SliverList.list(
              children: [
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text('Email'),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      flex: 7,
                      child: TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text('DOB'),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      flex: 7,
                      child: TextField(
                        controller: dob,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: kToolbarHeight,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_test/data/model/contact_model.dart';
import 'package:online_test/presentation/contact_manage/extra/contact_manage_type.dart';
import 'package:online_test/routes/app_auto_routes.gr.dart';
import 'package:online_test/theme/app_color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../main.dart';
import '../cubit/contact_cubit.dart';
import '../extra/contact_search.dart';

@RoutePage()
class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    context.read<ContactCubit>().getListContact();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Contact',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
          icon: const Icon(
            Icons.search,
            color: AppColor.mainColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              App.router.push(ContactManageRoute(
                manageType: ContactManageType.create,
              ));
            },
            icon: const Icon(
              Icons.add,
              color: AppColor.mainColor,
            ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: false,
        enablePullDown: true,
        onRefresh: () async {
          _refreshController.requestRefresh();
          await context.read<ContactCubit>().getListContact(
                isRefresh: true,
              );
          _refreshController.refreshCompleted();
        },
        header: const ClassicHeader(),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            BlocBuilder<ContactCubit, ContactState>(
              builder: (_, state) {
                if (state.loading) {
                  return const SliverFillRemaining(
                    child: CenterLoading(),
                  );
                }

                if (!state.loading && state.errMsg.isNotEmpty) {
                  return SliverFillRemaining(
                    child: Text(state.errMsg),
                  );
                }

                if (!state.loading && state.listContact.isNotEmpty) {
                  return SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: ContactGridList(
                      data: state.listContact,
                    ),
                  );
                }

                return const SliverToBoxAdapter();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactGridList extends StatelessWidget {
  const ContactGridList({
    super.key,
    required this.data,
  });

  final List<ContactModel> data;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5 / 5,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (_, i) {
        final item = data[i];

        return GestureDetector(
          onTap: () {
            App.router.push(ContactManageRoute(
              contact: item,
              manageType: ContactManageType.edit,
            ));
          },
          child: _ContactItemWidget(item: item),
        );
      },
    );
  }
}

class _ContactItemWidget extends StatelessWidget {
  const _ContactItemWidget({
    required this.item,
  });

  final ContactModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.grey[400]!,
          ),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const CircleAvatar(
            backgroundColor: AppColor.mainColor,
            child: SizedBox(
              height: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${item.firstName} ${item.lastName}',
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class CenterLoading extends StatelessWidget {
  const CenterLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColor.mainColor),
        ),
      ),
    );
  }
}

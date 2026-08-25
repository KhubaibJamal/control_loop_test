import 'package:control_loop_test/data/models/service_models.dart';
import 'package:control_loop_test/presentation/view/widgets/custom_text_form_field.dart';
import 'package:control_loop_test/presentation/view/widgets/provider_list_card.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/constants/demo_data.dart';
import 'package:control_loop_test/res/constants/media_constants.dart';
import 'package:control_loop_test/res/routes/routes.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceCategoryScreen extends StatefulWidget {
  final String title;

  const ServiceCategoryScreen({
    super.key,
    this.title = 'Home cleaning',
  });

  @override
  State<ServiceCategoryScreen> createState() => _ServiceCategoryScreenState();
}

class _ServiceCategoryScreenState extends State<ServiceCategoryScreen> {
  late final Map<String, bool> _bookmarked;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _bookmarked = {
      for (final p in DemoData.categoryProviders) p.id: p.bookmarked,
    };
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ProviderItem> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return DemoData.categoryProviders;
    return DemoData.categoryProviders
        .where((p) => p.name.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final providers = _filtered;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        16.rw(context),
                        8.rh(context),
                        16.rw(context),
                        0,
                      ),
                      child: Row(
                        children: [
                          _backButton(context),
                          SizedBox(width: 16.rw(context)),
                          Expanded(
                            child: Text(
                              widget.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                fontSize: 18.rf(context),
                                fontWeight: FontWeight.w600,
                                color: CustomColors.primaryTextColor,
                                fontFamily: Constants.fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.rh(context)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.rw(context)),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _searchController,
                              hintText: Constants.searchProvidersHint,
                              dense: true,
                              fillColor: CustomColors.white,
                              borderColor: CustomColors.borderColor,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 4.rw(context),
                                vertical: 12.rh(context),
                              ),
                              prefixContainer: Icon(
                                Icons.search_rounded,
                                color: CustomColors.textFieldHintColor,
                                size: 20.rf(context),
                              ),
                              onChange: (value) {
                                setState(() => _query = value?.toString() ?? '');
                              },
                            ),
                          ),
                          SizedBox(width: 12.rw(context)),
                          Container(
                            height: 44.rh(context),
                            width: 52.rw(context),
                            decoration: BoxDecoration(
                              color: CustomColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: CustomColors.borderColor),
                            ),
                            child: Icon(
                              Icons.tune_rounded,
                              color: CustomColors.primaryTextColor,
                              size: 20.rf(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.rh(context)),
                    Expanded(
                      child: providers.isEmpty
                          ? Center(
                              child: Text(
                                'No providers found',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: CustomColors.secondaryTextColor,
                                  fontFamily: Constants.fontFamily,
                                ),
                              ),
                            )
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              padding: EdgeInsets.fromLTRB(
                                16.rw(context),
                                0,
                                16.rw(context),
                                16.rh(context),
                              ),
                              itemCount: providers.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 12.rh(context)),
                              itemBuilder: (context, index) {
                                final provider = providers[index];
                                return ProviderListCard(
                                  provider: provider.copyWith(
                                    bookmarked:
                                        _bookmarked[provider.id] ?? false,
                                  ),
                                  onTap: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.detailScreen,
                                      arguments: provider,
                                    );
                                  },
                                  onBook: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.detailScreen,
                                      arguments: provider,
                                    );
                                  },
                                  onBookmark: () {
                                    setState(() {
                                      _bookmarked[provider.id] =
                                          !(_bookmarked[provider.id] ?? false);
                                    });
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Material(
      color: CustomColors.bodyGrey,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => Navigator.pop(context),
        child: SizedBox(
          width: 40.rw(context),
          height: 40.rh(context),
          child: Center(
            child: SvgPicture.asset(
              MediaConstants.arrowLeftIcon,
              width: 16.rw(context),
              height: 16.rh(context),
            ),
          ),
        ),
      ),
    );
  }
}

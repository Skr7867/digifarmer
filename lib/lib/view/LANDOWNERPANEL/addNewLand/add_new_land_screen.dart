import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/LANDOWNERPANEL/basicInfo/basic_info_bloc.dart';
import '../../../config/routes/routes_name.dart';
import '../../../main.dart';
import '../../../repository/LANDOWNERPANEL/saveBasicInfo/save_basic_info_repository.dart';
import '../../../res/customeWidgets/custom_textfield.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/enums.dart';
import '../../../utils/flush_bar_helper.dart';

// ── Brand colours ──────────────────────────────────────────
const _kGreen = Color(0xff2FA66A);
const _kBlue = Color(0xff0D47A1);
const _kBg = Color(0xffF0F4F8);
const _kCard = Colors.white;

class AddNewLandScreen extends StatefulWidget {
  final String? uniqueKey;

  const AddNewLandScreen({super.key, this.uniqueKey});

  @override
  State<AddNewLandScreen> createState() => _AddNewLandScreenState();
}

class _AddNewLandScreenState extends State<AddNewLandScreen> {
  late final SaveBasicInfoBloc _saveBasicInfoBloc;

  final _landTitleController = TextEditingController();
  final _surveyNumberController = TextEditingController();
  final _areaValueController = TextEditingController();
  final _totalSizeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _soilTypeController = TextEditingController();
  final _expectedMonthlyRentController = TextEditingController();
  final _minimumLeaseDurationController = TextEditingController();

  bool borewell = false;
  bool canal = false;
  bool openWell = false;
  bool rainwater = false;

  String _selectedAreaUnit = 'ACRE';
  final List<String> _areaUnits = ['ACRE', 'HECTARE', 'SQFT', 'SQMT'];

  @override
  void initState() {
    super.initState();
    _saveBasicInfoBloc = SaveBasicInfoBloc(getIt<SaveBasicInfoRepository>());
    if (widget.uniqueKey != null) {
      _saveBasicInfoBloc.add(SetUniqueKey(widget.uniqueKey!));
    }
  }

  @override
  void dispose() {
    _saveBasicInfoBloc.close();
    _landTitleController.dispose();
    _surveyNumberController.dispose();
    _areaValueController.dispose();
    _totalSizeController.dispose();
    _descriptionController.dispose();
    _soilTypeController.dispose();
    _expectedMonthlyRentController.dispose();
    _minimumLeaseDurationController.dispose();
    super.dispose();
  }

  List<String> _getSelectedWaterSources() {
    final sources = <String>[];
    if (borewell) sources.add('BOREWELL');
    if (canal) sources.add('CANAL');
    if (openWell) sources.add('OPEN_WELL');
    if (rainwater) sources.add('RAINWATER');
    return sources;
  }

  void _updateWaterSources() =>
      _saveBasicInfoBloc.add(WaterSourceChanged(_getSelectedWaterSources()));

  void _updateAllFields(BuildContext context) {
    final bloc = context.read<SaveBasicInfoBloc>();
    bloc.add(LandTitleChanged(_landTitleController.text));
    bloc.add(SurveyNumberChanged(_surveyNumberController.text));
    final areaValue = double.tryParse(_areaValueController.text) ?? 0.0;
    bloc.add(AreaValueChanged(areaValue));
    bloc.add(AreaUnitChanged(_selectedAreaUnit));
    final totalSize = double.tryParse(_totalSizeController.text) ?? areaValue;
    bloc.add(TotalSizeChanged(totalSize));
    bloc.add(DescriptionChanged(_descriptionController.text));
    bloc.add(SoilTypeChanged(_soilTypeController.text));
    _updateWaterSources();
    bloc.add(RoadAccessChanged(true));
    final rent = double.tryParse(_expectedMonthlyRentController.text) ?? 0.0;
    bloc.add(ExpectedMonthlyRentChanged(rent));
    final duration = int.tryParse(_minimumLeaseDurationController.text) ?? 12;
    bloc.add(MinimumLeaseDurationChanged(duration));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _saveBasicInfoBloc,
      child: Scaffold(
        backgroundColor: _kBg,
        body: BlocListener<SaveBasicInfoBloc, SaveBasicInfoState>(
          listenWhen: (p, c) => p.postApiStatus != c.postApiStatus,
          listener: (context, state) {
            if (state.postApiStatus == PostApiStatus.error) {
              FlushBarHelper.flushBarErrorMessage(state.message, context);
            }
            if (state.postApiStatus == PostApiStatus.success) {
              FlushBarHelper.flushBarSuccessMessage(
                state.message.isNotEmpty
                    ? state.message
                    : "Land information saved successfully!",
                context,
              );
              Navigator.pushNamed(
                context,
                RoutesName.locationScreen,
                arguments: state.tempId,
              );
            }
          },
          child: Form(
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                /// ===== HEADER (scrolls away with the page) =====
                SliverToBoxAdapter(child: _buildHeader(context)),

                /// ===== BASIC INFO =====
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: _BasicInfoSection(
                      surveyController: _surveyNumberController,
                      areaController: _areaValueController,
                      selectedUnit: _selectedAreaUnit,
                      units: _areaUnits,
                      onUnitChanged: (v) =>
                          setState(() => _selectedAreaUnit = v),
                    ),
                  ),
                ),

                /// ===== FARMING DETAILS =====
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: _FarmingDetailsSection(
                      landTitleController: _landTitleController,
                      soilTypeController: _soilTypeController,
                      descriptionController: _descriptionController,
                      borewell: borewell,
                      canal: canal,
                      openWell: openWell,
                      rainwater: rainwater,
                      onWaterChanged: (key, val) {
                        setState(() {
                          if (key == 'borewell') borewell = val;
                          if (key == 'canal') canal = val;
                          if (key == 'openWell') openWell = val;
                          if (key == 'rainwater') rainwater = val;
                        });
                        _updateWaterSources();
                      },
                    ),
                  ),
                ),

                /// ===== LEASE PREFERENCES =====
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: _LeaseSection(
                      rentController: _expectedMonthlyRentController,
                      durationController: _minimumLeaseDurationController,
                    ),
                  ),
                ),

                /// ===== SUBMIT BUTTON =====
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
                  sliver: SliverToBoxAdapter(
                    child: _SubmitButton(onSubmit: _updateAllFields),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16,
        right: 16,
        bottom: 22,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff0D47A1), Color(0xff1B6CA8), _kGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Add New Land",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Register Your Land\nComplete the form to add your property",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppFonts.popins,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Registration Progress",
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: AppFonts.popins,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Step ${state.currentStep} of 3",
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.popins,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: state.currentStep / 3,
                          backgroundColor: Colors.white.withValues(alpha: 0.25),
                          color: Colors.white,
                          minHeight: 6,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (i) {
                          final done = i + 1 <= state.currentStep;
                          return Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: done ? Colors.white : Colors.white30,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: done
                                ? const Icon(
                                    Icons.check,
                                    size: 9,
                                    color: _kGreen,
                                  )
                                : null,
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Basic Info",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                      Text(
                        "Location",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                      Text(
                        "Documents",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// SECTION CARD WRAPPER
// ─────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final List<Widget> children;

  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                  color: Color(0xff1A1A2E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Divider(color: Color(0xffF0F0F0)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// FIELD LABEL
// ─────────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: AppFonts.popins,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xff555555),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// BASIC INFO SECTION
// ─────────────────────────────────────────────────────────
class _BasicInfoSection extends StatelessWidget {
  final TextEditingController surveyController;
  final TextEditingController areaController;
  final String selectedUnit;
  final List<String> units;
  final ValueChanged<String> onUnitChanged;

  const _BasicInfoSection({
    required this.surveyController,
    required this.areaController,
    required this.selectedUnit,
    required this.units,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      icon: Icons.info_outline,
      iconColor: _kBlue,
      title: "Basic Information",
      children: [
        const _FieldLabel("Khasra / Survey Number"),
        BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
          builder: (context, state) {
            return CustomTextField(
              controller: surveyController,
              hintText: "e.g. 123/4A",
              onChanged: (v) =>
                  context.read<SaveBasicInfoBloc>().add(SurveyNumberChanged(v)),
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Survey number is required' : null,
            );
          },
        ),
        const SizedBox(height: 14),
        const _FieldLabel("Land Area"),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: areaController,
                    hintText: "Enter area value",
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      final area = double.tryParse(v) ?? 0.0;
                      context.read<SaveBasicInfoBloc>().add(
                        AreaValueChanged(area),
                      );
                      context.read<SaveBasicInfoBloc>().add(
                        TotalSizeChanged(area),
                      );
                    },
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Area is required' : null,
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xffF5F7FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xffE0E0E0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedUnit,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: _kGreen,
                      size: 20,
                    ),
                    style: const TextStyle(
                      fontFamily: AppFonts.popins,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff333333),
                    ),
                    items: units
                        .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        onUnitChanged(v);
                        context.read<SaveBasicInfoBloc>().add(
                          AreaUnitChanged(v),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────
// FARMING DETAILS SECTION
// ─────────────────────────────────────────────────────────
class _FarmingDetailsSection extends StatelessWidget {
  final TextEditingController landTitleController;
  final TextEditingController soilTypeController;
  final TextEditingController descriptionController;
  final bool borewell, canal, openWell, rainwater;
  final void Function(String key, bool val) onWaterChanged;

  const _FarmingDetailsSection({
    required this.landTitleController,
    required this.soilTypeController,
    required this.descriptionController,
    required this.borewell,
    required this.canal,
    required this.openWell,
    required this.rainwater,
    required this.onWaterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final waterSources = [
      _WaterData(
        'Borewell',
        Icons.water_drop_outlined,
        const Color(0xff1565C0),
        borewell,
        'borewell',
      ),
      _WaterData(
        'Canal',
        Icons.waves_outlined,
        const Color(0xff00838F),
        canal,
        'canal',
      ),
      _WaterData(
        'Open Well',
        Icons.circle_outlined,
        const Color(0xff2E7D32),
        openWell,
        'openWell',
      ),
      _WaterData(
        'Rainwater',
        Icons.umbrella_outlined,
        const Color(0xff6A1B9A),
        rainwater,
        'rainwater',
      ),
    ];

    return _SectionCard(
      icon: Icons.agriculture_outlined,
      iconColor: _kGreen,
      title: "Farming Details",
      children: [
        const _FieldLabel("Land Title"),
        BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
          builder: (context, state) {
            return CustomTextField(
              controller: landTitleController,
              hintText: "e.g. Green Valley Farm",
              onChanged: (v) =>
                  context.read<SaveBasicInfoBloc>().add(LandTitleChanged(v)),
            );
          },
        ),
        const SizedBox(height: 14),
        const _FieldLabel("Water Source"),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3.2,
          children: waterSources
              .map(
                (w) => _WaterSourceChip(
                  data: w,
                  onTap: () => onWaterChanged(w.key, !w.selected),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 14),
        const _FieldLabel("Soil Type"),
        BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
          builder: (context, state) {
            return CustomTextField(
              controller: soilTypeController,
              hintText: "e.g. Clay, Loamy, Sandy",
              onChanged: (v) =>
                  context.read<SaveBasicInfoBloc>().add(SoilTypeChanged(v)),
            );
          },
        ),
        const SizedBox(height: 14),
        const _FieldLabel("Land Description"),
        BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
          builder: (context, state) {
            return CustomTextField(
              controller: descriptionController,
              hintText: "Describe the land, crops suitable, accessibility...",

              onChanged: (v) =>
                  context.read<SaveBasicInfoBloc>().add(DescriptionChanged(v)),
            );
          },
        ),
      ],
    );
  }
}

class _WaterData {
  final String label;
  final IconData icon;
  final Color color;
  final bool selected;
  final String key;

  const _WaterData(this.label, this.icon, this.color, this.selected, this.key);
}

class _WaterSourceChip extends StatelessWidget {
  final _WaterData data;
  final VoidCallback onTap;

  const _WaterSourceChip({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: data.selected
              ? data.color.withValues(alpha: 0.1)
              : const Color(0xffF5F7FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: data.selected ? data.color : const Color(0xffE0E0E0),
            width: data.selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              data.selected ? Icons.check_circle : data.icon,
              color: data.selected ? data.color : Colors.grey.shade400,
              size: 16,
            ),
            const SizedBox(width: 7),
            Text(
              data.label,
              style: TextStyle(
                fontFamily: AppFonts.popins,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: data.selected ? data.color : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// LEASE SECTION
// ─────────────────────────────────────────────────────────
class _LeaseSection extends StatelessWidget {
  final TextEditingController rentController;
  final TextEditingController durationController;

  const _LeaseSection({
    required this.rentController,
    required this.durationController,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      icon: Icons.handshake_outlined,
      iconColor: const Color(0xffFFA000),
      title: "Lease Preferences",
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _FieldLabel("Monthly Rent (₹)"),
                  BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
                    builder: (context, state) {
                      return CustomTextField(
                        controller: rentController,
                        hintText: "e.g. 5000",
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          final rent = double.tryParse(v) ?? 0.0;
                          context.read<SaveBasicInfoBloc>().add(
                            ExpectedMonthlyRentChanged(rent),
                          );
                        },
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'Rent is required'
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _FieldLabel("Min. Lease (months)"),
                  BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
                    builder: (context, state) {
                      return CustomTextField(
                        controller: durationController,
                        hintText: "e.g. 12",
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          final dur = int.tryParse(v) ?? 12;
                          context.read<SaveBasicInfoBloc>().add(
                            MinimumLeaseDurationChanged(dur),
                          );
                        },
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'Duration is required'
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xffFFF8E1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xffFFA000).withValues(alpha: 0.3),
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xffFFA000), size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Competitive rents attract more farmers. Research local rates before setting your price.",
                  style: TextStyle(
                    fontFamily: AppFonts.popins,
                    fontSize: 11,
                    color: Color(0xff7B5A00),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────
// SUBMIT BUTTON
// ─────────────────────────────────────────────────────────
class _SubmitButton extends StatelessWidget {
  final void Function(BuildContext) onSubmit;

  const _SubmitButton({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
      buildWhen: (p, c) => p.postApiStatus != c.postApiStatus,
      builder: (context, state) {
        final isLoading = state.postApiStatus == PostApiStatus.loading;
        return GestureDetector(
          onTap: isLoading
              ? null
              : () {
                  onSubmit(context);
                  context.read<SaveBasicInfoBloc>().add(SubmitSaveBasicInfo());
                },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 54,
            decoration: BoxDecoration(
              gradient: isLoading
                  ? null
                  : const LinearGradient(
                      colors: [_kGreen, Color(0xff1B8C56)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              color: isLoading ? Colors.grey.shade300 : null,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isLoading
                  ? []
                  : [
                      BoxShadow(
                        color: _kGreen.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.popins,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

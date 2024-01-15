import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/settings/presentation/manager/manage_cubit/manage_cubit.dart';
import 'package:tamrini/features/settings/presentation/manager/manage_cubit/manage_states.dart';

class LanguageContainerWidget extends StatelessWidget {
  const LanguageContainerWidget({
    super.key,
    required this.lable,
    required this.onTap,
    required this.isSelected,
    required this.image,
  });
  final String lable;
  final VoidCallback onTap;
  final bool isSelected;
  final String image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCubit, ManageStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              decoration: BoxDecoration(
                color: isSelected ? appColor.withOpacity(0.5) : null,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? appColor : blackColor,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30,
                      child: Image.asset(
                        image,
                        color: isSelected ? whiteColor : appColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      lable,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? whiteColor : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

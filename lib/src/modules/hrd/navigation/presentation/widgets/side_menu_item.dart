import 'package:smatrackz/core.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    super.key,
    required this.isActive,
    required this.isExpanded,
    this.isHover = false,
    this.itemCount = 0,
    this.showBorder = true,
    required this.icon,
    required this.title,
    required this.press,
  });

  final bool isActive, isHover, showBorder, isExpanded;
  final int itemCount;
  final IconData icon;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 15.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: (isActive || isHover)
                  ? AppColors.primaryColor
                  : AppColors.greyColor,
            ),
            if (isExpanded || size.width > 1200)
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  title,
                  style: CustomTextStyle.textLargeSemiBold.copyWith(
                    color: (isActive || isHover)
                        ? AppColors.primaryColor
                        : AppColors.greyColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

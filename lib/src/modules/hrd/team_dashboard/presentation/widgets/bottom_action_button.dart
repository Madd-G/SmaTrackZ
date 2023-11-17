import 'package:smatrackz/core.dart';

class BottomActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onPressed;

  const BottomActionButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton.icon(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff00060b),
            shape: const StadiumBorder(),
          ),
          onPressed: () => onPressed(),
        ),
      ),
    );
  }
}

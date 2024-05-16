part of 'screen.dart';

class _StoreHomeWidget extends StatelessWidget {
  const _StoreHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF6F0E7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Para você",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          _ProductWidgetCarousel(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Novidades",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          _ProductWidgetCarousel(),
        ],
      ),
    );
  }
}

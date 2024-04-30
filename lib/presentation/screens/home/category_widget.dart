part of 'home_screen.dart';

class _CategoryWidget extends StatefulWidget {
  final String category;

  const _CategoryWidget({Key? key, required this.category}) : super(key: key);

  @override
  State<_CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<_CategoryWidget> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: _isSelected
              ? Color.fromARGB(216, 187, 149, 72)
              : const Color(0xFFF6F0E7),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.category == 'Recomendados')
                Icon(
                  Icons.star,
                ),
              if (widget.category == 'Dourada') Icon(Icons.wine_bar),
              if (widget.category == 'Prata') Icon(Icons.local_drink),
              SizedBox(width: 8),
              Text(
                widget.category,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

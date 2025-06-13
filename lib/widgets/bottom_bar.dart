import "package:flutter/material.dart";


class CurvedBottomNavScreen extends StatefulWidget {
  @override
  _CurvedBottomNavScreenState createState() => _CurvedBottomNavScreenState();
}

class _CurvedBottomNavScreenState extends State<CurvedBottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const[
    Center(child: Text('Home Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Search Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Add Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Settings Screen', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset:const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          child: CustomPaint(
            painter: CurvesPainter(),
            child: Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home_outlined, 0),
                  _buildNavItem(Icons.search_outlined, 1),
                  _buildNavItem(Icons.add_outlined, 2),
                  _buildNavItem(Icons.person_outline, 3),
                  _buildNavItem(Icons.settings_outlined, 4),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding:const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();

    path.moveTo(0, 0);

    // Left curve to center
    path.quadraticBezierTo(
      size.width * 0.25, 0,
      size.width * 0.40, 0,
    );

    // Dip in the center
    path.quadraticBezierTo(
      size.width * 0.48, 0,
      size.width * 0.50, 20, // dip depth
    );
    path.quadraticBezierTo(
      size.width * 0.52, 0,
      size.width * 0.60, 0,
    );

    // Right curve out
    path.quadraticBezierTo(
      size.width * 0.75, 0,
      size.width, 0,
    );

    // Complete bottom nav shape
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
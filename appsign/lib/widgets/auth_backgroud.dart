import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _HalfScreen(),
          _HeaderIcon(),
          child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 70),
        child: const Icon(Icons.person_pin, color: Colors.white, size: 120),
      ),
    );
  }
}

class _HalfScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          // ignore: sort_child_properties_last
          Positioned(child: _Bubble(), top: 150, left: 30),
          // ignore: sort_child_properties_last
          Positioned(child: _Bubble(), top: -50, left: -30),
          // ignore: sort_child_properties_last
          Positioned(child: _Bubble(), top: 10, right: -20),
          // ignore: sort_child_properties_last
          Positioned(child: _Bubble(), top: 310, right: -20),
          // ignore: sort_child_properties_last
          Positioned(child: _Bubble(), top: 35, left: 200),
          // ignore: sort_child_properties_last
          Positioned(child: _Bubble(), bottom: -40, left: 80),
          // ignore: sort_child_properties_last
          Positioned(child: _Bubble(), bottom: 80, left: 260),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(126, 65, 140, 1),
            Color.fromRGBO(90, 125, 189, 1),
          ],
        ),
      );
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}

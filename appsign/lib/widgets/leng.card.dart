import 'package:appsign/models/models.dart';
import 'package:flutter/material.dart';

class LengCard extends StatelessWidget {
  final Lang lang;
  const LengCard({Key? key, required this.lang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(lang.picture),
            _ImageDetails(
              title: lang.name,
              subTitle: lang.id!,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _LangTag(letter: lang.letter),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _LangTag extends StatelessWidget {
  final String letter;

  const _LangTag({required this.letter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(letter,
                style: const TextStyle(color: Colors.white, fontSize: 30))),
      ),
    );
  }
}

// ignore: prefer_const_constructors
class _ImageDetails extends StatelessWidget {
  final String title;
  final String subTitle;

  const _ImageDetails({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              //'ABECEDARIO',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitle,
              //"LENGUA DE SEÑAS",
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), topRight: Radius.circular(25)),
      );
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage(this.url);
  //const _BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(25),
        // ignore: sized_box_for_whitespace
        child: Container(
          width: double.infinity,
          height: 400,
          child: url == null
              // fix productos cuando no hay imagenes
              ? const Image(
                  image: AssetImage('assets/no-image.png'), fit: BoxFit.cover)
              // para esta opcion quitar desde url == null hasta aqui y quitar los dospuntos antes de FadeInImage
              : FadeInImage(
                  placeholder: const AssetImage('assets/jar-loading.gif'),
                  image: NetworkImage(url!),
                  //('https://place-hold.it/400x300/666')
                  fit: BoxFit.cover,
                ),
        ));
  }
}

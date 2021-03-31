import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;

  final Color colorPrimario;
  final Color colorSecundario;

  final double bulletPrimario;
  final double bulletSecundario;

  SlideShow(
      {required this.slides,
      this.puntosArriba = false,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.grey,
      this.bulletPrimario = 12,
      this.bulletSecundario = 12});

  @override
  Widget build(BuildContext context) {
    final int numeroDePuntos = slides.length;

    return ChangeNotifierProvider(
      create: (_) => _SlishowModel(),
      child: SafeArea(
        child: Center(child: Builder(
          builder: (BuildContext context) {
            Provider.of<_SlishowModel>(context).colorPrimario =
                this.colorPrimario;
            Provider.of<_SlishowModel>(context).colorSecundario =
                this.colorSecundario;

            Provider.of<_SlishowModel>(context).bulletPrimario =
                this.bulletPrimario;

            Provider.of<_SlishowModel>(context).bulletSecundario =
                this.bulletSecundario;

            return _Columnas(
                puntosArriba: puntosArriba,
                numeroDePuntos: numeroDePuntos,
                slides: slides);
          },
        )),
      ),
    );
  }
}

class _Columnas extends StatelessWidget {
  final bool puntosArriba;
  final int numeroDePuntos;
  final List<Widget> slides;

  const _Columnas({
    required this.puntosArriba,
    required this.numeroDePuntos,
    required this.slides,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (this.puntosArriba) _Dots(numeroDePuntos),
        Expanded(child: _Slides(this.slides)),
        if (!this.puntosArriba) _Dots(numeroDePuntos),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int numeroDePuntos;

  const _Dots(this.numeroDePuntos);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(numeroDePuntos, (index) => _Dot(index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final slideshowModel = Provider.of<_SlishowModel>(context);
    final bool seleccionado = (slideshowModel.currentPage >= index - 0.5 &&
        slideshowModel.currentPage < index + 0.5);

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: seleccionado
          ? slideshowModel.bulletPrimario
          : slideshowModel.bulletSecundario,
      height: seleccionado
          ? slideshowModel.bulletPrimario
          : slideshowModel.bulletSecundario,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: seleccionado
              ? slideshowModel.colorPrimario
              : slideshowModel.colorSecundario,
          shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides(this.slides);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViweController = PageController();

  @override
  void initState() {
    pageViweController.addListener(() {
      Provider.of<_SlishowModel>(context, listen: false).currentPage =
          pageViweController.page!;
    });

    super.initState();
  }

  @override
  void dispose() {
    pageViweController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        physics: BouncingScrollPhysics(),
        controller: pageViweController,
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: slide,
    );
  }
}

class _SlishowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _colorPrimario = Colors.blue;
  Color _colorSecundario = Colors.grey;

  double _bulletPrimario = 12;
  double _bulletSecundario = 12;

  double get bulletPrimario => this._bulletPrimario;
  set bulletPrimario(double n) {
    this._bulletPrimario = n;
  }

  double get bulletSecundario => this._bulletSecundario;
  set bulletSecundario(double n) {
    this._bulletSecundario = n;
  }

  Color get colorPrimario => this._colorPrimario;
  set colorPrimario(Color color) {
    this._colorPrimario = color;
  }

  Color get colorSecundario => this._colorSecundario;
  set colorSecundario(Color color) {
    this._colorSecundario = color;
  }

  double get currentPage => this._currentPage;
  set currentPage(double pagina) {
    // print('$pagina');
    this._currentPage = pagina;
    notifyListeners();
  }
}

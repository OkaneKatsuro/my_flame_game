import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'klondike_world.dart';

enum Action { newDeal, sameDeal, changeDraw, haveFun } ///список действий

//главные размеры объктов
class KlondikeGame extends FlameGame<KlondikeWorld> {
  static const double cardGap = 175.0;/// отступы от карты
  static const double topGap = 500.0;/// отступ сверху
  static const double cardWidth = 1000.0; /// ширина карты
  static const double cardHeight = 1400.0;/// высота карты
  static const double cardRadius = 100.0; ///радиус углов карты
  static const double cardSpaceWidth = cardWidth + cardGap; ///горизонтальное расстояние между картами
  static const double cardSpaceHeight = cardHeight + cardGap;///вертикальное расстоянине между картами
  static final Vector2 cardSize = Vector2(cardWidth, cardHeight); //размер карты
  static final cardRRect = RRect.fromRectAndRadius( ///создание прямоугольника карты
    const Rect.fromLTWH(0, 0, cardWidth, cardHeight),
    const Radius.circular(cardRadius),
  );

  ///Константа, используемая для определения, когда короткое перетаскивание следует рассматривать как событие "TapUp" (отпускание после касания).
  static const double dragTolerance = cardWidth / 5;

  /// Эта константа используется когда создается рандомный сид
  static const int maxInt = 0xFFFFFFFE; // = (2 to the power 32) - 1

  /// TЭтот конструктор KlondikeGame также инициирует первый KlondikeWorld.
  KlondikeGame() : super(world: KlondikeWorld());

  // Эти три значения сохраняются между играми и являются начальными условиями
  // fдля следующей игры, которая будет проходить в KlondikeWorld. Фактический seed (начальное значение генератора случайных чисел)
  // вычисляется в KlondikeWorld, но сохраняется здесь на случай, если игрок захочет
  // переиграть партию, выбрав действие Action.sameDeal.
  int klondikeDraw = 1;
  int seed = 1;
  Action action = Action.newDeal;
}
//Создание графического представления объектов игры
Sprite klondikeSprite(double x, double y, double width, double height) {
  return Sprite(
    Flame.images.fromCache('klondike-sprites.png'),
    srcPosition: Vector2(x, y),
    srcSize: Vector2(width, height),
  );
}
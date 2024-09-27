import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/controller/controller.dart';
import 'package:moneymonkey/models/cardmodel.dart';
import 'package:moneymonkey/widgets/custom_app_bar.dart';

class BankNotePage extends StatefulWidget {
  @override
  State<BankNotePage> createState() => _BankNotePageState();
}

class _BankNotePageState extends State<BankNotePage> {
    final ProgressController progressController = Get.put(ProgressController());
  late List<CardModel> _cards;
  Offset _cardOffset = Offset.zero;
  double _cardRotation = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    // Initialize the cards
    _cards = getCards();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar:CustomAppBar(progressController: progressController),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: _cards.map((card) {
            int index = _cards.indexOf(card);
            return _buildDraggableCard(card, index);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDraggableCard(CardModel cardModel, int index) {
    bool isTopCard = index == _cards.length - 1;
    double verticalOffset = 20.0 * index; // Vertical offset for stacking
    double scale = 1.0;

    return Transform.translate(
      offset: Offset(0, verticalOffset),
      child: Transform.scale(
        scale: scale,
        child: Draggable(
          feedback: Transform.translate(
            offset: _cardOffset,
            child: Transform.rotate(
              angle: _cardRotation,
              child: _buildFlipCard(cardModel),
            ),
          ),
          childWhenDragging: Container(),
          onDragStarted: () {
            if (!isTopCard) return;
            setState(() {
              _isDragging = true;
            });
          },
          onDragUpdate: (details) {
            if (!isTopCard) return;
            setState(() {
              _cardOffset += details.delta;
              _cardRotation = 0.01 * _cardOffset.dx;
            });
          },
          onDragEnd: (details) {
            if (!isTopCard) return;
            if (_cardOffset.distance > 100) {
              _onCardSwiped();
            } else {
              setState(() {
                _cardOffset = Offset.zero;
                _cardRotation = 0.0;
                _isDragging = false;
              });
            }
          },
          child: _isDragging && isTopCard
              ? Container()
              : Transform.translate(
                  offset: isTopCard ? _cardOffset : Offset.zero,
                  child: Transform.rotate(
                    angle: isTopCard ? _cardRotation : 0.0,
                    child: _buildFlipCard(cardModel),
                  ),
                ),
        ),
      ),
    );
  }

  void _onCardSwiped() {
    setState(() {
      CardModel swipedCard = _cards.removeLast();
      swipedCard.cardKey = GlobalKey<FlipCardState>();
      _cardOffset = Offset.zero;
      _cardRotation = 0.0;
      _isDragging = false;
      _cards.insert(0, swipedCard);
    });
  }

  Widget _buildFlipCard(CardModel cardModel) {
    return FlipCard(
      key: cardModel.cardKey,
      flipOnTouch: true,
      front: _buildCardContent(cardModel),
      back: cardModel.backWidget,
    );
  }

  Widget _buildCardContent(CardModel cardModel) {
    return SizedBox(
      width: 310,
      height: 545,
      child: Container(
        decoration: BoxDecoration(
          color: cardModel.color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            cardModel.frontText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 45,
              fontFamily: 'Baloo 2',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }





}
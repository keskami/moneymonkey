import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Lesson Flow/Models/cardmodel.dart';
import 'package:money_monkey/Lesson Flow/Widgets/custom_app_bar.dart';
import 'package:money_monkey/Lesson Flow/controller/controller.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/questionpage.dart';

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
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _cards = [];
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    String lessonId =
        'lesson${progressController.currentLessonIndex.value + 1}';
    await progressController.fetchFlashcards(lessonId);

    try {
      // Generate CardModels from fetched data
      _cards = progressController.flashcards
          .asMap()
          .entries
          .map((entry) {
            int index = entry.key;
            Map<String, dynamic> flashcard = entry.value;

            // Safely extract 'front' and 'back' text
            String frontText =
                flashcard['front']?.toString() ?? 'No Front Text';
            String backText = flashcard['back']?.toString() ?? 'No Back Text';

            // Assign card color based on index
            Color cardColor;
            switch (index % 3) {
              case 0:
                cardColor = const Color(0xFF89DC8E); // Green
                break;
              case 1:
                cardColor = const Color(0xFF87CEEB); // Blue
                break;
              default:
                cardColor = const Color(0xFFFFE792); // Yellow
            }

            return CardModel(
              frontText: frontText,
              backText: backText,
              color: cardColor,
              cardKey: GlobalKey<FlipCardState>(),
            );
          })
          .toList()
          .reversed
          .toList();
    } catch (e) {
      print('Error while mapping flashcards: $e');
      _cards = [];
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: CustomAppBar(progressController: progressController),
      body: Center(
        child: _cards.isEmpty
            ? const CircularProgressIndicator()
            : Stack(
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
    double verticalOffset = 20.0 * index;

    return Transform.translate(
      offset: Offset(0, verticalOffset),
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

      if (_cards.every((card) => card.isFlipped)) {
        progressController.setCardsCompleted();
        _showButton = true;
      }
    });
  }

  Widget _buildFlipCard(CardModel cardModel) {
    bool isTopCard = cardModel == _cards.last;
    return FlipCard(
      key: cardModel.cardKey,
      flipOnTouch: true,
      front: Stack(
        children: [
          _buildCardContent(cardModel),
          if (_showButton && isTopCard)
            Positioned(
              bottom: 60,
              left: 50,
              right: 50,
              child: GestureDetector(
                onTap: () {
                  progressController.incrementProgress();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionPage(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/button.png',
                  height: 60,
                  width: 200,
                ),
              ),
            ),
        ],
      ),
      back: DetailNote(
        color: cardModel.color,
        title: "",
        details: cardModel.backText,
        imagePath: 'assets/images/monkeywithcap.png',
      ),
      onFlipDone: (bool flipped) {
        if (flipped && !cardModel.isFlipped) {
          setState(() {
            cardModel.isFlipped = true;
          });
        }
      },
    );
  }

  Widget _buildCardContent(CardModel cardModel) {
    return SizedBox(
      width: 350,
      height: 605,
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
              decoration: TextDecoration.none,
              fontFamily: 'Baloo 2',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

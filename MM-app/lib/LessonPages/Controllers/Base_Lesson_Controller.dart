import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/Backend/Services/AcademicServices.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/CelebrationScreen.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentImapctPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentProblemPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentSolutionsPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentTakeawaysPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/DragNDropQuestionPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/GraphicalResultPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ImagesIntroPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/LearningCheckPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/MCQPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/MonkeyLandingPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/MonkeyMCQPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/QuizPages/QuizMCQ.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/QuizPages/QuizMCQImages.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ScenarioPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/TapToExpandPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/TapToRevealIconsPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/TapToRevealPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/TapToRevealPictorialPage.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/page4.dart';

class BaseLessonController extends GetxController {
  /// Indicates whether the controller is still loading data.
  RxBool isLoading = true.obs;
  RxInt pageIndex = 0.obs;

  final DirectFirebaseService localAcademicService = DirectFirebaseService();
  final String componentId;
  final ComponentType type;

  BaseLessonController({required this.componentId, required this.type});

  // overarching dynamic pages list
  List<Widget> pages = [];

  // for Scenario Simulation
  RxInt responsibilityScore = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print("AAAAA" + type.toString());
    loadConceptData();
  }

  Future<void> loadConceptData() async {
    if (type == ComponentType.concept) {
      try {
        List<Widget> scenarioPages = [];
        final Component data =
            await localAcademicService.getComponent(componentId);
        for (var subcomponent in data.questionData) {
          if (subcomponent.type == SubComponentType.scenario) {
            for (int j = 0; j < subcomponent.data.questions.length; j++) {
              MultipleChoice question = subcomponent.data.questions[j];

              scenarioPages.add(
                ScenarioPage(
                  title: subcomponent.data.title,
                  subTitle: subcomponent.data.scenarioExplanation,
                  wrong: question.prompts.incorrect,
                  correct: question.prompts.correct,
                  containerHeading: question.questionHeading,
                  containerSubHeading: question.question,
                  options: question.options,
                  correctAnswer: question.correctAnswers[0],
                  componentId: componentId,
                ),
              );
            }
          }
        }

        pages.add(
          MCQPage(
            correct: data.questionData[0].data.prompts.correct,
            wrong: data.questionData[0].data.prompts.incorrect,
            title: data.questionData[0].data.questionExplanation,
            question: data.questionData[0].data.question,
            options: List<String>.from(
              data.questionData[0].data.options.map((item) => item.toString()),
            ),
            correctAnswer: data.questionData[0].data.correctAnswers[0],
          ),
        );

        pages.add(
          TapToRevealPage(
            before: data.questionData[1].data.tapInstruction ?? '',
            title: data.questionData[1].data.title,
            bigBottom: data.questionData[1].data.definition,
            bigTop: "Definition:",
            little: data.questionData[1].data.whyMatter,
          ),
        );

        pages.add(
          TapToRevealIconsPage(
            title: data.questionData[2].data.title,
            wrongMessage:
                "Please click all the icons before moving on", // Or read from your model
            iconContents: List<String>.from(data.questionData[2].data.contents),
            iconLinks: List<String>.from(data.questionData[2].data.iconLinks),
          ),
        );
        pages.addAll(scenarioPages);
        pages.add(
          LearningCheckPage(
            // All fields below come from data.questionData[4].data
            title: data.questionData[4].data.title,
            question1: data.questionData[4].data.question1,
            question2: data.questionData[4].data.question2,
            correctAns1: data.questionData[4].data.correctAns1,
            correctAns2: data.questionData[4].data.correctAns2,
            options1: List<String>.from(data.questionData[4].data.options1),
            options2: List<String>.from(data.questionData[4].data.options2),
            button: "Check", // or data.questionData[4].data.button if stored
            bothCorrect: "Great job!",
            oneCorrect: "One question is incorrect",
            wrong: "Both questions are incorrect",
          ),
        );
        pages.add(
          ComponentTakeawaysPage(
            title: data.questionData[5].data.title,
            subTitle: "Personal Reflection", // or from data if you prefer
            hint: data.questionData[5].data.hint,
            image:
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Ftakeaway_check.png?alt=media&token=9a389932-5562-4c38-a970-9ecd6bf8adcb",
            takeAways: [
              [
                data.questionData[5].data.takeaways[0].title,
                data.questionData[5].data.takeaways[0].description,
              ],
              [
                data.questionData[5].data.takeaways[1].title,
                data.questionData[5].data.takeaways[1].description,
              ],
              [
                data.questionData[5].data.takeaways[2].title,
                data.questionData[5].data.takeaways[2].description,
              ],
              [
                data.questionData[5].data.takeaways[3].title,
                data.questionData[5].data.takeaways[3].description,
              ],
            ],
          ),
        );
      } catch (e) {
        print("Error loading concept data: $e");
      } finally {
        isLoading.value = false; // using the inherited property
      }
    } else if (type == ComponentType.story) {
      try {
        final Component data =
            await localAcademicService.getComponent(componentId);

        // add pages
        pages.add(
          MonkeyLandingPage(
            introText: data.questionData[0].data.mintyText,
            imageURL: data.questionData[0].data.imageUrl,
            title: data.questionData[0].data.title,
          ),
        );

        // Pass data directly to ComponentProblemPage from data.questionData[3]
        pages.add(
          ComponentProblemPage(
            scenarioText: data.questionData[1].data.scenarioText,
            title: data.questionData[1].data.title,
            subtitle: data.questionData[1].data.subtitle,
            problem: data.questionData[1].data.problem,
            instructions: data.questionData[1].data.instructions,
          ),
        );

        pages.add(
          ComponentSolutionsPage(
            bigTexts: [
              data.questionData[2].data.Card1[0],
              data.questionData[2].data.Card2[0],
              data.questionData[2].data.Card3[0],
            ],
            smallTexts: [
              data.questionData[2].data.Card1[1],
              data.questionData[2].data.Card2[1],
              data.questionData[2].data.Card3[1],
            ],
            title: data.questionData[2].data.title,
            subtitle: data.questionData[2].data.subtitle,
            instructions: [
              "Click for solution 1...",
              "Click for solution 2...",
              "Click for solution 3..."
            ],
            button: "Next",
          ),
        );
        pages.add(
          ComponentImpactPage(
            // Convert 'beforeContent' and 'afterContent' from dynamic objects to Strings
            beforeText: List<String>.from(data
                .questionData[3].data.beforeContent
                .map((item) => item.toString())),
            afterText: List<String>.from(data.questionData[3].data.afterContent
                .map((item) => item.toString())),
            title: data.questionData[3].data.title,
            subtitle: data.questionData[3].data.subtitle,
            instructions: [
              "Click for the before...",
              "Click for the after...",
            ],
            ba: [
              "before",
              "after"
            ], // If you want to keep track of these labels
            button: "next",
          ),
        );
      } catch (e) {
        print("Error fetching story data: $e");
      } finally {
        isLoading.value = false;
      }
    } else if (type == ComponentType.peerReflection) {
      try {
        final Component data =
            await localAcademicService.getComponent(componentId);
        pages.add(
          ImagesIntroPage(
            title: data.questionData[0].data.title,
            subTitle: data.questionData[0].data.subTitle,
            // This assumes 'characters' is a list of 3, each with a 'name' and 'role'
            characters: [
              [
                data.questionData[0].data.characters[0].name,
                data.questionData[0].data.characters[0].role
              ],
              [
                data.questionData[0].data.characters[1].name,
                data.questionData[0].data.characters[1].role
              ],
              [
                data.questionData[0].data.characters[2].name,
                data.questionData[0].data.characters[2].role
              ],
            ],
            button: "Continue to Peer Stories",
          ),
        );
        pages.add(
          TapToExpandPage(
            title: data.questionData[1].data.title,
            characters: [
              [
                '${data.questionData[1].data.characters[0].name}: '
                    '${data.questionData[1].data.characters[0].role}',
                data.questionData[1].data.characters[0].story
              ],
              [
                '${data.questionData[1].data.characters[1].name}: '
                    '${data.questionData[1].data.characters[1].role}',
                data.questionData[1].data.characters[1].story
              ],
              [
                '${data.questionData[1].data.characters[2].name}: '
                    '${data.questionData[1].data.characters[2].role}',
                data.questionData[1].data.characters[2].story
              ],
            ],
            button: "Continue to Activity",
          ),
        );

        pages.add(
          DragNDropQuestionPage(
            question: data.questionData[2].data.title,
            box1: data.questionData[2].data.categories[0].title,
            box2: data.questionData[2].data.categories[1].title,
            box3: data.questionData[2].data.categories[2].title,
            availableItems:
                List<String>.from(data.questionData[2].data.actions),
            correct1: List<String>.from(
              data.questionData[2].data.categories[0].correctActions,
            ),
            correct2: List<String>.from(
              data.questionData[2].data.categories[1].correctActions,
            ),
            correct3: List<String>.from(
              data.questionData[2].data.categories[2].correctActions,
            ),
            correctFeedback:
                data.questionData[2].data.feedbackMessages["correct"],
            incorrectFeedback:
                data.questionData[2].data.feedbackMessages["incorrect"],
            subTitle: "Actions to Categorize:",
          ),
        );

        pages.add(
          Page4(
            title: "Reflection",
            subTitle: data.questionData[3].data.question,
            maria: data.questionData[3].data.options[1].description,
            jason: data.questionData[3].data.options[2].description,
            ava: data.questionData[3].data.options[0].description,
            button: "Submit",
            feedback1: data.questionData[3].data
                .feedbackMessages[data.questionData[3].data.options[0].name],
            feedback2: data.questionData[3].data
                .feedbackMessages[data.questionData[3].data.options[1].name],
            feedback3: data.questionData[3].data
                .feedbackMessages[data.questionData[3].data.options[2].name],
          ),
        );
      } catch (e) {
        print("Error fetching peerReflection data: $e");
      } finally {
        isLoading.value = false;
      }
    } else if (type == ComponentType.quiz) {
      try {
        String question = "";
        List<String> answers = [];
        Map<String, String> feedback = {};
        List<String> correctAnswers = [];
        List<String> answerImages = [];
        bool allowMultipleSelections = false;

        final Component data =
            await localAcademicService.getComponent(componentId);

        for (int i = 0; i < data.questionData.length; i++) {
          if (data.questionData[i].type == SubComponentType.quiztextmcquestion) {
            question = data.questionData[i].data.question;
            answers = data.questionData[i].data.options;
            correctAnswers = data.questionData[i].data.correctAnswers;
            feedback = data.questionData[i].data.feedbackMessages ?? {};
            allowMultipleSelections = data.questionData[i].data.isMultiSelect;
            pages.add(QuizMCQPage(
                question: question,
                answers: answers,
                feedback: feedback,
                correctAnswers: correctAnswers,
                allowMultipleSelections: allowMultipleSelections));
            print("REACHED");
          } else if (data.questionData[i].type == SubComponentType.quizimagemcquestion) {
            try {
              question = data.questionData[i].data.question;
              answers = data.questionData[i]
                  .data
                  .options
                  .map<String>((QuizOption option) => option.text)
                  .toList();

              answerImages = data.questionData[i]
                  .data
                  .options
                  .map<String>((QuizOption option) => option.imageUrl ?? "")
                  .toList();

              correctAnswers = data.questionData[i].data.correctAnswers;
              feedback = data.questionData[i].data.feedbackMessages ?? {};
              allowMultipleSelections = data.questionData[i].data.isMultiSelect;

              pages.add(QuizMCQImagesPage(
                  question: question,
                  answers: answers,
                  answerImages: answerImages,
                  feedback: feedback,
                  correctAnswers: correctAnswers,
                  allowMultipleSelections: allowMultipleSelections));
            } catch (e) {
              print("ERROR in image MCQ processing: $e");
            }
          }
        }
      } catch (e) {
        print("Error fetching quiz data: $e");
      } finally {
        isLoading.value = false;
      }
    }

    pages.add(CelebrationScreen());
  }
}

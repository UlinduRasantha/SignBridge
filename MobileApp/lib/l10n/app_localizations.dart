import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_si.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('si')
  ];

  /// No description provided for @locale.
  ///
  /// In en, this message translates to:
  /// **'en'**
  String get locale;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @suggested.
  ///
  /// In en, this message translates to:
  /// **'Suggested'**
  String get suggested;

  /// No description provided for @allLanguages.
  ///
  /// In en, this message translates to:
  /// **'All Languages'**
  String get allLanguages;

  /// No description provided for @sinhala.
  ///
  /// In en, this message translates to:
  /// **'Sinhala'**
  String get sinhala;

  /// No description provided for @englishUs.
  ///
  /// In en, this message translates to:
  /// **'English (United States)'**
  String get englishUs;

  /// No description provided for @signBridge.
  ///
  /// In en, this message translates to:
  /// **'Sign Bridge'**
  String get signBridge;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @welcomeToSignBridge.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Sign Bridge'**
  String get welcomeToSignBridge;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get loginWithGoogle;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @userGuide.
  ///
  /// In en, this message translates to:
  /// **'User Guide'**
  String get userGuide;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exitApp;

  /// No description provided for @areYouSureYouWantToExit.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit?'**
  String get areYouSureYouWantToExit;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @signToTextTranslate.
  ///
  /// In en, this message translates to:
  /// **'Sign to Text Translate'**
  String get signToTextTranslate;

  /// No description provided for @startTranslation.
  ///
  /// In en, this message translates to:
  /// **'Start Translation'**
  String get startTranslation;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @theSignWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'The sign will appear here'**
  String get theSignWillAppearHere;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @processingGesture.
  ///
  /// In en, this message translates to:
  /// **'Processing gesture...'**
  String get processingGesture;

  /// No description provided for @detectingSign.
  ///
  /// In en, this message translates to:
  /// **'Detecting sign...'**
  String get detectingSign;

  /// No description provided for @noGestureDetected.
  ///
  /// In en, this message translates to:
  /// **'No gesture detected'**
  String get noGestureDetected;

  /// No description provided for @pleaseKeepYourHandsVisible.
  ///
  /// In en, this message translates to:
  /// **'Please keep your hands visible'**
  String get pleaseKeepYourHandsVisible;

  /// No description provided for @gestureDetectedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Gesture detected successfully'**
  String get gestureDetectedSuccessfully;

  /// No description provided for @translatingToText.
  ///
  /// In en, this message translates to:
  /// **'Translating to text...'**
  String get translatingToText;

  /// No description provided for @translationComplete.
  ///
  /// In en, this message translates to:
  /// **'Translation complete'**
  String get translationComplete;

  /// No description provided for @textToSignTranslate.
  ///
  /// In en, this message translates to:
  /// **'Text to Sign Translate'**
  String get textToSignTranslate;

  /// No description provided for @enterYourText.
  ///
  /// In en, this message translates to:
  /// **'Enter your text'**
  String get enterYourText;

  /// No description provided for @playGesture.
  ///
  /// In en, this message translates to:
  /// **'Play Gesture'**
  String get playGesture;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @avatarIsSigning.
  ///
  /// In en, this message translates to:
  /// **'Avatar is signing...'**
  String get avatarIsSigning;

  /// No description provided for @displaySign.
  ///
  /// In en, this message translates to:
  /// **'Display Sign'**
  String get displaySign;

  /// No description provided for @howToUseTheSignBridgeApp.
  ///
  /// In en, this message translates to:
  /// **'How to use the Sign Bridge app'**
  String get howToUseTheSignBridgeApp;

  /// No description provided for @step1OpenTheAppAndSignIn.
  ///
  /// In en, this message translates to:
  /// **'Step 1: Open the app and sign in with Google or Email.'**
  String get step1OpenTheAppAndSignIn;

  /// No description provided for @step2SelectSignToTextMode.
  ///
  /// In en, this message translates to:
  /// **'Step 2: Select \'Sign to Text\' mode from the home screen.'**
  String get step2SelectSignToTextMode;

  /// No description provided for @step3PositionYourHandsClearly.
  ///
  /// In en, this message translates to:
  /// **'Step 3: Position your hands clearly in front of the camera.'**
  String get step3PositionYourHandsClearly;

  /// No description provided for @step4TapStartTranslation.
  ///
  /// In en, this message translates to:
  /// **'Step 4: Tap \'Start Translation\' button to begin detection.'**
  String get step4TapStartTranslation;

  /// No description provided for @step5TheDetectedSignWillConvert.
  ///
  /// In en, this message translates to:
  /// **'Step 5: The detected sign will automatically convert to text.'**
  String get step5TheDetectedSignWillConvert;

  /// No description provided for @step6YouCanDownloadOrShare.
  ///
  /// In en, this message translates to:
  /// **'Step 6: You can download or share the translated text.'**
  String get step6YouCanDownloadOrShare;

  /// No description provided for @howToUseTextToSignMode.
  ///
  /// In en, this message translates to:
  /// **'How to use Text to Sign mode'**
  String get howToUseTextToSignMode;

  /// No description provided for @enterTheTextInTheInputBox.
  ///
  /// In en, this message translates to:
  /// **'Enter the text in the input box and tap the \'Play Gesture\' button.'**
  String get enterTheTextInTheInputBox;

  /// No description provided for @theAvatarWillShowTheSign.
  ///
  /// In en, this message translates to:
  /// **'The avatar will show the sign language animatedly.'**
  String get theAvatarWillShowTheSign;

  /// No description provided for @settingsAndCustomization.
  ///
  /// In en, this message translates to:
  /// **'Settings and Customization'**
  String get settingsAndCustomization;

  /// No description provided for @changeLanguageBetweenEnglishAndSinhalaSetting.
  ///
  /// In en, this message translates to:
  /// **'You can switch between English and Sinhala languages at any time.'**
  String get changeLanguageBetweenEnglishAndSinhalaSetting;

  /// No description provided for @enableDarkModeForBetterVisibility.
  ///
  /// In en, this message translates to:
  /// **'Enable dark mode for better visibility at night.'**
  String get enableDarkModeForBetterVisibility;

  /// No description provided for @useTheHelpSectionForSupport.
  ///
  /// In en, this message translates to:
  /// **'Use the Help section for troubleshooting and support.'**
  String get useTheHelpSectionForSupport;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get pleaseWait;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @connectingToServer.
  ///
  /// In en, this message translates to:
  /// **'Connecting to server...'**
  String get connectingToServer;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetConnection;

  /// No description provided for @pleaseCheckYourNetworkConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your network connection'**
  String get pleaseCheckYourNetworkConnection;

  /// No description provided for @cameraPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera permission denied'**
  String get cameraPermissionDenied;

  /// No description provided for @pleaseAllowCameraAccessInSettings.
  ///
  /// In en, this message translates to:
  /// **'Please allow camera access in settings'**
  String get pleaseAllowCameraAccessInSettings;

  /// No description provided for @microphonePermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission required'**
  String get microphonePermissionRequired;

  /// No description provided for @failedToLoadData.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Data'**
  String get failedToLoadData;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @updateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update available'**
  String get updateAvailable;

  /// No description provided for @appUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'App updated successfully'**
  String get appUpdatedSuccessfully;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccessful;

  /// No description provided for @invalidEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalidEmailOrPassword;

  /// No description provided for @pleaseFillAllRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get pleaseFillAllRequiredFields;

  /// No description provided for @passwordMustBeAtLeast8Characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMustBeAtLeast8Characters;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account Created Successfully'**
  String get accountCreatedSuccessfully;

  /// No description provided for @loggingOut.
  ///
  /// In en, this message translates to:
  /// **'Logging out...'**
  String get loggingOut;

  /// No description provided for @areYouSureYouWantToLogOut.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get areYouSureYouWantToLogOut;

  /// No description provided for @gestureDetectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Gesture detection failed'**
  String get gestureDetectionFailed;

  /// No description provided for @modelNotLoadedProperly.
  ///
  /// In en, this message translates to:
  /// **'Model not loaded properly'**
  String get modelNotLoadedProperly;

  /// No description provided for @restartTheAppAndTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Restart the app and try again'**
  String get restartTheAppAndTryAgain;

  /// No description provided for @fileSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'File saved successfully'**
  String get fileSavedSuccessfully;

  /// No description provided for @fileNotFound.
  ///
  /// In en, this message translates to:
  /// **'File not found'**
  String get fileNotFound;

  /// No description provided for @doYouWantToDeleteThisFile.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this file?'**
  String get doYouWantToDeleteThisFile;

  /// No description provided for @fileDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'File deleted successfully'**
  String get fileDeletedSuccessfully;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @detectingHands.
  ///
  /// In en, this message translates to:
  /// **'Detecting hands...'**
  String get detectingHands;

  /// No description provided for @analyzingGesture.
  ///
  /// In en, this message translates to:
  /// **'Analyzing gesture...'**
  String get analyzingGesture;

  /// No description provided for @processingVideoFrames.
  ///
  /// In en, this message translates to:
  /// **'Processing video frames'**
  String get processingVideoFrames;

  /// No description provided for @gestureRecognizedAs.
  ///
  /// In en, this message translates to:
  /// **'Gesture recognized as:'**
  String get gestureRecognizedAs;

  /// No description provided for @noGestureDetectedFull.
  ///
  /// In en, this message translates to:
  /// **'No gesture detected'**
  String get noGestureDetectedFull;

  /// No description provided for @moveYourHandsIntoTheFrame.
  ///
  /// In en, this message translates to:
  /// **'Move your hands into the frame'**
  String get moveYourHandsIntoTheFrame;

  /// No description provided for @holdTheGestureSteady.
  ///
  /// In en, this message translates to:
  /// **'Hold the gesture steady'**
  String get holdTheGestureSteady;

  /// No description provided for @capturingGestureData.
  ///
  /// In en, this message translates to:
  /// **'Capturing gesture data'**
  String get capturingGestureData;

  /// No description provided for @pleaseWaitWhileWeRecognizeYourSign.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we recognize your sign'**
  String get pleaseWaitWhileWeRecognizeYourSign;

  /// No description provided for @sessionExpiredPleaseLogInAgain.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please log in again.'**
  String get sessionExpiredPleaseLogInAgain;

  /// No description provided for @gestureTranslationCompleted.
  ///
  /// In en, this message translates to:
  /// **'Gesture translation completed'**
  String get gestureTranslationCompleted;

  /// No description provided for @prediction.
  ///
  /// In en, this message translates to:
  /// **'Prediction:'**
  String get prediction;

  /// No description provided for @confidenceLevel.
  ///
  /// In en, this message translates to:
  /// **'Confidence Level'**
  String get confidenceLevel;

  /// No description provided for @recordingGestureSample.
  ///
  /// In en, this message translates to:
  /// **'Recording gesture sample...'**
  String get recordingGestureSample;

  /// No description provided for @savedSampleSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Saved sample successfully'**
  String get savedSampleSuccessfully;

  /// No description provided for @collectingDataset.
  ///
  /// In en, this message translates to:
  /// **'Collecting dataset'**
  String get collectingDataset;

  /// No description provided for @sequenceCompleted.
  ///
  /// In en, this message translates to:
  /// **'Sequence completed'**
  String get sequenceCompleted;

  /// No description provided for @modelLoading.
  ///
  /// In en, this message translates to:
  /// **'Model loading...'**
  String get modelLoading;

  /// No description provided for @modelLoadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Model loaded successfully'**
  String get modelLoadedSuccessfully;

  /// No description provided for @preparingCamera.
  ///
  /// In en, this message translates to:
  /// **'Preparing camera...'**
  String get preparingCamera;

  /// No description provided for @gestureTranslationStarted.
  ///
  /// In en, this message translates to:
  /// **'Gesture translation started'**
  String get gestureTranslationStarted;

  /// No description provided for @gestureTranslationStopped.
  ///
  /// In en, this message translates to:
  /// **'Gesture translation stopped'**
  String get gestureTranslationStopped;

  /// No description provided for @detectedWord.
  ///
  /// In en, this message translates to:
  /// **'Detected word:'**
  String get detectedWord;

  /// No description provided for @unknownSign.
  ///
  /// In en, this message translates to:
  /// **'Unknown sign'**
  String get unknownSign;

  /// No description provided for @pleasePerformTheSignAgain.
  ///
  /// In en, this message translates to:
  /// **'Please perform the sign again'**
  String get pleasePerformTheSignAgain;

  /// No description provided for @leftHandDetected.
  ///
  /// In en, this message translates to:
  /// **'Left hand detected'**
  String get leftHandDetected;

  /// No description provided for @rightHandDetected.
  ///
  /// In en, this message translates to:
  /// **'Right hand detected'**
  String get rightHandDetected;

  /// No description provided for @bothHandsDetected.
  ///
  /// In en, this message translates to:
  /// **'Both hands detected'**
  String get bothHandsDetected;

  /// No description provided for @noHandsDetected.
  ///
  /// In en, this message translates to:
  /// **'No hands detected'**
  String get noHandsDetected;

  /// No description provided for @trackingMovement.
  ///
  /// In en, this message translates to:
  /// **'Tracking movement'**
  String get trackingMovement;

  /// No description provided for @gestureNotClear.
  ///
  /// In en, this message translates to:
  /// **'Gesture not clear'**
  String get gestureNotClear;

  /// No description provided for @tryWithBetterLighting.
  ///
  /// In en, this message translates to:
  /// **'Try with better lighting'**
  String get tryWithBetterLighting;

  /// No description provided for @gestureTooFastPleaseSlowDown.
  ///
  /// In en, this message translates to:
  /// **'Gesture too fast, please slow down'**
  String get gestureTooFastPleaseSlowDown;

  /// No description provided for @gestureTooFarFromCamera.
  ///
  /// In en, this message translates to:
  /// **'Gesture too far from camera'**
  String get gestureTooFarFromCamera;

  /// No description provided for @gestureTooCloseToCamera.
  ///
  /// In en, this message translates to:
  /// **'Gesture too close to camera'**
  String get gestureTooCloseToCamera;

  /// No description provided for @adjustYourPosition.
  ///
  /// In en, this message translates to:
  /// **'Adjust your position'**
  String get adjustYourPosition;

  /// No description provided for @lightingConditionsNotSuitable.
  ///
  /// In en, this message translates to:
  /// **'Lighting conditions not suitable'**
  String get lightingConditionsNotSuitable;

  /// No description provided for @calibratingGestureDetection.
  ///
  /// In en, this message translates to:
  /// **'Calibrating gesture detection'**
  String get calibratingGestureDetection;

  /// No description provided for @gestureCaptured.
  ///
  /// In en, this message translates to:
  /// **'Gesture captured'**
  String get gestureCaptured;

  /// No description provided for @gestureNotRecognized.
  ///
  /// In en, this message translates to:
  /// **'Gesture not recognized'**
  String get gestureNotRecognized;

  /// No description provided for @pleaseStayStillWhileDetecting.
  ///
  /// In en, this message translates to:
  /// **'Please stay still while detecting'**
  String get pleaseStayStillWhileDetecting;

  /// No description provided for @startingRealTimeRecognition.
  ///
  /// In en, this message translates to:
  /// **'Starting real-time recognition'**
  String get startingRealTimeRecognition;

  /// No description provided for @realTimeTranslationActive.
  ///
  /// In en, this message translates to:
  /// **'Real-time translation active'**
  String get realTimeTranslationActive;

  /// No description provided for @signBridgeAIModelActive.
  ///
  /// In en, this message translates to:
  /// **'Sign Bridge AI Model Active'**
  String get signBridgeAIModelActive;

  /// No description provided for @endOfSession.
  ///
  /// In en, this message translates to:
  /// **'End of session'**
  String get endOfSession;

  /// No description provided for @reCalibratingCamera.
  ///
  /// In en, this message translates to:
  /// **'Re-calibrating camera'**
  String get reCalibratingCamera;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPasswordInput.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordInput;

  /// No description provided for @forgotPasswordQuestion.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordQuestion;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterYourEmail;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @invalidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalidEmailAddress;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get invalidPassword;

  /// No description provided for @pleaseEnterAValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterAValidEmail;

  /// No description provided for @pleaseWaitAMoment.
  ///
  /// In en, this message translates to:
  /// **'Please wait a moment'**
  String get pleaseWaitAMoment;

  /// No description provided for @loadingDots.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loadingDots;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @confirmDialog.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmDialog;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @continueForward.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueForward;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select File'**
  String get selectFile;

  /// No description provided for @chooseImage.
  ///
  /// In en, this message translates to:
  /// **'Choose Image'**
  String get chooseImage;

  /// No description provided for @capturePhoto.
  ///
  /// In en, this message translates to:
  /// **'Capture Photo'**
  String get capturePhoto;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @resultNotFound.
  ///
  /// In en, this message translates to:
  /// **'Result Not Found'**
  String get resultNotFound;

  /// No description provided for @pleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Please try again later'**
  String get pleaseTryAgainLater;

  /// No description provided for @pleaseCheckYourConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your connection'**
  String get pleaseCheckYourConnection;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection Error'**
  String get connectionError;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign In with Google'**
  String get signInWithGoogle;

  /// No description provided for @signInWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Sign In with Facebook'**
  String get signInWithFacebook;

  /// No description provided for @signInWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Sign In with Email'**
  String get signInWithEmail;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Continue with Email'**
  String get continueWithEmail;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an Account'**
  String get createAnAccount;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @forgotUsername.
  ///
  /// In en, this message translates to:
  /// **'Forgot Username?'**
  String get forgotUsername;

  /// No description provided for @changeLanguageSetting.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguageSetting;

  /// No description provided for @selectLanguageSetting.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguageSetting;

  /// No description provided for @englishLang.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLang;

  /// No description provided for @sinhalaLangFull.
  ///
  /// In en, this message translates to:
  /// **'Sinhala'**
  String get sinhalaLangFull;

  /// No description provided for @tamilLang.
  ///
  /// In en, this message translates to:
  /// **'Tamil'**
  String get tamilLang;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @disableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Disable Notifications'**
  String get disableNotifications;

  /// No description provided for @aboutFull.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutFull;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @updatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Updated Successfully'**
  String get updatedSuccessfully;

  /// No description provided for @successfullySubmitted.
  ///
  /// In en, this message translates to:
  /// **'Successfully Submitted'**
  String get successfullySubmitted;

  /// No description provided for @pleaseFillAllRequiredFieldsFull.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get pleaseFillAllRequiredFieldsFull;

  /// No description provided for @requiredFieldText.
  ///
  /// In en, this message translates to:
  /// **'Required Field'**
  String get requiredFieldText;

  /// No description provided for @invalidInputText.
  ///
  /// In en, this message translates to:
  /// **'Invalid Input'**
  String get invalidInputText;

  /// No description provided for @fieldCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Field cannot be empty'**
  String get fieldCannotBeEmpty;

  /// No description provided for @tapToContinue.
  ///
  /// In en, this message translates to:
  /// **'Tap to continue'**
  String get tapToContinue;

  /// No description provided for @swipeToLearnMore.
  ///
  /// In en, this message translates to:
  /// **'Swipe to learn more'**
  String get swipeToLearnMore;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @loadingData.
  ///
  /// In en, this message translates to:
  /// **'Loading Data'**
  String get loadingData;

  /// No description provided for @dataLoadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Data Loaded Successfully'**
  String get dataLoadedSuccessfully;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Data Available'**
  String get noDataAvailable;

  /// No description provided for @fetchingData.
  ///
  /// In en, this message translates to:
  /// **'Fetching Data'**
  String get fetchingData;

  /// No description provided for @updating.
  ///
  /// In en, this message translates to:
  /// **'Updating...'**
  String get updating;

  /// No description provided for @processingCurrent.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processingCurrent;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploading;

  /// No description provided for @downloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading...'**
  String get downloading;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// No description provided for @receiving.
  ///
  /// In en, this message translates to:
  /// **'Receiving...'**
  String get receiving;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @operationFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation Failed'**
  String get operationFailed;

  /// No description provided for @pleaseCheckYourInput.
  ///
  /// In en, this message translates to:
  /// **'Please check your input'**
  String get pleaseCheckYourInput;

  /// No description provided for @invalidUsernameOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid username or password'**
  String get invalidUsernameOrPassword;

  /// No description provided for @accountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account Deleted'**
  String get accountDeleted;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @chooseCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose Category'**
  String get chooseCategory;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @record.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get record;

  /// No description provided for @recording.
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get recording;

  /// No description provided for @recordedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Recorded Successfully'**
  String get recordedSuccessfully;

  /// No description provided for @deleteRecord.
  ///
  /// In en, this message translates to:
  /// **'Delete Record'**
  String get deleteRecord;

  /// No description provided for @viewHistory.
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get viewHistory;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @lastWeek.
  ///
  /// In en, this message translates to:
  /// **'Last Week'**
  String get lastWeek;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @lastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last Month'**
  String get lastMonth;

  /// No description provided for @thisYear.
  ///
  /// In en, this message translates to:
  /// **'This Year'**
  String get thisYear;

  /// No description provided for @lastYear.
  ///
  /// In en, this message translates to:
  /// **'Last Year'**
  String get lastYear;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @completedTasks.
  ///
  /// In en, this message translates to:
  /// **'Completed Tasks'**
  String get completedTasks;

  /// No description provided for @pendingTasks.
  ///
  /// In en, this message translates to:
  /// **'Pending Tasks'**
  String get pendingTasks;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @successNoun.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get successNoun;

  /// No description provided for @failure.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get failure;

  /// No description provided for @errorNoun.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorNoun;

  /// No description provided for @warningNoun.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warningNoun;

  /// No description provided for @informationNoun.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get informationNoun;

  /// No description provided for @messageNoun.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageNoun;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @newNotification.
  ///
  /// In en, this message translates to:
  /// **'New Notification'**
  String get newNotification;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @markAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as Read'**
  String get markAsRead;

  /// No description provided for @markAsUnread.
  ///
  /// In en, this message translates to:
  /// **'Mark as Unread'**
  String get markAsUnread;

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get viewMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLess;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get showMore;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @logoutVerb.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutVerb;

  /// No description provided for @loginVerb.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginVerb;

  /// No description provided for @signInVerb.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInVerb;

  /// No description provided for @signOutVerb.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOutVerb;

  /// No description provided for @registerVerb.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerVerb;

  /// No description provided for @signUpVerb.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpVerb;

  /// No description provided for @nextAdj.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextAdj;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @backVerb.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backVerb;

  /// No description provided for @forward.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get forward;

  /// No description provided for @goHome.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get goHome;

  /// No description provided for @returnVerd.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get returnVerd;

  /// No description provided for @saveChangesVerb.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChangesVerb;

  /// No description provided for @discardChanges.
  ///
  /// In en, this message translates to:
  /// **'Discard Changes'**
  String get discardChanges;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @deleteVerb.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteVerb;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @updateVerb.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateVerb;

  /// No description provided for @confirmVerb.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmVerb;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @submitVerb.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitVerb;

  /// No description provided for @retryVerb.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryVerb;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPassword;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @passwordUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password Updated Successfully'**
  String get passwordUpdatedSuccessfully;

  /// No description provided for @profileNoun.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileNoun;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get viewProfile;

  /// No description provided for @editProfileVerb.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileVerb;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @changeLanguageAction.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguageAction;

  /// No description provided for @selectLanguageAction.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguageAction;

  /// No description provided for @englishLangName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLangName;

  /// No description provided for @sinhalaLangName.
  ///
  /// In en, this message translates to:
  /// **'Sinhala'**
  String get sinhalaLangName;

  /// No description provided for @tamilLangName.
  ///
  /// In en, this message translates to:
  /// **'Tamil'**
  String get tamilLangName;

  /// No description provided for @lightModeFull.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightModeFull;

  /// No description provided for @themeSetting.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeSetting;

  /// No description provided for @settingsGeneral.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsGeneral;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @systemSettings.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get systemSettings;

  /// No description provided for @aboutGeneral.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutGeneral;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @contactUsGeneral.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUsGeneral;

  /// No description provided for @sendMessageAction.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessageAction;

  /// No description provided for @messageSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Message Sent Successfully'**
  String get messageSentSuccessfully;

  /// No description provided for @messageFailed.
  ///
  /// In en, this message translates to:
  /// **'Message Failed'**
  String get messageFailed;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank You'**
  String get thankYou;

  /// No description provided for @thankYouForUsingOurApp.
  ///
  /// In en, this message translates to:
  /// **'Thank You for Using Our App'**
  String get thankYouForUsingOurApp;

  /// No description provided for @pleaseWaitFull.
  ///
  /// In en, this message translates to:
  /// **'Please Wait'**
  String get pleaseWaitFull;

  /// No description provided for @loadingDataFull.
  ///
  /// In en, this message translates to:
  /// **'Loading Data'**
  String get loadingDataFull;

  /// No description provided for @fetchingInformation.
  ///
  /// In en, this message translates to:
  /// **'Fetching Information'**
  String get fetchingInformation;

  /// No description provided for @processingRequest.
  ///
  /// In en, this message translates to:
  /// **'Processing Request'**
  String get processingRequest;

  /// No description provided for @noDataAvailableFull.
  ///
  /// In en, this message translates to:
  /// **'No Data Available'**
  String get noDataAvailableFull;

  /// No description provided for @noInternetConnectionFull.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetConnectionFull;

  /// No description provided for @tryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Try Again Later'**
  String get tryAgainLater;

  /// No description provided for @connectionErrorFull.
  ///
  /// In en, this message translates to:
  /// **'Connection Error'**
  String get connectionErrorFull;

  /// No description provided for @networkTimeout.
  ///
  /// In en, this message translates to:
  /// **'Network Timeout'**
  String get networkTimeout;

  /// No description provided for @dataSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Data Saved Successfully'**
  String get dataSavedSuccessfully;

  /// No description provided for @dataDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Data Deleted Successfully'**
  String get dataDeletedSuccessfully;

  /// No description provided for @invalidInput.
  ///
  /// In en, this message translates to:
  /// **'Invalid Input'**
  String get invalidInput;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required Field'**
  String get requiredField;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please Fill All Fields'**
  String get pleaseFillAllFields;

  /// No description provided for @pleaseEnterValidInformation.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Information'**
  String get pleaseEnterValidInformation;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session Expired'**
  String get sessionExpired;

  /// No description provided for @unauthorizedAccess.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized Access'**
  String get unauthorizedAccess;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission Denied'**
  String get permissionDenied;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown Error'**
  String get unknownError;

  /// No description provided for @operationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Operation Successful'**
  String get operationSuccessful;

  /// No description provided for @operationFailedFull.
  ///
  /// In en, this message translates to:
  /// **'Operation Failed'**
  String get operationFailedFull;

  /// No description provided for @areYouSureFull.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSureFull;

  /// No description provided for @doYouWantToContinue.
  ///
  /// In en, this message translates to:
  /// **'Do you want to continue?'**
  String get doYouWantToContinue;

  /// No description provided for @confirmAction.
  ///
  /// In en, this message translates to:
  /// **'Confirm Action'**
  String get confirmAction;

  /// No description provided for @yesAffirmative.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesAffirmative;

  /// No description provided for @noNegative.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noNegative;

  /// No description provided for @okAffirmative.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okAffirmative;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @welcomeBackMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBackMessage;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @goodNight.
  ///
  /// In en, this message translates to:
  /// **'Good Night'**
  String get goodNight;

  /// No description provided for @seeYouSoon.
  ///
  /// In en, this message translates to:
  /// **'See You Soon'**
  String get seeYouSoon;

  /// No description provided for @goodbye.
  ///
  /// In en, this message translates to:
  /// **'Goodbye'**
  String get goodbye;

  /// No description provided for @exitAppAction.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exitAppAction;

  /// No description provided for @rateUs.
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateUs;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @submitFeedback.
  ///
  /// In en, this message translates to:
  /// **'Submit Feedback'**
  String get submitFeedback;

  /// No description provided for @thankYouForYourFeedback.
  ///
  /// In en, this message translates to:
  /// **'Thank You for Your Feedback'**
  String get thankYouForYourFeedback;

  /// No description provided for @termsAndConditionsPolicy.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditionsPolicy;

  /// No description provided for @privacyPolicyFull.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyFull;

  /// No description provided for @acceptPolicy.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptPolicy;

  /// No description provided for @declinePolicy.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get declinePolicy;

  /// No description provided for @pleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get pleaseTryAgain;

  /// No description provided for @confirmPasswordFull.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordFull;

  /// No description provided for @resetVerb.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetVerb;

  /// No description provided for @continueVerb.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueVerb;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'si'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'si': return AppLocalizationsSi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

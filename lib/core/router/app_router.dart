import 'package:go_router/go_router.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/auth/sign_in_screen.dart';
import '../../screens/auth/sign_up_screen.dart';
import '../../screens/auth/forgot_password_screen.dart';
import '../../screens/auth/otp_verification_screen.dart';
import '../../screens/main/main_screen.dart';
import '../../screens/details/details_screen.dart';
import '../../screens/map/map_view_screen.dart';
import '../../models/destination.dart';
import '../../screens/message/chat_details_screen.dart';
import '../../screens/message/message_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/otp-verification',
      builder: (context, state) => const OtpVerificationScreen(),
    ),
    GoRoute(path: '/main', builder: (context, state) => const MainScreen()),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final destination = state.extra as Destination;
        return DetailsScreen(destination: destination);
      },
    ),
    GoRoute(path: '/map', builder: (context, state) => const MapViewScreen()),
    GoRoute(
      path: '/chat',
      builder: (context, state) {
        final contact = state.extra as MockMessage;
        return ChatDetailsScreen(contact: contact);
      },
    ),
  ],
);

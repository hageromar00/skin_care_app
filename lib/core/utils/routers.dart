
import 'package:go_router/go_router.dart';
import 'package:skin_care_app/presentation/auth/view/create_account.dart';
import 'package:skin_care_app/presentation/on_boarding/view/on_boarding.dart';
import 'package:skin_care_app/presentation/review_profile/view/review_profile.dart';
import 'package:skin_care_app/presentation/select_skin/view/skin_conkern_body.dart';
import 'package:skin_care_app/presentation/skin_quiz/view/quis_skin_body.dart';
import 'package:skin_care_app/presentation/skin_type/view/skin_type_body.dart';
import 'package:skin_care_app/presentation/tell_yourself/view/tell_yourself.dart';

class AppRouter {
  static const kaccount = '/masbaha';
  static const kstart = '/star';
  static const kabout = '/about';
  static const kskincorn = '/skincorn';
  static const kskintype = '/skintype';
  static const kquiz = '/quiz';
  static const kreviewprofile = '/reviewprofile';



  static final GoRouter router = GoRouter(
    initialLocation: kstart,
    routes: [
      GoRoute(path: kstart, builder: (context, state) => const OnboardingScreen()),
      GoRoute(
        path: kaccount,
        builder: (context, state) => const CreateAccountScreen(),
      ),
       GoRoute(
        path: kabout,
        builder: (context, state) => const AboutYourselfScreen(),
      ),
       GoRoute(
        path: kskincorn,
        builder: (context, state) => const SkinConcernsScreen(),
      ),
       GoRoute(
        path: kskintype,
        builder: (context, state) => const  SkinTypeScreen(),
      ),
       GoRoute(
        path: kquiz,
        builder: (context, state) => const   SkinQuizScreen(),
      ),
       GoRoute(
        path: kreviewprofile,
        builder: (context, state) => const  ReviewProfileScreen(),
      ),

    ],
  );
}

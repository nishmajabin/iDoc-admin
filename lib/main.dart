import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idoc_admin_side/data/repositories/application_repository.dart';
import 'package:idoc_admin_side/data/repositories/dashboard_repository.dart';
import 'package:idoc_admin_side/data/repositories/fee_slab_repository.dart';
import 'package:idoc_admin_side/data/repositories/user_repository.dart';
import 'package:idoc_admin_side/firebase_options.dart';
import 'package:idoc_admin_side/logic/blocs/applications/application_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/auth/auth_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/dashboard/dashboard_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/category/category_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/log_out/logout_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/nav_hover/nav_hover_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/splash/splash_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/splash/splash_event.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_bloc.dart';
import 'package:idoc_admin_side/presentation/screens/splash/splash_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(IdocAdmin());
}

class IdocAdmin extends StatelessWidget {
  const IdocAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashBloc()..add(StartSplash())),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => LogoutBloc()),
        BlocProvider(create: (context) => BottomNavBloc()),
        BlocProvider(create: (context) => DashboardBloc(repository: DashboardRepository())),
        BlocProvider(create: (context) => NavHoverBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => ApplicationBloc(repository: ApplicationRepository())),
        BlocProvider(create: (context) => FeeSlabBloc(repository: FeeSlabRepository())), 
        BlocProvider(create: (context) => FeeSlabDialogBloc()),
        BlocProvider(create: (context) => UserBloc(repository: UserRepository())),

      ],
      child: MaterialApp(
        title: 'iDoc Admin',
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.libreFranklin().fontFamily,
          primaryColor: const Color(0xFF4FC3F7),
          scaffoldBackgroundColor: const Color(0xFFE6EFF9),
          useMaterial3: true,
        ),
        builder: (context, child) {
          if (kIsWeb) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0),
              ),
              child: child!,
            );
          }
          return child!;
        },
      ),
    );
  }
}

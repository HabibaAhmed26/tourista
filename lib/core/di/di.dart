import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourista/core/network/fireauth/fire_auth.dart';
import 'package:tourista/core/network/firestore/firestore.dart';
import 'package:tourista/core/network/img%20service/img_service.dart';
import 'package:tourista/core/storage/shared%20prefrences/shared_pref.dart';
import 'package:tourista/firebase_options.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';
import 'package:tourista/presentation/features/map/cubit/location_cubit.dart';
import 'package:tourista/presentation/features/profile/cubit/profile_cubit.dart';

final GetIt sl = GetIt.instance;
Future<void> setupLocator() async {
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final sharedPreferences = await SharedPreferences.getInstance();

  // Register Firebase raw instances
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);

  await sl<GoogleSignIn>().initialize(
    serverClientId:
        "709513673291-39n4e3lq0klkrqnhnj0rlr0kdrahi4us.apps.googleusercontent.com",
  );
  // FireBase services
  sl.registerLazySingleton<FireStore>(
    () => FireStore(firestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<FireAuth>(
    () => FireAuth(
      firebaseAuth: sl<FirebaseAuth>(),
      googleSignIn: sl<GoogleSignIn>(),
    ),
  );
  //other services
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<PrefManager>(
    () => PrefManager(prefs: sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<ImgHosting>(
    () => ImgHosting(firestore: sl<FireStore>()),
  );
  //Features
  sl.registerLazySingleton<AuthenticationCubit>(
    () => AuthenticationCubit(auth: sl<FireAuth>(), firestore: sl<FireStore>()),
  );
  sl.registerLazySingleton<ProfileCubit>(
    () => ProfileCubit(
      authCubit: sl<AuthenticationCubit>(),
      hosting: sl<ImgHosting>(),
    ),
  );
  sl.registerLazySingleton<LocationCubit>(() => LocationCubit());
}

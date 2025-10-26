import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:tourista/core/network/fireauth/fire_auth.dart';
import 'package:tourista/core/network/firestore/firestore.dart';
import 'package:tourista/firebase_options.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';

final GetIt sl = GetIt.instance;
Future<void> setupLocator() async {
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register Firebase raw instances
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  // FireBase services
  sl.registerLazySingleton<FireStore>(
    () => FireStore(firestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<FireAuth>(
    () =>
        FireAuth(firebaseAuth: sl<FirebaseAuth>(), firestore: sl<FireStore>()),
  );

  //Features
  sl.registerLazySingleton<AuthenticationCubit>(
    () => AuthenticationCubit(auth: sl<FireAuth>(), firestore: sl<FireStore>()),
  );
}

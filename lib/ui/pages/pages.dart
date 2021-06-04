// import 'dart:html';
import 'dart:async';
import 'dart:io';
import 'dart:math' as Math;
import 'package:asupan_app/main.dart';
import 'package:asupan_app/models/models.dart';
import 'package:asupan_app/services/services.dart';
import 'package:asupan_app/ui/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

part 'splash.dart';
part 'frontpage.dart';
part 'login.dart';
part 'register.dart';
part 'mainmenu.dart';
part 'beranda.dart';
part 'datajk.dart';
part 'databerat.dart';
part 'bangun.dart';
part 'tidur.dart';
part 'riwayat.dart';
part 'alarm.dart';
part 'profil.dart';
part 'harian.dart';
part 'updateprofil.dart';

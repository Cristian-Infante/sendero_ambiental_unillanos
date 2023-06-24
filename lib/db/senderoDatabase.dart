import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sendero_ambiental_unillanos/db/models.dart';
class SenderoDatabase{
  static final  SenderoDatabase instancia = SenderoDatabase.init();

  static Database? _database;
  SenderoDatabase.init();

  final String nombreEstacion="Estacion";
  Future<Database> get database  async{
    if (_database != null ) return _database!;

    _database= await _initDB('sendero.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, onCreate: _onCreateDB);
  }
  Future _onCreateDB(Database db, int version) async{
    await db.execute ('''CREATE  TABLE $nombreEstacion (
       numero_est INTEGER PRIMARY KEY,
       nombre_est String,
       descrip_est Text,
       ubicacion String
       )
       ''');
    await db.execute('''CREATE  TABLE Fauna (
       id INTEGER PRIMARY KEY,
       nombre_fau String,
       descrip_fau Text,
       imagen_fau Blob
       )
       ''');
    await db.execute('''CREATE  TABLE Flora(
       id INTEGER PRIMARY KEY,
       nombre_flo String,
       descrip_flo Text,
       imagen_flo Blob
       )
       ''');

  }
  Future<void>  insert(Estacion estacion) async {
        final db=await instancia.database;
        await db.insert(nombreEstacion, estacion.toMap());
      }

}


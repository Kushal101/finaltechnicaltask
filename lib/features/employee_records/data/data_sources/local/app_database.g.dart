// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EmployeeDao? _employeeDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `employee` (`id` INTEGER, `name` TEXT, `role` TEXT, `fromDate` TEXT, `toDate` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EmployeeDao get employeeDAO {
    return _employeeDAOInstance ??= _$EmployeeDao(database, changeListener);
  }
}

class _$EmployeeDao extends EmployeeDao {
  _$EmployeeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _employeeModelInsertionAdapter = InsertionAdapter(
            database,
            'employee',
            (EmployeeModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'role': item.role,
                  'fromDate': item.fromDate,
                  'toDate': item.toDate
                }),
        _employeeModelUpdateAdapter = UpdateAdapter(
            database,
            'employee',
            ['id'],
            (EmployeeModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'role': item.role,
                  'fromDate': item.fromDate,
                  'toDate': item.toDate
                }),
        _employeeModelDeletionAdapter = DeletionAdapter(
            database,
            'employee',
            ['id'],
            (EmployeeModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'role': item.role,
                  'fromDate': item.fromDate,
                  'toDate': item.toDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EmployeeModel> _employeeModelInsertionAdapter;

  final UpdateAdapter<EmployeeModel> _employeeModelUpdateAdapter;

  final DeletionAdapter<EmployeeModel> _employeeModelDeletionAdapter;

  @override
  Future<List<EmployeeModel>> getEmployeesList() async {
    return _queryAdapter.queryList('SELECT * FROM employee',
        mapper: (Map<String, Object?> row) => EmployeeModel(
            id: row['id'] as int?,
            name: row['name'] as String?,
            role: row['role'] as String?,
            fromDate: row['fromDate'] as String?,
            toDate: row['toDate'] as String?));
  }

  @override
  Future<void> insertEmployees(EmployeeModel employee) async {
    await _employeeModelInsertionAdapter.insert(
        employee, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEmployees(EmployeeModel employee) async {
    await _employeeModelUpdateAdapter.update(
        employee, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEmployees(EmployeeModel employeeModel) async {
    await _employeeModelDeletionAdapter.delete(employeeModel);
  }
}

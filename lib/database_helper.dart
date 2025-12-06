import "package:sqlite3/sqlite3.dart";
import "student.dart";

class DatabaseHelper
{
  late final Database db;

  DatabaseHelper(String dbName)
  {
    if(dbName.isEmpty)
      throw ArgumentError("Database cannot be empty");

     db = sqlite3.open("$dbName.db");

     createTable();
  }

  void createTable()
  {
    db.execute(
      "CREATE TABLE IF NOT EXISTS students ("
          "id TEXT PRIMARY KEY, "
          "name TEXT NOT NULL, "
          "mathScore REAL NOT NULL, "
          "engScore REAL NOT NULL"
          ");"
    );
  }

  //Các hàm CRUD

  List<Student> getAllStudent()
  {
    String sql  = "SELECT * FROM students";
    ResultSet resultSet = db.select(sql);
    return resultSet.map((row) => Student.fromRow(row)).toList();
  }

  Student? findStudentById(String id)
  {
      if (id.trim().isEmpty) {
      throw ArgumentError('Id không được để trống');
    }

    const sql = "SELECT * FROM students WHERE id = ?";
    final stmt = db.prepare(sql);
    try{
      final ResultSet rs = stmt.select([id]);
      if(rs.isEmpty)
        return null;

      return Student.fromRow(rs.first);
    }catch(e)
    {
      print('Lỗi không xác định khi tìm student: $e');
      rethrow;
    }
    finally{
      stmt.close();
    }
  } 

  bool addStudent(Student sv)
  {
    final existed = findStudentById(sv.id);
    if (existed != null) {
      print('❌ Lỗi: ID "${sv.id}" đã tồn tại (check trước khi insert).');
      return false;
    }
    const sql = "INSERT INTO students(id, name, mathScore, engScore) VALUES(?, ?, ?, ?)";
    final stmt = db.prepare(sql);
    try
    {
        stmt.execute([sv.id, sv.name, sv.mathScore, sv.engScore]); 
        print('✅ Đã lưu vào Database!');
        return true;
    }on SqliteException catch(e)
    {
      
      if (e.message.contains('UNIQUE') || e.message.contains('PRIMARY KEY')) {
        print('❌ Lỗi: ID "${sv.id}" đã tồn tại, vui lòng nhập ID khác.');
      } else {
        print('❌ Lỗi database khác, vui lòng thử lại.');
      }

      return false;
    }
    catch (e) {
      print('❌ Lỗi không xác định khi thêm sinh viên: $e');
      return false;
    } finally {
      stmt.close();
    }
  }
  
  bool deleteStudent(String id)
  {
    if(id.trim().isEmpty)
      throw ArgumentError("Id không được để trống");

    final existed = findStudentById(id);
    if(existed == null)
    {
      print('❌ Lỗi: Sinh viên đã bị xóa hoặc không tồn tại');
      return false;
    }

    final stmt = db.prepare("DELETE FROM students WHERE id = ?");
    stmt.execute([id]);

    bool isDeleted =  db.updatedRows > 0;
    stmt.close();
    return isDeleted;
  }

  List<Student> searchByNames(String name)
  {
    final stmt = db.prepare('SELECT * FROM students WHERE name LIKE ?');
    
    final ResultSet results = stmt.select(['%$name%']);
    
    List<Student> list = results.map((row) => Student.fromRow(row)).toList();
    if(list.isEmpty)
      print("Dữ liệu trống");
    stmt.close();
    return list;
  }

  void close()
  {
    db.close();
  }
}
require_relative "../config/environment.rb"

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end

  def save
    if !@id.nil?
      update
    else
      sql = <<-SQL
        INSERT INTO students(name, grade) VALUES (?,?)
      SQL
      DB[:conn].execute(sql, @name, @grade)
      @id = D[:conn].execte("SELECT last_insert_rowid() from students")[0][0]
    end
  end

  def self.create(name, grade)
    new_student = Student.new(name, grade)
    save
  end

  def self.new_from_db(row)


  end

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * FROM students WHERE name = ?
    SQL
    student_data = DB[:conn].execute(sql, name)

  end
  def update
    sql = <<-SQL
      UPDATE students SET name = ? WHERE id = ?
    SQL

    DB[:conn].execute(sql, @name, @id)
  end

end

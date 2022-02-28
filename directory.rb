@students = []

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "Please select a number."
  end
end

def print_menu
  puts "1. Input the students."
  puts "2. Show the students."
  puts "3. Save student list to 'students.csv'."
  puts "4. Load student list from 'students.csv'."
  puts "9. Exit"
end

def show_students
  while @students.count == 0 do
    puts "The list is empty. Please, enter student's name to populate the list."
    break
  end
    print_header
    print_student_list(@students)
    print_footer(@students)
end

def populate_list(name, cohort)
  @students << {name: name, cohort: cohort.capitalize.to_sym}
end

def input_students
  puts "Please enter the name of the new student."
  puts "To finish, just hit return twice."

  name = STDIN.gets.chomp
  while !name.empty? do
    cohort = input_cohort
    populate_list(name, cohort)
    if @students.count == 1
      puts "Now we have 1 student."
    else
      puts "Now we have #{@students.count} students."
    end
    name = STDIN.gets.chomp
  end
end

def input_cohort
  puts "November or February cohort?"
  cohort = STDIN.gets.chomp
  while cohort.downcase != "november" && cohort.downcase != "february" do
    puts "Please type 'November' or 'February'."
    cohort = STDIN.gets.chomp
  end
  cohort
end

def print_header
  puts "The students of Villains Acaademy"
  puts "--------------"
end

def print_student_list(students)
  feb = @students.select { |student| student.has_value?(:February) }
  nov = @students.select { |student| student.has_value?(:November) }
  cohort = input_cohort
  if cohort == "february"
    feb.each_with_index do |student, i|
    puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  else
    nov.each_with_index do |student, i|
      puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{@students.count} great students."
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    populate_list(name, cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu

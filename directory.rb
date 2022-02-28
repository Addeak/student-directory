def input_students
  students = []

  puts "Please enter the name of the new student."
  puts "To finish, just hit return twice."

  name = gets.chomp
  while !name.empty? do
    cohort = input_cohort
    students << {name: name, cohort: cohort.capitalize.to_sym}
    if students.count == 1
      puts "Now we have 1 student."
    else
      puts "Now we have #{students.count} students."
    end
    name = gets.chomp
  end
  students
end

def input_cohort
  puts "November or February cohort?"
  cohort = gets.chomp
  while cohort.downcase != "november" && cohort.downcase != "february" do
    puts "Please type 'November' or 'February'."
    cohort = gets.chomp
  end
  cohort
end

def print_header
  puts "The students of Villains Acaademy"
  puts "--------------"
end

def print(students)
  feb = students.select { |student| student.has_value?(:February) }
  nov = students.select { |student| student.has_value?(:November) }
  cohort = input_cohort
  if cohort == "February"
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
  puts "Overall, we have #{students.count} great students."
end

students = input_students
while students.count == 0 do
  puts "The list is empty. Please, enter students name to populate the list."
  students = input_students
end
  print_header
  print(students)
  print_footer(students)

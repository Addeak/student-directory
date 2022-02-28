def input_students
  students = []

  puts "Please enter the name of the new student."
  puts "To finish, just hit return twice."

  name = gets.chomp
  while !name.empty? do
    puts "Is this student part of the November or Ferbruary cohort?"
    cohort = gets.chomp
    while cohort.downcase != "november" && cohort.downcase != "february" do
      puts "Please type 'November' or 'February'."
      cohort = gets.chomp
    end
    students << {name: name, cohort: cohort.capitalize.to_sym}
    puts "Now we have #{students.count} students."
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Acaademy"
  puts "--------------"
end

def print(students)
  students.each_with_index do |student, i|
    puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students."
end

students = input_students
print_header
print(students)
print_footer(students)
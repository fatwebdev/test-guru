# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create users
users = [%w[amanda amanda@test.ru pa$$word], %w[mike mike@test.ru passw0rd]].map do |login, email, password|
  { login: login, email: email, password: password }
end
User.create!(users)

user_amanda = User.find_by(email: 'amanda@test.ru')
user_mike = User.find_by(email: 'mike@test.ru')

# create categories
category_html, category_css, category_js = %w[HTML CSS JS].map do |title|
  entity = Category.new(title: title)
  entity.save
  entity
end

# create tests
tests = [['HTML5 feature', 1, category_html, user_amanda],
         ['semantic tags', 2, category_html, user_amanda],
         ['CSS3 feature', 1, category_css, user_amanda],
         ['arrow functions', 2, category_js, user_amanda],
         ['observers', 3, category_js, user_mike]].map do |title, level, category, author|
  { title: title, level: level, category: category, author: author }
end
Test.create(tests)

test_tags = Test.find_by(title: 'semantic tags')
test_css3 = Test.find_by(title: 'CSS3 feature')
test_arrow_functions = Test.find_by(title: 'arrow functions')
test_observers = Test.find_by(title: 'observers')

# create questions
questions = [['Can you offer a use case for the new arrow => function syntax? How does this new syntax differ from other functions?', test_arrow_functions],
             ['What advantage is there for using the arrow syntax for a method in a constructor?', test_arrow_functions],
             ['What interface provides the ability to watch for changes being made to the DOM tree?', test_observers],
             ['What property using for creating shadow?', test_css3],
             ['What difference between b and strong tags?', test_tags]].map do |body, test|
  { body: body, test: test }
end
Question.create(questions)

question_tag_diff = Question.find_by(body: 'What difference between b and strong tags?')
question_box_shadow = Question.find_by(body: 'What property using for creating shadow?')

# create answers
answers = [['There is no difference between them.', false, question_tag_diff],
           ['There is a semantic difference between them', true, question_tag_diff],
           ['shadow-box', false, question_box_shadow],
           ['box-shadow', true, question_box_shadow]].map do |body, correct, question|
  { body: body, correct: correct, question: question }
end
Answer.create(answers)

# create passing tests
passing_tests = [[user_amanda, test_tags, true, question_tag_diff],
                 [user_amanda, test_css3, true, question_box_shadow],
                 [user_mike, test_tags, false, question_tag_diff],
                 [user_mike, test_css3, true, question_box_shadow]].map do |user, test, done, question|
  { user: user, test: test, done: done, current_question: question }
end

PassingTest.create(passing_tests)

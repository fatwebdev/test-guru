# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create categories
category_html, category_css, category_js = %w[HTML CSS JS].map do |title|
  entity = Category.new(title: title)
  entity.save
  entity
end

# create tests
tests = [['HTML5 feature', 1, category_html],
         ['semantic tags', 2, category_html],
         ['CSS3 feature', 1, category_css],
         ['arrow functions', 2, category_js],
         ['observers', 3, category_js]].map do |title, level, category|
  { title: title, level: level, category_id: category.id }
end
Test.create(tests)

test_tags = Test.where(title: 'semantic tags').first
test_css3 = Test.where(title: 'CSS3 feature').first
test_arrow_functions = Test.where(title: 'arrow functions').first
test_observers = Test.where(title: 'observers').first

# create questions
questions = [['Can you offer a use case for the new arrow => function syntax? How does this new syntax differ from other functions?', test_arrow_functions],
             ['What advantage is there for using the arrow syntax for a method in a constructor?', test_arrow_functions],
             ['What interface provides the ability to watch for changes being made to the DOM tree?', test_observers],
             ['What property using for creating shadow?', test_css3],
             ['What difference between b and strong tags?', test_tags]].map do |body, test|
  { body: body, test_id: test.id }
end
Question.create(questions)

question_tag_diff = Question.where(body: 'What difference between b and strong tags?').first
question_box_shadow = Question.where(body: 'What property using for creating shadow?').first

# create answers
answers = [['There is no difference between them.', false, question_tag_diff],
           ['There is a semantic difference between them', true, question_tag_diff],
           ['shadow-box', false, question_box_shadow],
           ['box-shadow', true, question_box_shadow]].map do |body, correct, question|
  { body: body, correct: correct, question_id: question.id }
end
Answer.create(answers)

# create users
users = [%w[Amanda pa$$word], %w[Mike passw0rd]].map do |login, password|
  { login: login, password: password }
end
User.create(users)

user_amanda = User.where(login: 'Amanda').first
user_mike = User.where(login: 'Mike').first

# create passing tests
passing_tests = [[user_amanda, test_tags, true],
                 [user_amanda, test_css3, true],
                 [user_mike, test_tags, false],
                 [user_mike, test_css3, true]].map do |user, test, done|
  { user_id: user.id, test_id: test.id, done: done }
end
PassingTest.create(passing_tests)

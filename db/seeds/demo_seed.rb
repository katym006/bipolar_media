puts "== Demo seed =="

# Города
cities = %w[Москва Санкт-Петербург Казань Новосибирск Екатеринбург].map do |name|
  City.find_or_create_by!(name: name)
end

# Теги
tag_colors = {
  "Диагноз" => "#6C8EBF", "Сон" => "#8E7CC3", "Близким" => "#E69138",
  "Лекарства" => "#6AA84F", "Мифы" => "#CC4125", "Самопомощь" => "#45818E"
}
tags = tag_colors.to_h do |name, color|
  [ name, Tag.find_or_create_by!(name: name) { |t| t.color = color } ]
end

# Пользователи
def seed_user(email:, name:, role:, access_role: "reader")
  User.find_or_create_by!(email: email) do |u|
    u.name = name
    u.role = role
    u.access_role = access_role
    u.password = "password123"
  end
end

admin    = seed_user(email: "admin@example.com", name: "Администратор", role: "curious", access_role: "admin")
author   = seed_user(email: "author@example.com", name: "Редакция", role: "curious", access_role: "author")
patient  = seed_user(email: "patient@example.com", name: "Анна", role: "new")
relative = seed_user(email: "relative@example.com", name: "Игорь", role: "relative")

# Профиль, трекер, доверенный контакт
profile = Profile.find_or_create_by!(user: patient) do |p|
  p.display_name = "Анна"
  p.city = cities.first
  p.diagnosed_at = 2.months.ago.to_date
end

moods  = [ 5, 6, 4, 7, 8, 6, 5, 3, 4, 5, 6, 7, 6, 5 ]
energy = [ 5, 6, 5, 8, 9, 7, 5, 3, 3, 4, 6, 7, 6, 5 ]
sleep  = [ 7.5, 7, 8, 6, 5, 6, 7.5, 9, 10, 8, 7, 7, 7.5, 8 ]
14.times do |i|
  MoodEntry.find_or_create_by!(profile: profile, entry_date: (13 - i).days.ago.to_date) do |m|
    m.mood_level = moods[i]
    m.energy_level = energy[i]
    m.sleep_hours = sleep[i]
    m.emotions = "спокойствие"
  end
end

TrustedContact.find_or_create_by!(profile: profile, email: "mama@example.com") do |c|
  c.name = "Мама"
  c.share_mood = false
end

# Специалисты (вымышленные)
[
  [ "Иванова Мария Сергеевна", "Психиатр", 0 ],
  [ "Петров Алексей Николаевич", "Психотерапевт", 1 ],
  [ "Соколова Елена Викторовна", "Клинический психолог", 2 ],
  [ "Кузнецов Дмитрий Андреевич", "Психиатр", 3 ],
  [ "Морозова Ольга Павловна", "Психотерапевт", 4 ]
].each do |full_name, specialty, city_index|
  Specialist.find_or_create_by!(full_name: full_name) do |s|
    s.specialty = specialty
    s.city = cities[city_index]
    s.contacts = "Демо-контакты: +7 000 000-00-00"
    s.rating = 4.5
  end
end

# Статьи
articles_data = [
  { title: "Что такое биполярное расстройство", kind: "guide", audience: "both",
    summary: "Краткое введение: что это за состояние и чем оно не является.",
    body: "Биполярное расстройство — состояние, при котором периоды подъёма настроения и энергии сменяются периодами спада. Это не «характер» и не слабость воли. Диагноз ставит врач-психиатр.",
    tags: %w[Диагноз] },
  { title: "Первые недели после диагноза: с чего начать", kind: "guide", audience: "patient",
    summary: "Практичный план для тех, кто только узнал диагноз.",
    body: "Диагноз вызывает много эмоций, и это нормально. Для начала запишите вопросы к врачу, уточните план лечения и начните вести дневник настроения и сна.",
    tags: %w[Диагноз Самопомощь] },
  { title: "Как поддержать близкого с биполярным расстройством", kind: "guide", audience: "relative",
    summary: "Что помогает, а что лучше не делать.",
    body: "Слушайте без оценок, не спорьте с человеком в острой фазе, интересуйтесь, какая помощь ему нужна. Не забывайте и о собственных ресурсах.",
    tags: %w[Близким] },
  { title: "Миф: перепады настроения — это просто характер", kind: "myth", audience: "both",
    summary: "Чем перепады при расстройстве отличаются от обычных.",
    body: "Обычные колебания настроения связаны с событиями и проходят быстро. При биполярном расстройстве фазы длятся днями и неделями и заметно влияют на жизнь.",
    tags: %w[Мифы] },
  { title: "Почему важен режим сна", kind: "post", audience: "patient",
    summary: "Сон — один из самых заметных сигналов состояния.",
    body: "Резкое сокращение или увеличение сна может быть ранним признаком смены фазы. Регулярный режим помогает держать состояние стабильнее.",
    tags: %w[Сон Самопомощь] },
  { title: "Что делать, если вы подозреваете у себя расстройство", kind: "post", audience: "both",
    summary: "Первые шаги без самодиагностики.",
    body: "Интернет-тесты не заменяют консультацию. Запишитесь к психиатру, возьмите с собой записи о настроении и сне и, если можно, мнение близкого человека.",
    tags: %w[Диагноз] }
]

created_articles = articles_data.map do |data|
  article = Article.find_or_create_by!(title: data[:title]) do |a|
    a.summary = data[:summary]
    a.body = data[:body]
    a.content_kind = data[:kind]
    a.audience = data[:audience]
    a.author = author
    a.expert_reviewed = false
    a.published_at = 1.week.ago
  end
  article.tags = data[:tags].map { |name| tags.fetch(name) }
  article
end

# Тест и попытка с рекомендациями
screening = ScreeningTest.find_or_create_by!(title: "Самопроверка: настроение и сон") do |t|
  t.kind = "self_check"
  t.description = "Короткая самопроверка. Не является диагнозом."
end

[
  "Бывали ли периоды, когда вы спали заметно меньше обычного и не чувствовали усталости?",
  "Бывали ли периоды необычно высокого настроения и прилива энергии?",
  "Случались ли периоды глубокого спада, когда ничего не радовало?",
  "Замечали ли близкие резкие перемены в вашем настроении?"
].each_with_index do |text, i|
  TestQuestion.find_or_create_by!(screening_test: screening, position: i + 1) { |q| q.text = text }
end

attempt = TestAttempt.find_or_create_by!(user: patient, screening_test: screening) do |a|
  a.answers = { "1" => true, "2" => true, "3" => false, "4" => true }
  a.score = 3
  a.completed_at = Time.current
end

created_articles.first(2).each do |article|
  Recommendation.find_or_create_by!(test_attempt: attempt, article: article) do |r|
    r.reason = "Подходит по результатам самопроверки"
  end
end

puts "Cities: #{City.count}, Tags: #{Tag.count}, Users: #{User.count}, Articles: #{Article.count}, " \
     "Specialists: #{Specialist.count}, Mood entries: #{MoodEntry.count}"

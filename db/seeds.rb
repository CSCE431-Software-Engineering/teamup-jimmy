# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Seed Gyms
gym1 = Gym.create(name: "Polo Gym", address: "322 Polo Rd, College Station, TX 77843", start_time: "06:00", end_time: "21:00")
gym2 = Gym.create(name: "Student Rec Center", address: "187 Corrington Dr, College Station, TX 77843", start_time: "06:00", end_time: "00:00")

# Seed Students
student1 = Student.create(email: "allie.saxton@tamu.edu", name: "Allie Saxton", gender: "F", birthday: "2003-07-22")
student2 = Student.create(email: "yushantan@tamu.edu", name: "Lily Tang", gender: "F", birthday: "2003-02-25")
student3 = Student.create(email: "avirala16@tamu.edu", name: "Aviral Agarwal", gender: "M", birthday: "2002-10-15")
student4 = Student.create(email: "kieranbeirne01@tamu.edu", name: "Kieran Beirne", gender: "M", birthday: "2001-09-06")
student5 = Student.create(email: "kawan_ardalan@tamu.edu", name: "Kawan Ardalan", gender: "M", birthday: "2002-04-30")


# Seed Activities
activity1 = Activity.create(activity_name: "Yoga")
activity2 = Activity.create(activity_name: "Weightlifting")
activity2 = Activity.create(activity_name: "Badminton")

# Seed Activity Logs
activity_log1 = ActivityLog.create(activity_id: activity1.id, gym_id: gym1.id, description: "Morning Yoga Session", hours: 1.5, date: Date.today)
activity_log2 = ActivityLog.create(activity_id: activity2.id, gym_id: gym2.id, description: "Evening Weights", hours: 2.0, date: Date.today)

# Seed Activity Preferences
ActivityPreference.create(activity_id: activity1.id, student_email: student1.email)
ActivityPreference.create(activity_id: activity2.id, student_email: student2.email)

# Seed Experience Levels
ExperienceLevel.create(student_email: student1.email, activity_id: activity1.id, experience: 3)
ExperienceLevel.create(student_email: student2.email, activity_id: activity2.id, experience: 5)

# Seed Gym Preferences
GymPreference.create(student_email: student1.email, gym_id: gym1.id)
GymPreference.create(student_email: student2.email, gym_id: gym2.id)

# Seed Matches
Match.create(student1_email: student1.email, student2_email: student2.email, relation: "Friends")
Match.create(student1_email: student2.email, student2_email: student3.email, relation: "Friends")
Match.create(student1_email: student3.email, student2_email: student1.email, relation: "Friends")
Match.create(student1_email: student4.email, student2_email: student5.email, relation: "Blocked")

# Seed Student Activities
StudentActivity.create(student_email: student1.email, activity_log_id: activity_log1.id)
StudentActivity.create(student_email: student2.email, activity_log_id: activity_log2.id)

# Seed Time Preferences
TimePreference.create(student_email: student1.email, time_start: "06:00", time_end: "07:00", day: "Monday")
TimePreference.create(student_email: student2.email, time_start: "18:00", time_end: "20:00", day: "Wednesday")

# Guideian Subject and Career Matching Algorithm Prototype

# Sample data
degrees = [
    {"name": "Computer Science", "min_marks": 75, "demand_score": 9, "field": "Technology"},
    {"name": "Data Science", "min_marks": 78, "demand_score": 10, "field": "Technology"},
    {"name": "Mechanical Engineering", "min_marks": 70, "demand_score": 7, "field": "Engineering"},
    {"name": "Accounting", "min_marks": 65, "demand_score": 8, "field": "Finance"},
    {"name": "Psychology", "min_marks": 60, "demand_score": 6, "field": "Humanities"},
    {"name": "Law", "min_marks": 80, "demand_score": 9, "field": "Law"},
    {"name": "Nursing", "min_marks": 60, "demand_score": 7, "field": "Healthcare"},
    {"name": "Teaching", "min_marks": 55, "demand_score": 5, "field": "Education"},
]

# Student input
student = {
    "average_marks": 72,
    "interests": ["Technology", "Engineering"],
    "location": "Gauteng",        # optional for future
    "affordability_tier": "Mid",   # optional for future
}

# Step 1: Match degrees based on academic marks
eligible_degrees = [degree for degree in degrees if student["average_marks"] >= degree["min_marks"]]

# Step 2: Filter by labor market demand
high_demand_degrees = [degree for degree in eligible_degrees if degree["demand_score"] >= 7]

# Step 3: Personalize using student interests
personalized_degrees = [
    degree for degree in high_demand_degrees if degree["field"] in student["interests"]
]

# Step 4: If no match in interests, fallback to high-demand eligible degrees
final_recommendations = personalized_degrees if personalized_degrees else high_demand_degrees

# Output Recommendations
print("Recommended Degrees for the Student:")
for degree in final_recommendations:
    print(f"- {degree['name']} ({degree['field']})")
# Guideian Subject and Career Matching Algorithm Prototype

# Sample data
degrees = [
    {"name": "Computer Science", "min_marks": 75, "demand_score": 9, "field": "Technology"},
    {"name": "Data Science", "min_marks": 78, "demand_score": 10, "field": "Technology"},
    {"name": "Mechanical Engineering", "min_marks": 70, "demand_score": 7, "field": "Engineering"},
    {"name": "Accounting", "min_marks": 65, "demand_score": 8, "field": "Finance"},
    {"name": "Psychology", "min_marks": 60, "demand_score": 6, "field": "Humanities"},
    {"name": "Law", "min_marks": 80, "demand_score": 9, "field": "Law"},
    {"name": "Nursing", "min_marks": 60, "demand_score": 7, "field": "Healthcare"},
    {"name": "Teaching", "min_marks": 55, "demand_score": 5, "field": "Education"},
]

# Student input
student = {
    "average_marks": 72,
    "interests": ["Technology", "Engineering"],
    "location": "Gauteng",        # optional for future
    "affordability_tier": "Mid",   # optional for future
}

# Step 1: Match degrees based on academic marks
eligible_degrees = [degree for degree in degrees if student["average_marks"] >= degree["min_marks"]]

# Step 2: Filter by labor market demand
high_demand_degrees = [degree for degree in eligible_degrees if degree["demand_score"] >= 7]

# Step 3: Personalize using student interests
personalized_degrees = [
    degree for degree in high_demand_degrees if degree["field"] in student["interests"]
]

# Step 4: If no match in interests, fallback to high-demand eligible degrees
final_recommendations = personalized_degrees if personalized_degrees else high_demand_degrees

# Output Recommendations
print("Recommended Degrees for the Student:")
for degree in final_recommendations:
    print(f"- {degree['name']} ({degree['field']})")

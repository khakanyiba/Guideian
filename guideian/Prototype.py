# Guideian Subject and Career Matching Algorithm Prototype (Extended)

# Sample degree data
degrees = [
    {
        "name": "Computer Science",
        "min_marks": 75,
        "demand_score": 9,
        "field": "Technology",
        "location": "Gauteng",
        "affordability": "Mid"
    },
    {
        "name": "Data Science",
        "min_marks": 78,
        "demand_score": 10,
        "field": "Technology",
        "location": "Western Cape",
        "affordability": "High"
    },
    {
        "name": "Mechanical Engineering",
        "min_marks": 70,
        "demand_score": 7,
        "field": "Engineering",
        "location": "KwaZulu-Natal",
        "affordability": "Mid"
    },
    {
        "name": "Accounting",
        "min_marks": 65,
        "demand_score": 8,
        "field": "Finance",
        "location": "Gauteng",
        "affordability": "Low"
    },
    {
        "name": "Psychology",
        "min_marks": 60,
        "demand_score": 6,
        "field": "Humanities",
        "location": "Eastern Cape",
        "affordability": "Low"
    },
    {
        "name": "Law",
        "min_marks": 80,
        "demand_score": 9,
        "field": "Law",
        "location": "Gauteng",
        "affordability": "High"
    },
    {
        "name": "Nursing",
        "min_marks": 60,
        "demand_score": 7,
        "field": "Healthcare",
        "location": "KwaZulu-Natal",
        "affordability": "Low"
    },
    {
        "name": "Teaching",
        "min_marks": 55,
        "demand_score": 5,
        "field": "Education",
        "location": "Western Cape",
        "affordability": "Low"
    }
]

# Student input
student = {
    "average_marks": 72,
    "interests": ["Technology", "Engineering"],
    "location": "Gauteng",
    "affordability_tier": "Mid"  # Options: Low / Mid / High
}

# Step 1: Filter by Marks
eligible_degrees = [degree for degree in degrees if student["average_marks"] >= degree["min_marks"]]

# Step 2: Filter by Demand
high_demand_degrees = [degree for degree in eligible_degrees if degree["demand_score"] >= 7]

# Step 3: Filter by Location
location_matched_degrees = [degree for degree in high_demand_degrees if degree["location"] == student["location"]]

# Step 4: Filter by Affordability
affordable_degrees = [degree for degree in location_matched_degrees if degree["affordability"] == student["affordability_tier"]]

# Step 5: Personalization (Interests)
personalized_degrees = [degree for degree in affordable_degrees if degree["field"] in student["interests"]]

# Fallbacks
if not personalized_degrees:
    personalized_degrees = affordable_degrees
if not personalized_degrees:
    personalized_degrees = location_matched_degrees
if not personalized_degrees:
    personalized_degrees = high_demand_degrees
if not personalized_degrees:
    personalized_degrees = eligible_degrees

# Output the final recommended degrees
print("Recommended Degrees for the Student:")
for degree in personalized_degrees:
    print(f"- {degree['name']} ({degree['field']}) in {degree['location']} [{degree['affordability']} Cost]")

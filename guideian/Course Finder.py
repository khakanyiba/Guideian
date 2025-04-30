from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# Sample degree data
degrees = [
    {
        "name": "Computer Science",
        "min_marks": 75,
        "demand_score": 9,
        "field": "Technology",
        "location": "Gauteng",
        "affordability": "Mid",
        "description": "Computer programming, algorithms, AI, data structures."
    },
    {
        "name": "Data Science",
        "min_marks": 78,
        "demand_score": 10,
        "field": "Technology",
        "location": "Western Cape",
        "affordability": "High",
        "description": "Big data, machine learning, statistics, Python, R."
    },
    {
        "name": "Mechanical Engineering",
        "min_marks": 70,
        "demand_score": 7,
        "field": "Engineering",
        "location": "KwaZulu-Natal",
        "affordability": "Mid",
        "description": "Thermodynamics, fluid mechanics, design, manufacturing."
    },
    {
        "name": "Accounting",
        "min_marks": 65,
        "demand_score": 8,
        "field": "Finance",
        "location": "Gauteng",
        "affordability": "Low",
        "description": "Auditing, financial reporting, tax, Excel, budgeting."
    },
    {
        "name": "Psychology",
        "min_marks": 60,
        "demand_score": 6,
        "field": "Humanities",
        "location": "Eastern Cape",
        "affordability": "Low",
        "description": "Cognitive science, therapy, behavior, research."
    },
    {
        "name": "Law",
        "min_marks": 80,
        "demand_score": 9,
        "field": "Law",
        "location": "Gauteng",
        "affordability": "High",
        "description": "Legal systems, contracts, litigation, ethics."
    },
    {
        "name": "Nursing",
        "min_marks": 60,
        "demand_score": 7,
        "field": "Healthcare",
        "location": "KwaZulu-Natal",
        "affordability": "Low",
        "description": "Healthcare, medicine, patient care, anatomy, biology."
    },
    {
        "name": "Teaching",
        "min_marks": 55,
        "demand_score": 5,
        "field": "Education",
        "location": "Western Cape",
        "affordability": "Low",
        "description": "Classroom, education, pedagogy, learning, training."
    }
]

# Gather input from user
print("Welcome to the Guideian Degree Matcher!")
try:
    avg = int(input("Enter your average mark (%): "))
    interests = input("Enter your academic interests (comma separated, e.g. Technology,Engineering): ")
    location = input("Enter your preferred study location (e.g. Gauteng, Western Cape): ").strip()
    affordability = input("Enter your affordability tier (Low / Mid / High): ").capitalize()

    student = {
        "average_marks": avg,
        "interests": [i.strip() for i in interests.split(",")],
        "location": location,
        "affordability_tier": affordability
    }

    # Step 1: Filter by marks
    eligible = [d for d in degrees if student["average_marks"] >= d["min_marks"]]

    # Step 2: Filter by demand
    demanded = [d for d in eligible if d["demand_score"] >= 7]

    # Step 3: Filter by location
    loc_matched = [d for d in demanded if d["location"].lower() == student["location"].lower()]

    # Step 4: Filter by affordability
    affordable = [d for d in loc_matched if d["affordability"].lower() == student["affordability_tier"].lower()]

    # Use AI-enhanced matching based on interests
    recommend_pool = affordable or loc_matched or demanded or eligible

    if not recommend_pool:
        print("No degrees available for your criteria. Please broaden your input.")
    else:
        student_profile = " ".join(student["interests"])
        corpus = [deg["description"] for deg in recommend_pool] + [student_profile]

        vectorizer = TfidfVectorizer()
        tfidf_matrix = vectorizer.fit_transform(corpus)

        if tfidf_matrix.shape[0] < 2:
            print("Not enough data to compute similarity.")
        else:
            similarities = cosine_similarity(tfidf_matrix[-1:], tfidf_matrix[:-1]).flatten()
            top_indices = similarities.argsort()[::-1]
            recommended = [recommend_pool[i] for i in top_indices[:3]]

            print("\n Recommended Degrees Based on Your Inputs:")
            for deg in recommended:
                print(f" - {deg['name']} ({deg['field']}) in {deg['location']} [{deg['affordability']} Tier]")

except Exception as e:
    print(f" An error occurred: {e}")

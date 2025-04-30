import random

# Fixed compulsory subjects
compulsory_subjects = {
    "Home Languages": ["English HL", "IsiZulu HL", "IsiXhosa HL", "Afrikaans HL", "Sesotho HL"],
    "First Additional Languages": ["English FAL", "Afrikaans FAL", "IsiZulu FAL", "IsiXhosa FAL", "Sesotho FAL"],
    "Life Orientation": "Life Orientation"
}

# Elective subjects mapped by interest keywords (excluding Mathematics)
electives_by_interest = {
    "technology": ["Information Technology", "Computer Applications Technology"],
    "engineering": ["Physical Sciences", "Engineering Graphics & Design"],
    "medicine": ["Life Sciences", "Physical Sciences"],
    "law": ["History", "Languages", "Business Studies"],
    "finance": ["Accounting", "Business Studies", "Economics"],
    "creative": ["Visual Arts", "Dramatic Arts", "Design"],
    "history": ["History", "Geography", "Tourism"],
    "education": ["Life Sciences", "History", "Languages"],
    "agriculture": ["Agricultural Sciences", "Geography", "Life Sciences"],
    "environment": ["Geography", "Life Sciences", "Physical Sciences"]
}

# Get student input
print("🎓 Welcome to the Grade 9 Subject Selection Assistant (Guideian Prototype)\n")
interest_input = input("Enter your interests (e.g. medicine, engineering, environment): ").lower().strip()
home_lang = input("Choose your Home Language (e.g. English HL, IsiZulu HL, etc.): ")
first_add_lang = input("Choose your First Additional Language (e.g. Afrikaans FAL, IsiXhosa FAL, etc.): ")
math_choice = input("Choose one: Mathematics or Mathematical Literacy: ").strip()

# Validate math input
if math_choice.lower() not in ["mathematics", "mathematical literacy"]:
    print("⚠️ Invalid choice. Defaulting to Mathematics.")
    math_choice = "Mathematics"
else:
    math_choice = math_choice.title()

num_electives = input("Would you like 3 or 4 electives? ")

try:
    num_electives = int(num_electives)
    if num_electives not in [3, 4]:
        raise ValueError
except ValueError:
    print("⚠️ Invalid input for number of electives. Defaulting to 3.")
    num_electives = 3

# Match electives
matched_subjects = []
for keyword, subjects in electives_by_interest.items():
    if keyword in interest_input:
        matched_subjects.extend(subjects)

# Remove duplicates and limit
matched_subjects = list(set(matched_subjects))
if math_choice in matched_subjects:
    matched_subjects.remove(math_choice)

recommended_electives = matched_subjects[:num_electives]

# Fallback if nothing matched
if not recommended_electives:
    all_electives = [subject for subjects in electives_by_interest.values() for subject in subjects]
    recommended_electives = random.sample(list(set(all_electives)), num_electives)

# Final Subject Package
print("\n📘 Based on your interests, here’s your recommended subject selection:\n")
print(f"✅ Home Language: {home_lang}")
print(f"✅ First Additional Language: {first_add_lang}")
print(f"✅ Compulsory: Life Orientation")
print(f"✅ Compulsory: {math_choice}")
for i, subject in enumerate(recommended_electives, start=1):
    print(f"✅ Elective {i}: {subject}")

print("\n👍 You’re all set! These subjects align with your future aspirations.")

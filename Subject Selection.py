# Updated Grade 9 Subject Selection Assistant (Guideian Prototype)

import random

# Fixed compulsory subjects
compulsory_subjects = {
    "Home Languages": ["English HL", "IsiZulu HL", "IsiXhosa HL", "Afrikaans HL", "Sesotho HL"],
    "First Additional Languages": ["English FAL", "Afrikaans FAL", "IsiZulu FAL", "IsiXhosa FAL", "Sesotho FAL"],
    "Life Orientation": "Life Orientation"
}

# Elective subjects mapped by interest keywords (excluding Mathematics/Maths Literacy)
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
math_choice = input("Choose one: Mathematics or Mathematical Literacy: ").strip().title()
num_electives = input("Would you like 3 or 4 electives? ")

# Validate math input
if math_choice not in ["Mathematics", "Mathematical Literacy"]:
    print("⚠️ Invalid math choice. Defaulting to Mathematics.")
    math_choice = "Mathematics"

# Validate elective number input
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

# Remove duplicates and allow full set
recommended_electives = list(set(matched_subjects))

# If too few subjects matched, pad with random electives from the global pool
if len(recommended_electives) < num_electives:
    all_electives = list(set(subject for subjects in electives_by_interest.values() for subject in subjects))
    remaining = num_electives - len(recommended_electives)
    # Ensure no duplicates
    extras = [subj for subj in all_electives if subj not in recommended_electives]
    recommended_electives += random.sample(extras, remaining)

# Final Subject Package Output
print("\n📘 Based on your interests, here’s your recommended subject selection:\n")
print(f"✅ Home Language: {home_lang}")
print(f"✅ First Additional Language: {first_add_lang}")
print(f"✅ Compulsory: Life Orientation")
print(f"✅ Compulsory: {math_choice}")
for i, subject in enumerate(recommended_electives[:num_electives], start=1):
    print(f"✅ Elective {i}: {subject}")

print("\n👍 You’re all set! These subjects align with your future aspirations.")


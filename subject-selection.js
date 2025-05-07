document.addEventListener('DOMContentLoaded', function() {
  // Available subjects for selection
  const availableSubjects = [
    "Mathematics", "Mathematical Literacy", "Physical Sciences", "Life Sciences",
    "English Home Language", "English First Additional Language", "Afrikaans",
    "IsiZulu", "History", "Geography", "Accounting", "Business Studies",
    "Economics", "Information Technology", "Computer Applications Technology",
    "Engineering Graphics and Design", "Visual Arts", "Dramatic Arts",
    "Music", "Life Orientation", "Agricultural Sciences", "Agricultural Technology",
    "Hospitality Studies", "Consumer Studies", "Religious Studies"
  ];

  // Interest categories
  const interestCategories = [
    { name: "Technology", description: "Computers, programming, IT systems", icon: "fas fa-laptop-code" },
    { name: "Engineering", description: "Building, designing, problem-solving", icon: "fas fa-cogs" },
    { name: "Medicine", description: "Healthcare, biology, helping people", icon: "fas fa-heartbeat" },
    { name: "Business", description: "Entrepreneurship, management, finance", icon: "fas fa-chart-line" },
    { name: "Arts", description: "Creative fields, design, expression", icon: "fas fa-palette" },
    { name: "Science", description: "Research, experiments, discovery", icon: "fas fa-flask" },
    { name: "Law", description: "Justice, legal systems, debate", icon: "fas fa-gavel" },
    { name: "Education", description: "Teaching, mentoring, sharing knowledge", icon: "fas fa-chalkboard-teacher" },
    { name: "Environment", description: "Nature, conservation, sustainability", icon: "fas fa-leaf" },
    { name: "Social Sciences", description: "Human behavior, society, culture", icon: "fas fa-users" },
    { name: "Mathematics", description: "Numbers, patterns, problem-solving", icon: "fas fa-square-root-alt" },
    { name: "Sports", description: "Physical activity, health, competition", icon: "fas fa-running" }
  ];

  // Career recommendations database
  const careerDatabase = [
    {
      title: "Software Engineering",
      category: "Technology",
      requiredSubjects: ["Mathematics", "Physical Sciences", "Information Technology"],
      minMaths: 70,
      minScience: 65,
      employmentRate: 98,
      avgSalary: 520000,
      duration: 4,
      cost: 65000,
      description: "Design and develop software systems and applications. High demand in tech industry with excellent growth potential.",
      bestFor: ["problem-solving", "logical-thinking", "technology"],
      institutions: ["University of Cape Town", "University of the Witwatersrand", "Stellenbosch University"]
    },
    {
      title: "Data Science",
      category: "Technology",
      requiredSubjects: ["Mathematics", "Information Technology", "English"],
      minMaths: 75,
      minScience: 60,
      employmentRate: 95,
      avgSalary: 480000,
      duration: 4,
      cost: 60000,
      description: "Extract insights from complex data to drive decision-making. Growing field across all industries.",
      bestFor: ["analytical", "mathematics", "problem-solving"],
      institutions: ["University of Pretoria", "University of Cape Town", "University of KwaZulu-Natal"]
    },
    {
      title: "Mechanical Engineering",
      category: "Engineering",
      requiredSubjects: ["Mathematics", "Physical Sciences", "Engineering Graphics and Design"],
      minMaths: 75,
      minScience: 70,
      employmentRate: 92,
      avgSalary: 450000,
      duration: 4,
      cost: 70000,
      description: "Design and analyze mechanical systems. Diverse opportunities in manufacturing, energy, and automotive sectors.",
      bestFor: ["problem-solving", "technical", "design"],
      institutions: ["University of the Witwatersrand", "University of Pretoria", "Stellenbosch University"]
    },
    {
      title: "Medicine",
      category: "Medicine",
      requiredSubjects: ["Mathematics", "Physical Sciences", "Life Sciences"],
      minMaths: 80,
      minScience: 85,
      employmentRate: 99,
      avgSalary: 600000,
      duration: 6,
      cost: 90000,
      description: "Diagnose and treat medical conditions. Long but rewarding career with high social impact.",
      bestFor: ["helping-people", "science", "health"],
      institutions: ["University of Cape Town", "University of the Witwatersrand", "Stellenbosch University"]
    },
    {
      title: "Accounting",
      category: "Business",
      requiredSubjects: ["Mathematics", "Accounting", "English"],
      minMaths: 65,
      minScience: 0,
      employmentRate: 90,
      avgSalary: 380000,
      duration: 3,
      cost: 50000,
      description: "Prepare and examine financial records. Stable career path with opportunities in various industries.",
      bestFor: ["numbers", "detail-oriented", "business"],
      institutions: ["University of Johannesburg", "University of Pretoria", "Nelson Mandela University"]
    },
    {
      title: "Graphic Design",
      category: "Arts",
      requiredSubjects: ["Visual Arts", "English", "Computer Applications Technology"],
      minMaths: 50,
      minScience: 0,
      employmentRate: 85,
      avgSalary: 280000,
      duration: 3,
      cost: 45000,
      description: "Create visual concepts to communicate ideas. Creative career with opportunities in advertising and media.",
      bestFor: ["creative", "artistic", "visual-thinking"],
      institutions: ["Stellenbosch University", "University of Johannesburg", "Durban University of Technology"]
    },
    {
      title: "Environmental Science",
      category: "Environment",
      requiredSubjects: ["Life Sciences", "Geography", "Mathematics"],
      minMaths: 60,
      minScience: 65,
      employmentRate: 88,
      avgSalary: 350000,
      duration: 3,
      cost: 55000,
      description: "Study and solve environmental problems. Growing field with focus on sustainability and conservation.",
      bestFor: ["nature", "science", "problem-solving"],
      institutions: ["University of Cape Town", "Rhodes University", "University of KwaZulu-Natal"]
    },
    {
      title: "Law",
      category: "Law",
      requiredSubjects: ["English", "History", "Business Studies"],
      minMaths: 60,
      minScience: 0,
      employmentRate: 82,
      avgSalary: 400000,
      duration: 4,
      cost: 65000,
      description: "Practice and interpret the law. Diverse career paths in corporate, criminal, or civil law.",
      bestFor: ["debate", "justice", "reading"],
      institutions: ["University of Cape Town", "University of the Witwatersrand", "Stellenbosch University"]
    },
    {
      title: "Education",
      category: "Education",
      requiredSubjects: ["English", "Life Orientation", "Mathematics"],
      minMaths: 50,
      minScience: 0,
      employmentRate: 95,
      avgSalary: 300000,
      duration: 4,
      cost: 40000,
      description: "Teach and inspire future generations. Rewarding career with strong job security.",
      bestFor: ["teaching", "mentoring", "communication"],
      institutions: ["University of Johannesburg", "University of Pretoria", "University of the Western Cape"]
    },
    {
      title: "Biotechnology",
      category: "Science",
      requiredSubjects: ["Mathematics", "Life Sciences", "Physical Sciences"],
      minMaths: 70,
      minScience: 75,
      employmentRate: 85,
      avgSalary: 420000,
      duration: 4,
      cost: 70000,
      description: "Apply biological processes to develop products. Cutting-edge field with research opportunities.",
      bestFor: ["science", "research", "innovation"],
      institutions: ["University of Pretoria", "University of Cape Town", "Stellenbosch University"]
    },
    {
      title: "Hospitality Management",
      category: "Business",
      requiredSubjects: ["Hospitality Studies", "English", "Business Studies"],
      minMaths: 50,
      minScience: 0,
      employmentRate: 90,
      avgSalary: 320000,
      duration: 3,
      cost: 50000,
      description: "Manage operations in hotels and resorts. Dynamic career with international opportunities.",
      bestFor: ["people-skills", "organization", "service"],
      institutions: ["Cape Peninsula University of Technology", "Durban University of Technology", "Tshwane University of Technology"]
    },
    {
      title: "Civil Engineering",
      category: "Engineering",
      requiredSubjects: ["Mathematics", "Physical Sciences", "Engineering Graphics and Design"],
      minMaths: 75,
      minScience: 70,
      employmentRate: 93,
      avgSalary: 460000,
      duration: 4,
      cost: 70000,
      description: "Design and maintain infrastructure projects. Essential field with government and private sector demand.",
      bestFor: ["problem-solving", "design", "construction"],
      institutions: ["University of the Witwatersrand", "University of Pretoria", "University of Cape Town"]
    },
    {
      title: "Psychology",
      category: "Social Sciences",
      requiredSubjects: ["Life Sciences", "English", "History"],
      minMaths: 60,
      minScience: 65,
      employmentRate: 85,
      avgSalary: 350000,
      duration: 4,
      cost: 55000,
      description: "Study human behavior and mental processes. Diverse applications in clinical, organizational, and research settings.",
      bestFor: ["helping-people", "understanding-behavior", "communication"],
      institutions: ["University of Cape Town", "Stellenbosch University", "University of the Witwatersrand"]
    },
    {
      title: "Agricultural Science",
      category: "Environment",
      requiredSubjects: ["Agricultural Sciences", "Life Sciences", "Mathematics"],
      minMaths: 60,
      minScience: 65,
      employmentRate: 88,
      avgSalary: 380000,
      duration: 4,
      cost: 50000,
      description: "Improve agricultural productivity and sustainability. Critical field for food security and rural development.",
      bestFor: ["nature", "science", "problem-solving"],
      institutions: ["University of Pretoria", "Stellenbosch University", "University of KwaZulu-Natal"]
    },
    {
      title: "Information Systems",
      category: "Technology",
      requiredSubjects: ["Mathematics", "Information Technology", "English"],
      minMaths: 65,
      minScience: 60,
      employmentRate: 94,
      avgSalary: 450000,
      duration: 3,
      cost: 60000,
      description: "Bridge between business and technology. High demand for professionals who understand both technical and organizational needs.",
      bestFor: ["technology", "business", "problem-solving"],
      institutions: ["University of Cape Town", "University of the Witwatersrand", "Rhodes University"]
    },
    {
      title: "Architecture",
      category: "Engineering",
      requiredSubjects: ["Mathematics", "Visual Arts", "Engineering Graphics and Design"],
      minMaths: 70,
      minScience: 60,
      employmentRate: 87,
      avgSalary: 420000,
      duration: 5,
      cost: 75000,
      description: "Design buildings and structures. Creative and technical career with opportunities to shape environments.",
      bestFor: ["design", "creative", "technical"],
      institutions: ["University of the Witwatersrand", "University of Pretoria", "University of Cape Town"]
    },
    {
      title: "Marketing",
      category: "Business",
      requiredSubjects: ["Business Studies", "English", "Economics"],
      minMaths: 60,
      minScience: 0,
      employmentRate: 89,
      avgSalary: 360000,
      duration: 3,
      cost: 55000,
      description: "Promote products and services. Dynamic field combining creativity with business strategy.",
      bestFor: ["creative", "communication", "business"],
      institutions: ["University of Johannesburg", "University of Pretoria", "Stellenbosch University"]
    },
    {
      title: "Nursing",
      category: "Medicine",
      requiredSubjects: ["Life Sciences", "English", "Mathematics"],
      minMaths: 60,
      minScience: 65,
      employmentRate: 97,
      avgSalary: 320000,
      duration: 4,
      cost: 45000,
      description: "Provide healthcare and patient support. High-demand profession with opportunities for specialization.",
      bestFor: ["helping-people", "health", "science"],
      institutions: ["University of KwaZulu-Natal", "University of the Western Cape", "University of Johannesburg"]
    },
    {
      title: "Journalism",
      category: "Arts",
      requiredSubjects: ["English", "History", "Dramatic Arts"],
      minMaths: 50,
      minScience: 0,
      employmentRate: 80,
      avgSalary: 280000,
      duration: 3,
      cost: 45000,
      description: "Research and report news stories. Exciting career for those passionate about communication and current affairs.",
      bestFor: ["writing", "communication", "current-events"],
      institutions: ["Rhodes University", "University of Johannesburg", "Stellenbosch University"]
    },
    {
      title: "Actuarial Science",
      category: "Mathematics",
      requiredSubjects: ["Mathematics", "Accounting", "English"],
      minMaths: 90,
      minScience: 0,
      employmentRate: 96,
      avgSalary: 550000,
      duration: 4,
      cost: 75000,
      description: "Assess financial risks using mathematics. Highly specialized and lucrative career in insurance and finance.",
      bestFor: ["mathematics", "problem-solving", "numbers"],
      institutions: ["University of Cape Town", "University of the Witwatersrand", "Stellenbosch University"]
    }
  ];

  // Form navigation
  const form = document.getElementById('subjectSelectionForm');
  const steps = document.querySelectorAll('.form-step');
  const progressSteps = document.querySelectorAll('.progress-step');
  const nextButtons = document.querySelectorAll('.next-btn');
  const prevButtons = document.querySelectorAll('.prev-btn');
  let currentStep = 0;

  // Initialize form
  showStep(currentStep);
  initializeSubjectInputs();
  initializeInterestSelection();
  populateSubjectSelector();

  // Next button click handler
  nextButtons.forEach(button => {
    button.addEventListener('click', function() {
      if (validateStep(currentStep)) {
        currentStep++;
        showStep(currentStep);
        updateProgressBar();
        
        // Generate recommendations when reaching results step
        if (currentStep === 3) {
          generateRecommendations();
        }
      }
    });
  });

  // Previous button click handler
  prevButtons.forEach(button => {
    button.addEventListener('click', function() {
      currentStep--;
      showStep(currentStep);
      updateProgressBar();
    });
  });

  // Show current step
  function showStep(stepIndex) {
    steps.forEach((step, index) => {
      step.classList.toggle('active', index === stepIndex);
    });
  }

  // Update progress bar
  function updateProgressBar() {
    progressSteps.forEach((step, index) => {
      if (index <= currentStep) {
        step.classList.add('active');
      } else {
        step.classList.remove('active');
      }
    });
  }

  // Basic validation for each step
  function validateStep(stepIndex) {
    let isValid = true;
    
    if (stepIndex === 0) {
      // Validate academic information
      const subjectInputs = document.querySelectorAll('.subject-group input');
      let hasValidInput = false;
      
      subjectInputs.forEach(input => {
        if (input.value && !isNaN(input.value)) {
          const mark = parseInt(input.value);
          if (mark >= 0 && mark <= 100) {
            hasValidInput = true;
            input.classList.remove('error');
          } else {
            input.classList.add('error');
            isValid = false;
          }
        } else if (input.value) {
          input.classList.add('error');
          isValid = false;
        }
      });
      
      if (!hasValidInput) {
        alert('Please enter valid marks (0-100) for at least one subject');
        isValid = false;
      }
    }
    
    if (stepIndex === 1) {
      // Validate interests
      const selectedInterests = document.querySelectorAll('input[name="interests"]:checked');
      if (selectedInterests.length === 0) {
        alert('Please select at least one area of interest');
        isValid = false;
      }
    }
    
    return isValid;
  }

  // Initialize subject inputs with default subjects
  function initializeSubjectInputs() {
    const container = document.getElementById('subjectInputsContainer');
    
    // Add default subjects
    const defaultSubjects = ["Mathematics", "Physical Sciences", "Life Sciences", "English", "Additional Language"];
    defaultSubjects.forEach(subject => {
      addSubjectInput(subject);
    });
    
    // Add subject button handler
    document.getElementById('addSubjectBtn').addEventListener('click', function() {
      const selector = document.getElementById('subjectSelector');
      const selectedSubject = selector.value;
      
      if (selectedSubject && !isSubjectAlreadyAdded(selectedSubject)) {
        addSubjectInput(selectedSubject);
        selector.value = '';
      }
    });
  }
  
  // Check if subject is already added
  function isSubjectAlreadyAdded(subjectName) {
    const existingSubjects = document.querySelectorAll('.subject-group label');
    for (let i = 0; i < existingSubjects.length; i++) {
      if (existingSubjects[i].textContent === subjectName) {
        alert('This subject has already been added');
        return true;
      }
    }
    return false;
  }
  
  // Add a new subject input field
  function addSubjectInput(subjectName) {
    const container = document.getElementById('subjectInputsContainer');
    const div = document.createElement('div');
    div.className = 'subject-group';
    div.innerHTML = `
      <label>${subjectName}</label>
      <input type="number" min="0" max="100" placeholder="Enter % (0-100)" required>
      <button class="remove-subject" type="button" aria-label="Remove subject">
        <i class="fas fa-times"></i>
      </button>
    `;
    container.appendChild(div);
    
    // Add input validation
    const input = div.querySelector('input');
    input.addEventListener('input', function() {
      if (this.value && (parseInt(this.value) < 0 || parseInt(this.value) > 100)) {
        this.classList.add('error');
      } else {
        this.classList.remove('error');
      }
    });
    
    // Add remove handler
    const removeBtn = div.querySelector('.remove-subject');
    removeBtn.addEventListener('click', function() {
      div.classList.add('removing');
      setTimeout(() => {
        div.remove();
      }, 300);
    });
  }
  
  // Populate subject selector dropdown
  function populateSubjectSelector() {
    const selector = document.getElementById('subjectSelector');
    selector.innerHTML = '<option value="">Select a subject to add</option>';
    
    availableSubjects.forEach(subject => {
      const option = document.createElement('option');
      option.value = subject;
      option.textContent = subject;
      selector.appendChild(option);
    });
  }
  
  // Initialize interest selection
  function initializeInterestSelection() {
    const container = document.querySelector('.interest-grid');
    container.innerHTML = '';
    
    interestCategories.forEach(interest => {
      const div = document.createElement('div');
      div.className = 'interest-card';
      div.innerHTML = `
        <input type="checkbox" id="interest-${interest.name.toLowerCase().replace(/\s+/g, '-')}" 
               name="interests" value="${interest.name.toLowerCase().replace(/\s+/g, '-')}">
        <label for="interest-${interest.name.toLowerCase().replace(/\s+/g, '-')}">
          <i class="${interest.icon}"></i>
          <span class="interest-name">${interest.name}</span>
          <span class="interest-description">${interest.description}</span>
        </label>
      `;
      container.appendChild(div);
    });
  }
  
  // Generate career recommendations based on user input
  function generateRecommendations() {
    // Show loading state
    const resultsContainer = document.getElementById('recommendationsContainer');
    resultsContainer.innerHTML = `
      <div class="loading-results">
        <i class="fas fa-spinner fa-spin"></i>
        <p class="loading-text">Analyzing your profile and generating personalized recommendations...</p>
      </div>
    `;
    
    // Get academic marks
    const subjects = {};
    document.querySelectorAll('.subject-group').forEach(group => {
      const subjectName = group.querySelector('label').textContent;
      const mark = parseInt(group.querySelector('input').value) || 0;
      subjects[subjectName] = mark;
    });
    
    // Get interests
    const interests = [];
    document.querySelectorAll('input[name="interests"]:checked').forEach(checkbox => {
      interests.push(checkbox.value);
    });
    
    // Get preferences
    const affordability = document.querySelector('input[name="affordability"]:checked').value;
    const location = document.querySelector('input[name="location"]:checked').value;
    const learningStyle = document.querySelector('input[name="learning-style"]:checked').value;
    const careerGoal = document.querySelector('input[name="career-goal"]:checked').value;
    
    // Accessibility needs
    const accessibilityNeeds = [];
    document.querySelectorAll('input[name="accessibility"]:checked').forEach(checkbox => {
      accessibilityNeeds.push(checkbox.value);
    });
    
    // Simulate processing delay
    setTimeout(() => {
      // Score and filter careers
      const scoredCareers = careerDatabase.map(career => {
        let score = 0;
        
        // Academic match (50% of score)
        let academicMatch = 0;
        const mathsMark = subjects["Mathematics"] || 0;
        const scienceMark = Math.max(
          subjects["Physical Sciences"] || 0,
          subjects["Life Sciences"] || 0
        );
        
        // Check minimum requirements
        if (mathsMark < career.minMaths || (career.minScience > 0 && scienceMark < career.minScience)) {
          return { ...career, score: 0 }; // Doesn't meet minimums
        }
        
        // Calculate subject match
        let subjectMatch = 0;
        career.requiredSubjects.forEach(subject => {
          subjectMatch += (subjects[subject] || 50) / 100; // Default to 50 if subject not provided
        });
        subjectMatch = (subjectMatch / career.requiredSubjects.length) * 50;
        academicMatch += subjectMatch;
        
        // Bonus for high marks in key subjects
        if (mathsMark >= 80) academicMatch += 5;
        if (scienceMark >= 80) academicMatch += 5;
        
        score += academicMatch;
        
        // Interest match (30% of score)
        if (interests.includes(career.category.toLowerCase())) {
          score += 30;
        } else {
          // Check if any interest keywords match
          const interestKeywords = career.bestFor || [];
          let interestMatch = 0;
          interests.forEach(interest => {
            if (interestKeywords.includes(interest)) {
              interestMatch += 10;
            }
          });
          score += Math.min(interestMatch, 30);
        }
        
        // Preference match (20% of score)
        // Affordability
        if (affordability === "affordable" && career.cost <= 40000) score += 5;
        else if (affordability === "moderate" && career.cost > 40000 && career.cost <= 80000) score += 5;
        else if (affordability === "premium" && career.cost > 80000) score += 5;
        
        // Learning style
        if (learningStyle === "structured" && career.duration <= 3) score += 5;
        else if (learningStyle === "hands-on" && ["Engineering", "Medicine", "Art"].includes(career.category)) score += 5;
        
        // Career goals
        if (careerGoal === "quick-employment" && career.duration <= 3) score += 5;
        else if (careerGoal === "long-term-growth" && career.avgSalary >= 400000) score += 5;
        else if (careerGoal === "entrepreneurial" && ["Business", "Technology"].includes(career.category)) score += 5;
        
        // Normalize score to percentage
        score = Math.min(Math.round(score), 100);
        
        return { ...career, score };
      }).filter(career => career.score > 0) // Remove careers that don't meet minimums
        .sort((a, b) => b.score - a.score); // Sort by score descending
      
      // Display recommendations
      displayRecommendations(scoredCareers);
      
      // Update summary stats
      updateSummaryStats(scoredCareers);
      
      // Scroll to results
      document.querySelector('.form-step[data-step="4"]').scrollIntoView({
        behavior: 'smooth'
      });
    }, 2000);
  }
  
  // Display recommendations in the UI
  function displayRecommendations(recommendations) {
    const container = document.getElementById('recommendationsContainer');
    container.innerHTML = '';
    
    if (recommendations.length === 0) {
      container.innerHTML = `
        <div class="no-results">
          <i class="fas fa-search"></i>
          <h3>No perfect matches found</h3>
          <p>We couldn't find careers that match all your criteria. Try adjusting your preferences or subjects.</p>
        </div>
      `;
      return;
    }
    
    // Show top 6 recommendations (excluding best match which is shown separately)
    const topRecommendations = recommendations.slice(1, 7);
    
    topRecommendations.forEach((career, index) => {
      const card = document.createElement('div');
      card.className = 'result-card';
      card.innerHTML = `
        <div class="result-header">
          <div>
            <h3>${career.title}</h3>
            <p class="institution">${career.institutions[0]} | ${getRandomLocation()}</p>
          </div>
          <span class="match-score">${career.score}% Match</span>
        </div>
        <div class="result-details">
          <div class="result-stats">
            <div class="stat-item">
              <span class="stat-label">Employment Rate:</span>
              <span class="stat-value high">${career.employmentRate}%</span>
            </div>
            <div class="stat-item">
              <span class="stat-label">Avg Starting Salary:</span>
              <span class="stat-value">R${career.avgSalary.toLocaleString()}</span>
            </div>
            <div class="stat-item">
              <span class="stat-label">Program Duration:</span>
              <span class="stat-value">${career.duration} years</span>
            </div>
            <div class="stat-item">
              <span class="stat-label">Annual Cost:</span>
              <span class="stat-value ${getAffordabilityClass(career.cost)}">R${career.cost.toLocaleString()}</span>
            </div>
          </div>
          
          <div class="result-subjects">
            <h4>Recommended Subject Combination:</h4>
            <ul>
              ${career.requiredSubjects.map(subj => `<li>${subj} (${getMinMark(subj, career)}%+)</li>`).join('')}
            </ul>
          </div>
          
          <div class="result-description">
            <h4>Why this is a good fit:</h4>
            <p>${career.description}</p>
          </div>
          
          <div class="result-actions">
            <button class="save-btn"><i class="far fa-bookmark"></i> Save</button>
            <button class="explore-btn"><i class="fas fa-search"></i> Explore Program</button>
            <button class="compare-btn"><i class="fas fa-balance-scale"></i> Compare</button>
          </div>
        </div>
      `;
      container.appendChild(card);
      
      // Add event listeners to buttons
      card.querySelector('.save-btn').addEventListener('click', () => saveCareer(career));
      card.querySelector('.explore-btn').addEventListener('click', () => exploreCareer(career));
      card.querySelector('.compare-btn').addEventListener('click', () => compareCareer(career));
    });
    
    // Update best match
    if (recommendations.length > 0) {
      const bestMatch = recommendations[0];
      const bestMatchElement = document.querySelector('.best-match .result-details');
      
      bestMatchElement.querySelector('h3').textContent = bestMatch.title;
      bestMatchElement.querySelector('.institution').textContent = `${bestMatch.institutions[0]} | ${getRandomLocation()}`;
      bestMatchElement.querySelector('.match-score').textContent = `${bestMatch.score}% Match`;
      
      // Update stats
      bestMatchElement.querySelector('.stat-value.high').textContent = `${bestMatch.employmentRate}%`;
      bestMatchElement.querySelectorAll('.stat-value')[1].textContent = `R${bestMatch.avgSalary.toLocaleString()}`;
      bestMatchElement.querySelectorAll('.stat-value')[2].textContent = `${bestMatch.duration} years`;
      bestMatchElement.querySelectorAll('.stat-value')[3].textContent = `R${bestMatch.cost.toLocaleString()}`;
      bestMatchElement.querySelectorAll('.stat-value')[3].className = `stat-value ${getAffordabilityClass(bestMatch.cost)}`;
      
      // Update subjects
      const subjectsList = bestMatchElement.querySelector('.result-subjects ul');
      subjectsList.innerHTML = '';
      bestMatch.requiredSubjects.forEach(subject => {
        const li = document.createElement('li');
        li.textContent = `${subject} (${getMinMark(subject, bestMatch)}%+)`;
        subjectsList.appendChild(li);
      });
      
      // Update description
      bestMatchElement.querySelector('.result-description p').textContent = bestMatch.description;
      
      // Update button event listeners
      document.querySelector('.best-match .save-btn').addEventListener('click', () => saveCareer(bestMatch));
      document.querySelector('.best-match .explore-btn').addEventListener('click', () => exploreCareer(bestMatch));
      document.querySelector('.best-match .compare-btn').addEventListener('click', () => compareCareer(bestMatch));
    }
  }
  
  // Helper function to save a career
  function saveCareer(career) {
    alert(`Saved "${career.title}" to your profile!`);
    // In a real app, this would save to the server
  }
  
  // Helper function to explore a career
  function exploreCareer(career) {
    alert(`Exploring "${career.title}" program details...`);
    // In a real app, this would open a detailed view
  }
  
  // Helper function to compare a career
  function compareCareer(career) {
    alert(`Adding "${career.title}" to comparison list...`);
    // In a real app, this would add to comparison feature
  }
  
  // Helper function to get minimum mark for display
  function getMinMark(subject, career) {
    if (subject === "Mathematics") return career.minMaths;
    if (subject === "Physical Sciences" || subject === "Life Sciences") return career.minScience;
    return 60; // Default minimum
  }
  
  // Helper function to get affordability class
  function getAffordabilityClass(cost) {
    if (cost <= 40000) return 'affordable';
    if (cost <= 80000) return 'moderate';
    return 'expensive';
  }
  
  // Helper function to get random location
  function getRandomLocation() {
    const locations = ["Cape Town", "Johannesburg", "Pretoria", "Durban", "Stellenbosch", "Port Elizabeth", "Bloemfontein"];
    return locations[Math.floor(Math.random() * locations.length)];
  }
  
  // Update summary statistics
  function updateSummaryStats(recommendations) {
    if (recommendations.length === 0) return;
    
    // Academic fit (average of top 3 scores)
    const academicFit = Math.round(
      recommendations.slice(0, 3).reduce((sum, career) => sum + (career.score / 100) * 50, 0) / 3
    );
    
    // Interest alignment (average of top 3 interest portions)
    const interestAlignment = Math.round(
      recommendations.slice(0, 3).reduce((sum, career) => sum + (career.score / 100) * 30, 0) / 3
    );
    
    // Opportunity score (employment rate weighted average)
    const opportunityScore = Math.round(
      recommendations.slice(0, 3).reduce((sum, career) => sum + career.employmentRate, 0) / 3
    );
    
    // Update UI
    document.querySelectorAll('.meter-bar')[0].style.width = `${academicFit}%`;
    document.querySelectorAll('.meter-bar')[0].nextElementSibling.textContent = `${academicFit}% Match`;
    
    document.querySelectorAll('.meter-bar')[1].style.width = `${interestAlignment}%`;
    document.querySelectorAll('.meter-bar')[1].nextElementSibling.textContent = `${interestAlignment}% Match`;
    
    document.querySelectorAll('.meter-bar')[2].style.width = `${opportunityScore}%`;
    document.querySelectorAll('.meter-bar')[2].nextElementSibling.textContent = `${opportunityScore}% Match`;
  }
  
  // Add event listeners for filters
  document.getElementById('career-filter').addEventListener('change', function() {
    // In a real implementation, this would filter the displayed recommendations
    console.log('Filter by:', this.value);
  });
  
  document.getElementById('career-sort').addEventListener('change', function() {
    // In a real implementation, this would sort the displayed recommendations
    console.log('Sort by:', this.value);
  });
  
  // Save all button handler
  document.querySelector('.save-all-btn').addEventListener('click', function() {
    alert('All recommendations have been saved to your profile!');
    // In a real app, this would save to the server
  });
  
  // Add animation to progress bar when loading recommendations
  const recommendationButton = document.querySelector('[data-step="3"] .next-btn');
  if (recommendationButton) {
    recommendationButton.addEventListener('click', function() {
      this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Analyzing your profile...';
      setTimeout(() => {
        this.innerHTML = 'Get Recommendations <i class="fas fa-chart-line"></i>';
      }, 1500);
    });
  }
});
// guideian.js - Main functionality for all pages

// ======================
// 1. Core Utilities
// ======================
const utils = {
  showAlert: (message, type = 'success') => {
    const alertDiv = document.createElement('div');
    alertDiv.className = `fixed top-4 right-4 px-6 py-4 rounded-md shadow-lg z-50 ${
      type === 'error' ? 'bg-red-100 text-red-800' : 'bg-green-100 text-green-800'
    }`;
    alertDiv.textContent = message;
    document.body.appendChild(alertDiv);
    
    setTimeout(() => alertDiv.remove(), 5000);
  },

  validateEmail: (email) => {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  },

  setLoading: (form, isLoading) => {
    const button = form.querySelector('button[type="submit"]');
    if (!button) return;

    if (isLoading) {
      button.disabled = true;
      button.innerHTML = `
        <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white inline-block" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
          <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
        </svg>
        Processing...
      `;
    } else {
      button.disabled = false;
      button.textContent = button.dataset.originalText || 'Submit';
    }
  }
};

// ======================
// 2. Navigation & Auth
// ======================
function initNavigation() {
  // Highlight current page
  const currentPage = location.pathname.split('/').pop();
  document.querySelectorAll('.nav-link').forEach(link => {
    if (link.getAttribute('href') === currentPage) {
      link.classList.add('text-indigo-600', 'font-medium');
      link.classList.remove('text-gray-700');
    }
  });

  // Auth state
  const isLoggedIn = localStorage.getItem('isLoggedIn') === 'true';
  document.querySelectorAll('.auth-state').forEach(el => {
    el.style.display = isLoggedIn ? 'none' : 'block';
  });
  document.querySelectorAll('.user-menu').forEach(el => {
    el.style.display = isLoggedIn ? 'block' : 'none';
  });
}

// ======================
// 3. Theme Toggler
// ======================
function initThemeToggler() {
  const toggle = document.getElementById('theme-toggle');
  if (!toggle) return;

  const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
  const savedTheme = localStorage.getItem('theme') || (prefersDark ? 'dark' : 'light');
  
  document.documentElement.classList.toggle('dark', savedTheme === 'dark');
  toggle.checked = savedTheme === 'dark';

  toggle.addEventListener('change', (e) => {
    const theme = e.target.checked ? 'dark' : 'light';
    document.documentElement.classList.toggle('dark', e.target.checked);
    localStorage.setItem('theme', theme);
  });
}

// ======================
// 4. Contact Form
// ======================
function initContactForm() {
  const form = document.getElementById('contact-form');
  if (!form) return;

  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    utils.setLoading(form, true);

    const formData = new FormData(form);
    const data = Object.fromEntries(formData);

    // Simple validation
    if (!data.name || !data.email || !data.message) {
      utils.showAlert('Please fill in all fields', 'error');
      utils.setLoading(form, false);
      return;
    }

    if (!utils.validateEmail(data.email)) {
      utils.showAlert('Please enter a valid email', 'error');
      utils.setLoading(form, false);
      return;
    }

    // Simulate API call
    setTimeout(() => {
      utils.showAlert('Message sent successfully!');
      form.reset();
      utils.setLoading(form, false);
    }, 1500);
  });
}

// ======================
// 5. Dashboard Tabs
// ======================
function initDashboardTabs() {
  const tabs = document.querySelectorAll('.tab-pane');
  if (!tabs.length) return;

  function showTab(tabName) {
    tabs.forEach(tab => tab.classList.toggle('active', tab.id === `${tabName}-tab`));
    localStorage.setItem('activeTab', tabName);
  }

  // Initialize from localStorage or default
  showTab(localStorage.getItem('activeTab') || 'profile');

  // Tab click handlers
  document.querySelectorAll('[data-tab]').forEach(btn => {
    btn.addEventListener('click', () => showTab(btn.dataset.tab));
  });
}

// ======================
// 6. Service Filtering
// ======================
function initServiceFilter() {
  const filterButtons = document.querySelectorAll('.service-filter-btn');
  if (!filterButtons.length) return;

  filterButtons.forEach(btn => {
    btn.addEventListener('click', function() {
      const filter = this.dataset.filter || 'all';
      
      // Update active button
      filterButtons.forEach(b => b.classList.toggle('active', b === this));
      
      // Filter cards
      document.querySelectorAll('.service-card').forEach(card => {
        card.style.display = (filter === 'all' || card.dataset.category === filter) 
          ? 'block' 
          : 'none';
      });
    });
  });
}

// ======================
// 7. Testimonials Carousel
// ======================
function initTestimonials() {
  const testimonials = document.querySelectorAll('.testimonial');
  if (!testimonials.length) return;

  let currentIndex = 0;
  const dots = document.querySelectorAll('.testimonial-dot');
  let interval;

  function showTestimonial(index) {
    testimonials.forEach((t, i) => t.classList.toggle('active', i === index));
    dots.forEach((d, i) => d.classList.toggle('active', i === index));
    currentIndex = index;
  }

  function nextTestimonial() {
    currentIndex = (currentIndex + 1) % testimonials.length;
    showTestimonial(currentIndex);
  }

  // Manual controls
  dots.forEach((dot, i) => {
    dot.addEventListener('click', () => {
      showTestimonial(i);
      resetInterval();
    });
  });

  // Auto-rotate
  function startInterval() {
    interval = setInterval(nextTestimonial, 5000);
  }

  function resetInterval() {
    clearInterval(interval);
    startInterval();
  }

  // Initialize
  showTestimonial(0);
  startInterval();

  // Pause on hover
  const container = document.querySelector('.testimonials-container');
  if (container) {
    container.addEventListener('mouseenter', () => clearInterval(interval));
    container.addEventListener('mouseleave', startInterval);
  }
}

// ======================
// Initialize Everything
// ======================
document.addEventListener('DOMContentLoaded', () => {
  initNavigation();
  initThemeToggler();
  initContactForm();
  initDashboardTabs();
  initServiceFilter();
  initTestimonials();
});
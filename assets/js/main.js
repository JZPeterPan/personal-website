(function(){
  const root = document.documentElement;
  const themeToggle = document.getElementById('themeToggle');
  const navToggle = document.getElementById('navToggle');
  const navList = document.getElementById('navList');
  const researchTabs = document.querySelectorAll('.research-tab');
  const researchList = document.getElementById('researchList');

  // Theme init from prefers + localStorage
  const storedTheme = localStorage.getItem('theme');
  const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
  const initial = storedTheme || (prefersDark ? 'dark' : 'light');
  root.setAttribute('data-theme', initial);

  function setTheme(theme){
    root.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);
  }

  themeToggle?.addEventListener('click', () => {
    const current = root.getAttribute('data-theme') || 'light';
    setTheme(current === 'light' ? 'dark' : 'light');
  });

  // Mobile nav
  navToggle?.addEventListener('click', () => {
    const isOpen = navList?.classList.toggle('open');
    navToggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
  });
  // Close nav when clicking a link (mobile)
  navList?.addEventListener('click', (e) => {
    if(e.target instanceof HTMLAnchorElement){
      navList.classList.remove('open');
      navToggle?.setAttribute('aria-expanded', 'false');
    }
  });

  // Smooth scroll offset for sticky header
  function offsetAnchorScroll(){
    if(location.hash.length > 1){
      const el = document.getElementById(location.hash.slice(1));
      if(el){
        const y = el.getBoundingClientRect().top + window.scrollY - 70;
        window.scrollTo({top: y, behavior: 'smooth'});
      }
    }
  }
  if(window.location.hash){
    setTimeout(offsetAnchorScroll, 0);
  }

  // Set copyright year
  const yearEl = document.getElementById('year');
  if(yearEl){ yearEl.textContent = new Date().getFullYear(); }

  // Research filters
  function applyResearchFilter(topic){
    console.log('applyResearchFilter called with topic:', topic);
    if(!researchList) {
      console.log('researchList not found');
      return;
    }
    const items = researchList.querySelectorAll('.pub-item');
    console.log('Found', items.length, 'publication items');
    items.forEach((item, index) => {
      const topicsAttr = item.getAttribute('data-topics') || '';
      const topics = topicsAttr.split(',').map(s => s.trim()).filter(Boolean);
      const match = topics.includes(topic);
      console.log(`Item ${index}: topics="${topicsAttr}", parsed=${topics}, match=${match}`);
      if (match) {
        item.style.display = '';
        item.removeAttribute('data-hidden');
      } else {
        item.style.display = 'none';
        item.setAttribute('data-hidden', 'true');
      }
    });
  }

  researchTabs.forEach(tab => {
    tab.addEventListener('click', (e) => {
      e.preventDefault();
      console.log('Tab clicked:', tab.textContent);
      researchTabs.forEach(t => t.classList.remove('is-active'));
      tab.classList.add('is-active');
      const topic = tab.getAttribute('data-topic') || 'all';
      console.log('Filtering by topic:', topic);
      applyResearchFilter(topic);
    });
  });

  // initialize filter on load
  console.log('Initializing research filter...');
  console.log('Found', researchTabs.length, 'research tabs');
  if(researchTabs.length){
    const active = document.querySelector('.research-tab.is-active');
    const initialTopic = active ? active.getAttribute('data-topic') : 'all';
    console.log('Initial topic:', initialTopic);
    applyResearchFilter(initialTopic);
  }

  // Active navigation highlighting based on scroll position
  function updateActiveNav() {
    const sections = document.querySelectorAll('section[id]');
    const navLinks = document.querySelectorAll('.nav-link');
    const scrollPos = window.scrollY + 100; // Offset for header

    sections.forEach(section => {
      const sectionTop = section.offsetTop;
      const sectionHeight = section.offsetHeight;
      const sectionId = section.getAttribute('id');
      
      if (scrollPos >= sectionTop && scrollPos < sectionTop + sectionHeight) {
        // Remove active class from all nav links
        navLinks.forEach(link => link.classList.remove('active'));
        
        // Add active class to corresponding nav link
        const activeLink = document.querySelector(`.nav-link[href="#${sectionId}"]`);
        if (activeLink) {
          activeLink.classList.add('active');
        }
      }
    });
  }

  // Update active nav on scroll
  window.addEventListener('scroll', updateActiveNav);
  
  // Initialize active nav on page load
  updateActiveNav();

  // Make team-item cards clickable via data-url while preserving layout
  const teamCards = document.querySelectorAll('.team-item[data-url]');
  teamCards.forEach(card => {
    const url = card.getAttribute('data-url');
    if(!url) return;
    card.setAttribute('role', 'link');
    card.setAttribute('tabindex', '0');
    const open = () => window.open(url, '_blank', 'noopener');
    card.addEventListener('click', (e) => {
      // Avoid double-activations if inner links are clicked
      const target = e.target;
      if(target instanceof HTMLElement && target.closest('a')) return;
      open();
    });
    card.addEventListener('keydown', (e) => {
      if(e.key === 'Enter' || e.key === ' '){
        e.preventDefault();
        open();
      }
    });
  });
})();

document.addEventListener('DOMContentLoaded', () => {
    // 1. Navigation Highlighting on Scroll
    const sections = document.querySelectorAll('section');
    const navLinks = document.querySelectorAll('.nav-link');

    window.addEventListener('scroll', () => {
        let current = '';
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            // Adjust offset to trigger slightly before the section reaches top
            if (scrollY >= (sectionTop - sectionHeight / 3)) {
                current = section.getAttribute('id');
            }
        });

        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href').includes(current)) {
                link.classList.add('active');
            }
        });
    });

    // 2. Toggle Contact Form
    const toggleFormBtn = document.getElementById('toggle-form-btn');
    const contactFormContainer = document.getElementById('contact-form-container');
    const toggleBtnIcon = toggleFormBtn.querySelector('i');
    const toggleBtnText = toggleFormBtn.querySelector('span');
    let isFormVisible = false;

    toggleFormBtn.addEventListener('click', () => {
        isFormVisible = !isFormVisible;
        if (isFormVisible) {
            contactFormContainer.classList.remove('hidden');
            toggleBtnText.textContent = 'Close Form';
            toggleBtnIcon.classList.remove('ri-send-plane-fill');
            toggleBtnIcon.classList.add('ri-close-fill');
        } else {
            contactFormContainer.classList.add('hidden');
            toggleBtnText.textContent = 'Send Message';
            toggleBtnIcon.classList.remove('ri-close-fill');
            toggleBtnIcon.classList.add('ri-send-plane-fill');
        }
    });

    // 3. EmailJS Initialization and Form Submission
    // Initialize EmailJS with the public key
    emailjs.init("0nkmvYpNGGV5dgNJv");

    const contactForm = document.getElementById('contact-form');
    const submitBtn = document.getElementById('submit-btn');
    const formStatus = document.getElementById('form-status');

    contactForm.addEventListener('submit', function(event) {
        event.preventDefault();

        // Basic HTML5 validation ensures fields are filled
        const userName = document.getElementById('user_name').value.trim();
        const userEmail = document.getElementById('user_email').value.trim();
        const message = document.getElementById('message').value.trim();

        if (!userName || !userEmail || !message) {
            showStatus('Please fill in all fields.', 'error');
            return;
        }

        // Disable button and show loading state
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<i class="ri-loader-4-line ri-spin"></i> Sending...';
        formStatus.textContent = '';

        // Prepare template parameters
        const templateParams = {
            from_name: userName,
            from_email: userEmail,
            message: message,
            to_name: 'Lewis Bundi',
            reply_to: userEmail
        };

        // Send email using EmailJS
        emailjs.send('service_gih5brd', 'template_w4jg7ps', templateParams)
            .then(function() {
                // Success
                showStatus('Message sent successfully! I\'ll get back to you soon.', 'success');
                contactForm.reset();
                
                // Auto hide form after success
                setTimeout(() => {
                    contactFormContainer.classList.add('hidden');
                    isFormVisible = false;
                    toggleBtnText.textContent = 'Send Message';
                    toggleBtnIcon.classList.remove('ri-close-fill');
                    toggleBtnIcon.classList.add('ri-send-plane-fill');
                    formStatus.textContent = '';
                }, 3000);
            }, function(error) {
                // Error
                console.error("EmailJS Error:", error);
                showStatus('Failed to send message. Please try again or contact me directly.', 'error');
            })
            .finally(function() {
                // Restore button state
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="ri-send-plane-fill"></i> Send Message';
            });
    });

    function showStatus(message, type) {
        formStatus.textContent = message;
        formStatus.className = 'form-status'; // Reset classes
        if (type === 'success') {
            formStatus.classList.add('status-success');
        } else if (type === 'error') {
            formStatus.classList.add('status-error');
        }
    }

    // 4. Prismic Blog Integration
    const prismicUrl = 'https://lewis-bundi.cdn.prismic.io/api/v2';
    const blogGrid = document.getElementById('blog-grid');
    const blogLoading = document.getElementById('blog-loading');
    const blogModal = document.getElementById('blog-modal');
    const closeModal = document.getElementById('close-modal');
    const modalBodyContent = document.getElementById('modal-body-content');

    let allPosts = [];

    async function initBlog() {
        if (!blogGrid || !blogLoading) return;
        
        try {
            // 1. Fetch Repository Master Ref
            const repoResponse = await fetch(prismicUrl);
            const repoData = await repoResponse.json();
            const masterRef = repoData.refs.find(r => r.id === 'master').ref;

            // 2. Query Documents
            const docsResponse = await fetch(`${prismicUrl}/documents/search?ref=${masterRef}`);
            const docsData = await docsResponse.json();
            
            allPosts = docsData.results || [];
            
            // Sort by published date (newest first)
            allPosts.sort((a, b) => {
                const dateA = new Date(a.data?.published_date || a.first_publication_date || a.last_publication_date || 0);
                const dateB = new Date(b.data?.published_date || b.first_publication_date || b.last_publication_date || 0);
                return dateB - dateA;
            });
            
            blogLoading.style.display = 'none';
            blogGrid.style.display = 'grid';

            if (allPosts.length === 0) {
                blogGrid.innerHTML = '<p style="color: var(--color-secondary); grid-column: 1 / -1; text-align: center;">No blog posts available yet. Check back soon!</p>';
                return;
            }

            renderBlogCards();

        } catch (error) {
            console.error('Error fetching Prismic CMS:', error);
            blogLoading.textContent = 'Unable to load blog posts at this time.';
        }
    }

    function renderBlogCards() {
        blogGrid.innerHTML = '';
        allPosts.forEach((post, index) => {
            const data = post.data;
            const titleStr = data.title ? getRichTextString(data.title) : 'Untitled Post';
            const dateStr = data.published_date || post.first_publication_date || post.last_publication_date;
            const date = new Date(dateStr).toLocaleDateString(undefined, { year: 'numeric', month: 'long', day: 'numeric' });

            const card = document.createElement('div');
            card.className = 'project-card'; // Reuse layout styles
            
            // Build simple excerpt from summary or body
            let excerpt = getRichTextString(data.summary || []);
            if (!excerpt && data.body) {
                excerpt = getRichTextString(data.body);
            }
            if (excerpt.length > 150) {
                excerpt = excerpt.slice(0, 150) + '...';
            }
            if (!excerpt) excerpt = 'Click to read this article...';

            card.innerHTML = `
                <div class="project-content">
                    <div class="project-header">
                        <h3 class="project-title" style="margin-bottom: 0.5rem;">${titleStr}</h3>
                    </div>
                    <span class="blog-meta"><i class="ri-calendar-line"></i> ${date}</span>
                    <p class="project-desc" style="margin-top: 0.5rem;">${excerpt}</p>
                    <div class="tech-stack" style="margin-top: auto; padding-top: 1rem;">
                        <button class="btn btn-outline read-more-btn" data-index="${index}" style="padding: 0.5rem 1rem; width: 100%; border-radius: 6px;">Read Article <i class="ri-arrow-right-line" style="pointer-events:none;"></i></button>
                    </div>
                </div>
            `;
            blogGrid.appendChild(card);
        });

        // Event listeners for opening modal
        document.querySelectorAll('.read-more-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const index = e.target.getAttribute('data-index');
                if (index !== null) {
                    openModal(allPosts[index]);
                }
            });
        });
    }

    function openModal(post) {
        if (!blogModal || !modalBodyContent) return;
        
        const data = post.data;
        const title = data.title ? getRichTextString(data.title) : 'Untitled Post';
        const bodyContent = data.body ? renderRichText(data.body) : '<p>No content available for this post.</p>';
        const dateStr = data.published_date || post.first_publication_date || post.last_publication_date;
        const date = new Date(dateStr).toLocaleDateString(undefined, { year: 'numeric', month: 'long', day: 'numeric' });

        modalBodyContent.innerHTML = `
            <h2>${title}</h2>
            <span class="blog-meta" style="margin-bottom: 1.5rem;"><i class="ri-calendar-line"></i> Published on ${date}</span>
            <hr style="border: 0; border-top: 1px dashed rgba(0,255,0,0.3); margin-bottom: 1.5rem;">
            ${bodyContent}
        `;
        
        blogModal.classList.remove('hidden');
        document.body.style.overflow = 'hidden'; // Prevent background page scrolling
    }

    // Modal Close logic
    if (closeModal && blogModal) {
        closeModal.addEventListener('click', () => {
            blogModal.classList.add('hidden');
            document.body.style.overflow = 'auto'; // Restore scrolling
        });

        blogModal.addEventListener('click', (e) => {
            if (e.target === blogModal) {
                blogModal.classList.add('hidden');
                document.body.style.overflow = 'auto';
            }
        });
    }

    // Helper functions for parsing Prismic JSON into basic HTML
    function getRichTextString(richTextArray) {
        if (typeof richTextArray === 'string') return richTextArray;
        if (!Array.isArray(richTextArray)) return '';
        return richTextArray.map(b => b.text || '').join(' ').trim();
    }

    function renderRichText(richTextArray) {
        if (!Array.isArray(richTextArray)) return typeof richTextArray === 'string' ? richTextArray : '';
        let html = '';
        let inList = false;
        let inOList = false;
    
        richTextArray.forEach(block => {
            // Close open lists if current block is not a list item
            if (block.type !== 'list-item' && inList) { html += '</ul>'; inList = false; }
            if (block.type !== 'o-list-item' && inOList) { html += '</ol>'; inOList = false; }

            switch (block.type) {
                case 'list-item':
                    if (!inList) { html += '<ul>'; inList = true; }
                    html += `<li>${block.text}</li>`;
                    break;
                case 'o-list-item':
                    if (!inOList) { html += '<ol>'; inOList = true; }
                    html += `<li>${block.text}</li>`;
                    break;
                case 'image':
                    html += `<img src="${block.url}" alt="${block.alt || ''}">`;
                    break;
                case 'paragraph':
                    // Render paragraphs or simple text
                    html += `<p>${block.text || '&nbsp;'}</p>`;
                    break;
                case 'preformatted':
                    html += `<pre style="background:rgba(0,0,0,0.5); padding:1rem; border-radius:6px; overflow-x:auto;"><code>${block.text}</code></pre>`;
                    break;
                default:
                    // If it's a heading (heading1, heading2, etc.)
                    if (block.type.startsWith('heading')) {
                        const level = block.type.replace('heading', '');
                        html += `<h${level}>${block.text}</h${level}>`;
                    } else {
                        html += `<p>${block.text}</p>`;
                    }
                    break;
            }
        });
        
        // Clean up unclosed lists
        if (inList) html += '</ul>';
        if (inOList) html += '</ol>';
        
        return html;
    }

    // Init the blog
    initBlog();
});

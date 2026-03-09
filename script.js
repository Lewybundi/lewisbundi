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
});

/**
 * PIONA Studio - Wersja V6 (Ostateczna Fuzja)
 * Skrypt interaktywny
 */

document.addEventListener('DOMContentLoaded', () => {

    /* ==========================================================================
       1. CUSTOM CURSOR
       ========================================================================== */
    const cursor = document.getElementById('cursor');
    const cursorDot = document.getElementById('cursorDot');

    // Tylko dla non-touch urządzeń
    if (window.matchMedia("(pointer: fine)").matches) {
        document.addEventListener('mousemove', (e) => {
            cursor.style.transform = `translate(${e.clientX}px, ${e.clientY}px)`;
            cursorDot.style.transform = `translate(${e.clientX}px, ${e.clientY}px)`;
        });

        const hoverElements = document.querySelectorAll('a, button, .magnetic, .hover-cursor, .hover-glow-effect');
        hoverElements.forEach(el => {
            el.addEventListener('mouseenter', () => cursor.classList.add('expand'));
            el.addEventListener('mouseleave', () => cursor.classList.remove('expand'));
        });
    } else {
        if (cursor) cursor.style.display = 'none';
        if (cursorDot) cursorDot.style.display = 'none';
    }

    /* ==========================================================================
       2. MAGNETIC BUTTONS
       ========================================================================== */
    const magnetics = document.querySelectorAll('.magnetic');
    magnetics.forEach(btn => {
        btn.addEventListener('mousemove', (e) => {
            const rect = btn.getBoundingClientRect();
            const x = e.clientX - rect.left - rect.width / 2;
            const y = e.clientY - rect.top - rect.height / 2;

            // Delikatny efekt siły przyciągania
            btn.style.transform = `translate(${x * 0.2}px, ${y * 0.2}px)`;
        });

        btn.addEventListener('mouseleave', () => {
            btn.style.transform = 'translate(0px, 0px)';
        });
    });

    /* ==========================================================================
       3. NAVIGATION (STICKY & MOBILE)
       ========================================================================== */
    const nav = document.getElementById('nav');
    const burger = document.getElementById('navBurger');
    const mobileMenu = document.getElementById('mobileMenu');
    let lastScroll = 0;

    window.addEventListener('scroll', () => {
        const currentScroll = window.pageYOffset;

        // Sticky glassmorphism dodający się po pewnym scroling
        if (currentScroll > 50) {
            nav.classList.add('scrolled');
        } else {
            nav.classList.remove('scrolled');
        }

        // Ukrywanie na scroll down (jeśli nie jesteśmy na czubku)
        if (currentScroll > lastScroll && currentScroll > 200) {
            nav.style.transform = 'translateY(-100%)';
        } else {
            nav.style.transform = 'translateY(0)';
        }
        lastScroll = currentScroll;
    });

    // Mobile Menu Toggle
    burger.addEventListener('click', () => {
        burger.classList.toggle('active');
        mobileMenu.classList.toggle('active');

        // Cross Animation
        const spans = burger.querySelectorAll('span');
        if (burger.classList.contains('active')) {
            spans[0].style.transform = 'rotate(45deg) translate(5px, 5px)';
            spans[1].style.opacity = '0';
            spans[2].style.transform = 'rotate(-45deg) translate(6px, -6px)';
        } else {
            spans[0].style.transform = 'none';
            spans[1].style.opacity = '1';
            spans[2].style.transform = 'none';
        }
    });

    // Zamykanie moblinego z linków
    document.querySelectorAll('.mobile-menu__link').forEach(link => {
        link.addEventListener('click', () => {
            burger.click();
        });
    });

    /* ==========================================================================
       4. SCROLL REVEAL (INTERSECTION OBSERVER)
       ========================================================================== */
    const revealElements = document.querySelectorAll('.reveal-el');
    const revealOptions = {
        threshold: 0.1,
        rootMargin: "0px 0px -50px 0px"
    };

    const revealObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                // Jeśli element ma ustawione --i delay
                const delayStr = entry.target.style.getPropertyValue('--i');
                if (delayStr) {
                    setTimeout(() => {
                        entry.target.classList.add('active');
                    }, parseInt(delayStr) * 100);
                } else {
                    entry.target.classList.add('active');
                }
                observer.unobserve(entry.target);
            }
        });
    }, revealOptions);

    revealElements.forEach(el => revealObserver.observe(el));

    /* ==========================================================================
       5. CLIENTS TICKER (INFINITE CLONE)
       ========================================================================== */
    const tickerTrack = document.querySelector('.clients__track');
    if (tickerTrack) {
        // Obliczenie animacji (css nie może ogarnąć w 100% płynnie bez znania szerzości)
        // Zrobmy prostą animację CSS transform zamiast złożonego JS tu.
        // Dodałem logikę CSS w html na sztywno, dodamy klatki do CSS na żywo.

        const style = document.createElement('style');
        style.textContent = `
            .clients__track {
                display: flex;
                width: max-content;
                animation: scrollTicker 40s linear infinite;
            }
            .clients__track:hover {
                animation-play-state: paused;
            }
            @keyframes scrollTicker {
                0% { transform: translateX(0); }
                100% { transform: translateX(-50%); }
            }
        `;
        document.head.appendChild(style);
    }

    // Tab filtering (Newsroom)
    const filters = document.querySelectorAll('.newsroom__filter');
    const newsCards = document.querySelectorAll('.news-card');

    filters.forEach(filter => {
        filter.addEventListener('click', () => {
            // Remove active class
            filters.forEach(f => f.classList.remove('newsroom__filter--active'));
            filter.classList.add('newsroom__filter--active');

            const category = filter.dataset.filter;

            newsCards.forEach(card => {
                if (category === 'all' || card.dataset.category === category) {
                    card.style.display = 'flex';
                    // Trigger reflow for animation
                    void card.offsetWidth;
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                } else {
                    card.style.display = 'none';
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(20px)';
                }
            });
        });
    });

});

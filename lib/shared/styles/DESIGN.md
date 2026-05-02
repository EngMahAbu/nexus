---
name: Vibrant Connection
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#5c4037'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#907065'
  outline-variant: '#e5beb2'
  surface-tint: '#ac3500'
  primary: '#a83300'
  on-primary: '#ffffff'
  primary-container: '#d24200'
  on-primary-container: '#fffbff'
  inverse-primary: '#ffb59d'
  secondary: '#565e74'
  on-secondary: '#ffffff'
  secondary-container: '#dae2fd'
  on-secondary-container: '#5c647a'
  tertiary: '#595c5e'
  on-tertiary: '#ffffff'
  tertiary-container: '#727577'
  on-tertiary-container: '#fbfdff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdbd0'
  primary-fixed-dim: '#ffb59d'
  on-primary-fixed: '#390c00'
  on-primary-fixed-variant: '#832600'
  secondary-fixed: '#dae2fd'
  secondary-fixed-dim: '#bec6e0'
  on-secondary-fixed: '#131b2e'
  on-secondary-fixed-variant: '#3f465c'
  tertiary-fixed: '#e0e3e5'
  tertiary-fixed-dim: '#c4c7c9'
  on-tertiary-fixed: '#191c1e'
  on-tertiary-fixed-variant: '#444749'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  h1:
    fontFamily: Plus Jakarta Sans
    fontSize: 40px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  h2:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  h3:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: '1.3'
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
    letterSpacing: '0'
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
    letterSpacing: '0'
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: '1.4'
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '500'
    lineHeight: '1.4'
    letterSpacing: 0.02em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  gutter: 16px
  margin: 24px
---
--- fsdf ---

## Brand & Style

The design system for Social Nexus is built on the pillars of energy, professionalism, and clarity. It targets a modern audience that values high-speed networking and meaningful digital interaction without the clutter of traditional social platforms. 

The style adopts a **Modern Corporate** aesthetic with a distinctive twist: it pairs the high-utility of a professional tool with the vibrant warmth of a social space. The interface utilizes generous whitespace and a restricted color palette to keep the focus on user-generated content and connections. The overall emotional response is intended to be optimistic yet grounded—a place where "work" and "social" find a polished equilibrium.

## Colors

The palette is anchored by a vibrant, deep orange (Vivid Vermilion) used strategically for primary actions, notifications, and brand identifiers. This is balanced against a sophisticated Slate Navy for text and structural elements to maintain a professional edge.

- **Primary:** Used for the main Call-to-Action (CTA), active states, and brand highlights.
- **Secondary:** Employed for headlines and high-emphasis icons to provide grounding contrast.
- **Backgrounds:** A tiered system of cool greys and whites ensures a light, airy feel. 
- **Accents:** Semantic colors (Success, Warning, Error) should follow standard conventions but are desaturated slightly to avoid clashing with the primary orange.

## Typography

This design system exclusively utilizes **Plus Jakarta Sans** to take advantage of its modern, clean, and highly legible geometric forms. Its contemporary feel provides a more sophisticated and airy aesthetic compared to traditional sans-serifs.

- **Headlines:** Use Bold or Semi-Bold weights with tight letter-spacing to create a strong visual impact.
- **Body Text:** Use Regular weight for high readability. The line height is set at 1.6 to ensure a comfortable reading rhythm during long browsing sessions.
- **Interactive Labels:** Use Medium or Semi-Bold weights at smaller sizes to ensure they remain legible even when used within dense UI components.

## Layout & Spacing

This design system employs an **8px grid** for consistent spacing and alignment. The layout philosophy is built on a **Fluid Grid** model for mobile views and a **Max-Width Centered Grid** (1280px) for desktop to ensure content remains readable and professional.

- **Margins:** Standard page margins are set to 24px (xl) to give content room to breathe.
- **Gutters:** 16px (md) gutters separate content cards and feed items.
- **Padding:** Internal component padding should follow the 8px scale, typically using 12px or 16px for vertical and horizontal balance.

## Elevation & Depth

To achieve a "polished" feel, the system uses **Ambient Shadows** and a **Tonal Layering** approach rather than heavy borders.

- **Level 1 (Base):** Content cards use a very soft, diffused shadow (0px 4px 20px rgba(0, 0, 0, 0.05)) to lift them slightly from the light-grey background.
- **Level 2 (Hover/Active):** Elements increase shadow spread and slightly decrease opacity to simulate a physical "lift."
- **Level 3 (Modals/Overlays):** High-diffusion shadows with a subtle blue tint in the dark values to maintain color harmony with the Slate Navy text.
- **Interactions:** Use subtle 1px inner borders on input fields and buttons to define edges without adding visual weight.

## Shapes

The shape language is defined by a consistent **8px corner radius** (Level 2: Rounded). 

- **Buttons & Inputs:** Use the base 8px radius for a friendly but firm professional look.
- **Cards:** Use 12px or 16px (rounded-lg/xl) for larger containers like feed posts or profile headers to create a softer, more inviting container for media.
- **Avatars:** Should be fully circular (Pill) to contrast against the structured grid and highlight the "human" element of the social network.

## Components

- **Buttons:** Primary buttons use the brand orange with white text. Secondary buttons use a light-grey ghost style with the secondary navy text.
- **Input Fields:** Use a subtle 1px border (#E2E8F0) and 8px radius. On focus, the border transitions to the brand orange with a 2px soft outer glow.
- **Cards:** White background, 16px internal padding, and 12px corner radius. Headlines within cards use the secondary color for maximum legibility.
- **Chips/Tags:** Small 8px radius or pill-shape with a desaturated version of the primary color (light orange background, dark orange text) for categorizing posts.
- **Feed Items:** Incorporate a "Like" button that uses a micro-transition from the neutral grey to the vibrant brand orange when toggled.
- **Navigation:** A clean top-bar or side-bar with active states indicated by a thick 3px vertical or horizontal line in the brand orange.
---
name: oa-ui-design
description: OpenAllIn /oa-ui-design 命令 — 专业 UI/UX 设计智能系统
---

# /oa-ui-design — UI/UX Design Intelligence

> AI-powered design system generation with 161 industry rules, 67 styles, and professional recommendations.

## Purpose

Generate complete, professional design systems for any project type. Provides intelligent recommendations for patterns, styles, colors, typography, and effects based on industry best practices.

## When to Use

- When starting a new UI/UX project
- When creating landing pages, dashboards, or mobile apps
- When needing design system recommendations
- When user asks: "设计 UI", "design landing page", "配色方案", "设计系统"
- Integration points: after `/oa-brainstorming`, before `/oa-execute`

## Workflow

```mermaid
graph TD
    A[Start Design] --> B[Analyze Project Type]
    B --> C[Match Industry Rules]
    C --> D[Select UI Pattern]
    D --> E[Choose UI Style]
    E --> F[Generate Color Palette]
    F --> G[Select Typography]
    G --> H[Define Key Effects]
    H --> I[List Anti-patterns]
    I --> J[Generate Checklist]
    J --> K[Output Design System]
```

## Design System Output

```markdown
+----------------------------------------------------------------------------------------+
|  TARGET: [Project Name] - RECOMMENDED DESIGN SYSTEM                                    |
+----------------------------------------------------------------------------------------+

|  PATTERN: [Landing Page Pattern]
|     Conversion: [Strategy]
|     CTA: [Position and style]
|     Sections: [Recommended structure]

|  STYLE: [UI Style Name]
|     Keywords: [Visual characteristics]
|     Best For: [Industry/use case]
|     Performance: [Rating] | Accessibility: [WCAG level]

|  COLORS:
|     Primary:    #XXXXXX ([Name])
|     Secondary:  #XXXXXX ([Name])
|     CTA:        #XXXXXX ([Name])
|     Background: #XXXXXX ([Name])
|     Text:       #XXXXXX ([Name])

|  TYPOGRAPHY: [Primary Font] / [Secondary Font]
|     Mood: [Typography mood]
|     Best For: [Industry]
|     Google Fonts: [URL]

|  KEY EFFECTS:
|     [Animation/interaction recommendations]

|  AVOID (Anti-patterns):
|     [What NOT to do]

|  PRE-DELIVERY CHECKLIST:
|     [ ] No emojis as icons (use SVG)
|     [ ] cursor-pointer on all clickable elements
|     [ ] Hover states with smooth transitions
|     [ ] Light mode: text contrast 4.5:1 minimum
|     [ ] Focus states visible for keyboard nav
|     [ ] prefers-reduced-motion respected
|     [ ] Responsive: 375px, 768px, 1024px, 1440px

+----------------------------------------------------------------------------------------+
```

## Industry Categories (161 Rules)

### Tech & SaaS
- SaaS, Micro SaaS, B2B Service
- Developer Tool / IDE, AI/Chatbot Platform
- Cybersecurity Platform, DevOps Tool

### Finance
- Fintech/Crypto, Banking, Insurance
- Personal Finance Tracker, Invoice & Billing Tool

### Healthcare
- Medical Clinic, Pharmacy, Dental, Veterinary
- Mental Health, Medication Reminder

### E-commerce
- General, Luxury, Marketplace (P2P)
- Subscription Box, Food Delivery

### Services
- Beauty/Spa, Restaurant, Hotel, Legal
- Home Services, Booking & Appointment

### Creative
- Portfolio, Agency, Photography, Gaming
- Music Streaming, Photo/Video Editor

### Lifestyle
- Habit Tracker, Recipe & Cooking, Meditation
- Weather, Diary, Mood Tracker

### Emerging Tech
- Web3/NFT, Spatial Computing, Quantum Computing

## Available UI Styles (67)

### General Styles (49)

| Style | Best For |
|-------|---------|
| Minimalism & Swiss Style | Enterprise apps, dashboards |
| Neumorphism | Health/wellness apps |
| Glassmorphism | Modern SaaS, financial dashboards |
| Brutalism | Design portfolios, artistic projects |
| 3D & Hyperrealism | Gaming, product showcase |
| Dark Mode (OLED) | Night-mode apps, coding platforms |
| Claymorphism | Educational apps, SaaS |
| Aurora UI | Modern SaaS, creative agencies |
| Soft UI Evolution | Modern enterprise apps |
| Bento Box Grid | Dashboards, product pages |
| AI-Native UI | AI products, chatbots, copilots |
| Spatial UI (VisionOS) | Spatial computing apps |

### Landing Page Styles (8)

| Style | Best For |
|-------|---------|
| Hero-Centric Design | Products with strong visual identity |
| Conversion-Optimized | Lead generation, sales pages |
| Feature-Rich Showcase | SaaS, complex products |
| Social Proof-Focused | Services, B2C products |
| Trust & Authority | B2B, enterprise, consulting |
| Storytelling-Driven | Brands, agencies, nonprofits |

### Dashboard Styles (10)

| Style | Best For |
|-------|---------|
| Data-Dense Dashboard | Complex data analysis |
| Executive Dashboard | C-suite summaries |
| Real-Time Monitoring | Operations, DevOps |
| Financial Dashboard | Finance, accounting |
| Sales Intelligence | Sales teams, CRM |

## Color Palette Selection

Each industry has recommended color moods:

| Industry | Color Mood | Example |
|----------|-----------|---------|
| Finance | Professional, Trust | Blue, Navy, Gold |
| Healthcare | Calming, Clean | Soft Blue, Green, White |
| E-commerce | Engaging, Conversion | Orange, Red, vibrant colors |
| Wellness | Organic, Premium | Soft Pink, Sage Green, Gold |
| Gaming | Vibrant, Immersive | Neon, Purple, Dark themes |
| Enterprise | Professional, Clean | Blue, Gray, White |

## Typography Pairings (57)

| Mood | Primary Font | Secondary Font | Best For |
|------|--------------|----------------|---------|
| Elegant | Cormorant Garamond | Montserrat | Luxury, wellness |
| Professional | Inter | Roboto | Enterprise, SaaS |
| Creative | Space Grotesk | DM Sans | Agencies, portfolios |
| Minimal | Helvetica Neue | Arial | Documentation, dashboards |
| Tech | JetBrains Mono | Inter | Developer tools |
| Modern | Outfit | Plus Jakarta Sans | Modern SaaS, fintech |

## Supported Tech Stacks (15)

| Stack | Guidelines Focus |
|-------|------------------|
| HTML + Tailwind | Default, semantic HTML |
| React | Component-based, hooks |
| Next.js | SSR, routing, optimization |
| Vue | Vue 3, Composition API |
| Nuxt.js | Vue ecosystem, SSR |
| SwiftUI | iOS native, declarative |
| React Native | Cross-platform mobile |
| Flutter | Dart, Material/Cupertino |
| shadcn/ui | Radix primitives, Tailwind |
| Angular | TypeScript, RxJS |
| Laravel | Blade, Livewire |
| Astro | Hybrid rendering |

## Example Usage

### Generate Design System for Project

```
User: /oa-ui-design

AI: 请描述您的项目类型和需求...

User: 美容养生 SPA 网站着陆页

AI: 正在生成设计系统...

+----------------------------------------------------------------------------------------+
|  TARGET: Serenity Spa - RECOMMENDED DESIGN SYSTEM                                      |
+----------------------------------------------------------------------------------------+

|  PATTERN: Hero-Centric + Social Proof
|     Conversion: Emotion-driven with trust elements
|     CTA: Above fold, repeated after testimonials
|     Sections:
|       1. Hero (hero image + booking CTA)
|       2. Services (treatment cards)
|       3. Testimonials (customer reviews)
|       4. Booking (appointment form)
|       5. Contact (location + phone)

|  STYLE: Soft UI Evolution
|     Keywords: Soft shadows, subtle depth, calming, premium feel
|     Best For: Wellness, beauty, lifestyle brands
|     Performance: Excellent | Accessibility: WCAG AA

|  COLORS:
|     Primary:    #E8B4B8 (Soft Pink)
|     Secondary:  #A8D5BA (Sage Green)
|     CTA:        #D4AF37 (Gold)
|     Background: #FFF5F5 (Warm White)
|     Text:       #2D3436 (Charcoal)
|     Notes: Calming palette with gold accents for luxury feel

|  TYPOGRAPHY: Cormorant Garamond / Montserrat
|     Mood: Elegant, calming, sophisticated
|     Google Fonts: https://fonts.google.com/share?selection.family=Cormorant+Garamond,Montserrat

|  KEY EFFECTS:
|     Soft shadows (0 4px 20px rgba(0,0,0,0.08))
|     Smooth transitions (200-300ms)
|     Gentle hover states (scale 1.02, shadow increase)

|  AVOID (Anti-patterns):
|     Bright neon colors
|     Harsh animations
|     Dark mode (unless user preference)
|     AI purple/pink gradients (generic AI look)

|  PRE-DELIVERY CHECKLIST:
|     [ ] No emojis as icons (use SVG: Heroicons/Lucide)
|     [ ] cursor-pointer on all clickable elements
|     [ ] Hover states with smooth transitions (150-300ms)
|     [ ] Light mode: text contrast 4.5:1 minimum
|     [ ] Focus states visible for keyboard nav
|     [ ] prefers-reduced-motion respected
|     [ ] Responsive: 375px, 768px, 1024px, 1440px

+----------------------------------------------------------------------------------------+
```

### Stack-Specific Implementation

```
User: 用 React + Tailwind 实现

AI: 正在生成 React 组件...

基于设计系统，生成以下组件结构：

src/components/
├── Hero.tsx           # Hero section with soft shadows
├── Services.tsx       # Treatment cards with hover effects
├── Testimonials.tsx   # Customer reviews carousel
├── Booking.tsx        # Appointment form with validation
└── Contact.tsx        # Location and contact info

配色变量:
- primary: '#E8B4B8'
- secondary: '#A8D5BA'
- cta: '#D4AF37'
- background: '#FFF5F5'
- text: '#2D3436'
```

## Integration Points

### After `/oa-brainstorming`

```
/oa-brainstorming → /oa-ui-design
```

After clarifying requirements, generate design system.

### Before `/oa-execute`

```
/oa-ui-design → /oa-execute
```

Before executing, have design guidelines ready.

### Complements `/oa-review`

```
/oa-ui-design → /oa-review
```

Design review validates against generated design system.

## Related Skills

- `/oa-brainstorming` — Clarify UI/UX requirements
- `/oa-review` — Validate design implementation
- `/oa-qa-browser` — Test visual regression
- `/oa-benchmark` — Test performance

## Further Reading

- UI UX Pro Max: https://github.com/nextlevelbuilder/ui-ux-pro-max-skill
- Design Systems: https://www.designsystems.com
- WCAG 2.1: https://www.w3.org/WAI/WCAG21/quickref/
- Google Fonts: https://fonts.google.com

## Implementation

This skill uses a custom BM25 search engine for intelligent recommendations:

### Scripts Location
- `lib/ui-design/scripts/core.py` — BM25 search engine
- `lib/ui-design/scripts/design_system.py` — Design system generator

### Data Files
- `lib/ui-design/data/styles.csv` — 21 UI styles
- `lib/ui-design/data/products.csv` — 22 product types
- `lib/ui-design/data/colors.csv` — 16 color palettes
- `lib/ui-design/data/typography.csv` — 12 font pairings
- `lib/ui-design/data/landing.csv` — 12 landing patterns
- `lib/ui-design/data/ux.csv` — 20 UX principles

### Quick Search Examples

```bash
# Search styles
python lib/ui-design/scripts/core.py "minimal tech" --json

# Generate full system
python lib/ui-design/scripts/design_system.py \
  --industry fintech --product banking --mood professional --full --json
```

## Notes

- This skill provides intelligent design recommendations
- Output should be validated with user before implementation
- Industry rules are guidelines, not strict requirements
- Always consider user's brand identity and preferences
- Combine with `/oa-review` for comprehensive design validation
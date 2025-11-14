# CLAUDE.md - {{ APP_NAME }}

**Project:** {{ APP_NAME }}
**Stack:** SvelteKit + Supabase + Stripe + DaisyUI
**Created:** {{ CREATED_DATE }} via `mixnd app new {{ APP_SLUG }}`

---

**App Info:**
- Domain: {{ APP_DOMAIN }}
- GitHub: {{ GITHUB_REPO }}
- Supabase Project: {{ SUPABASE_PROJECT_ID }}
- Doppler Project: {{ APP_SLUG }} (dev/prd configs)
- Coolify App UUID: {{ COOLIFY_UUID }}

---

## mixnd Ecosystem Protocols

**Context Repo:** All planning, diaries, goals stored in `../context/spaces/{{ APP_SLUG }}/`

**Key Files:**
- Diary: `../context/spaces/{{ APP_SLUG }}/diary.md` - Daily development log
- Goals: `../context/spaces/{{ APP_SLUG }}/current_goals.md` - Active objectives
- Status: `../context/spaces/{{ APP_SLUG }}/status.md` - Project health snapshot

**Diary Format (CRITICAL):**
```
**HH:MM** - Brief description (1-2 lines max)
- What was discovered/issue found
- What action was taken
- What the result was (✓/✗)
```

**Rules:**
- Timestamp format: `**HH:MM**` (24-hour)
- Keep entries 1-2 lines MAX
- No fluff, no commentary - just facts
- Document BEFORE and AFTER actions
- Use ✓/✗ for success/failure
- **Read diary tail** with offset (last 50 lines) - more efficient than full read

---

## Design System - DaisyUI

**Theme:** Custom theme "saasstartertheme" defined in `src/app.css`

**Colors:**
- Primary: {{ PRIMARY_COLOR }}
- Secondary: {{ SECONDARY_COLOR }}
- Accent: {{ ACCENT_COLOR }}
- All semantic colors defined in `src/app.css` lines 15-34

**Typography:**
- Heading: {{ HEADING_FONT }}
- Body: {{ BODY_FONT }}

**CRITICAL - AI Design Rules:**

✅ **ALWAYS DO:**
- Use DaisyUI semantic classes: `bg-primary`, `text-accent`, `btn-secondary`
- Use theme colors via CSS variables: `oklch(var(--p))`, `oklch(var(--ac))`
- Stick to existing component patterns in codebase
- Reference design tokens from `src/app.css`

❌ **NEVER DO:**
- Invent random colors (no random hex/oklch values)
- Use arbitrary Tailwind colors (no `bg-blue-500`, `text-gray-600` unless for states)
- Create custom CSS overrides (specificity wars)
- Mix custom components with DaisyUI (consistency breaks)

**Best Practices:**
1. **Semantic over specific** - Use `bg-primary` not `bg-[#180042]`
2. **Theme variables** - Colors come from theme, not arbitrary values
3. **Component reuse** - Check existing components before creating new ones
4. **Consistency** - One way to do things, not multiple approaches

**Reference:** DaisyUI docs at https://daisyui.com/docs/themes/

---

## Development Workflow

**Environments:**
- **dev** - Local development + PR testing ({{ APP_SLUG }}.mixnd.com)
- **prd** - Production ({{ APP_DOMAIN }})

**Common Commands:**
```bash
# Development
pnpm dev                    # Start dev server
pnpm test                   # Run tests
pnpm check                  # Type check

# Database (Supabase)
mixnd db migrate            # Run migrations
mixnd db push --env dev     # Push schema to dev
mixnd db push --env prd     # Push schema to prod

# Deployment
git push origin dev         # Auto-deploy to dev (if tests pass)
git push origin main        # Auto-deploy to prod (if tests pass)

# Logs & Debugging
mixnd logs --env dev        # Stream dev logs
mixnd logs --env prd        # Stream prod logs
```

---

## Integration Setup

**Auth (Supabase):**
- Email auth configured
- Google OAuth: {{ OAUTH_PROVIDERS }}
- Password reset via Supabase SMTP

**Billing (Stripe):**
- Products defined in Stripe Dashboard
- Webhook endpoint: `/webhooks/stripe`
- Subscription management: `/account/billing`

**Email (Resend):**
- Transactional emails via Resend API
- Templates: `src/lib/emails/*.hbs` (Handlebars)

---

## Code Patterns

**Route Structure:**
- `(marketing)` - Public pages (home, pricing, blog)
- `(admin)/account` - Protected user dashboard

**Data Loading:**
- Use `+page.server.ts` for server-side data
- Use `+layout.server.ts` for shared layout data
- Always handle auth in `+layout.server.ts`

**Forms:**
- Use SvelteKit form actions (no client-side only)
- Handle redirects with `redirect()` helper
- Use `fail()` for validation errors

**Styling:**
- Tailwind + DaisyUI for all styling
- No custom CSS unless absolutely necessary
- Mobile-first responsive design

---

## Testing

**E2E Tests:** Playwright (runs on every PR)
**Unit Tests:** Vitest for business logic

**Before Committing:**
```bash
pnpm check      # Type checking
pnpm test       # Run tests
pnpm lint       # ESLint
pnpm format     # Prettier
```

**CI/CD:** GitHub Actions runs tests, deploys on success

---

## Common Issues & Solutions

**1. Throw redirect error:**
- Use `return redirect(303, '/path')` in load functions
- Never throw redirect in try/catch blocks

**2. Cookie handling:**
- Always use `event.cookies` in server code
- Set SameSite=Lax for auth cookies

**3. Type errors:**
- Run `pnpm check` to catch TypeScript issues
- Regenerate types: `supabase gen types typescript`

**4. Stripe webhooks:**
- Test locally: `stripe listen --forward-to localhost:5173/webhooks/stripe`
- Verify webhook signature in production

---

## Documentation Standards

**When making changes:**
1. Update diary BEFORE trying something
2. Update diary AFTER with results
3. Update current_goals.md if priorities shift
4. Keep status.md current (weekly updates)

**Code comments:**
- Explain WHY, not WHAT
- Document complex business logic
- Link to external docs when relevant

---

## mixnd CLI Helpers

**Setup guides:**
```bash
mixnd setup google-oauth    # Google OAuth setup wizard
mixnd setup stripe          # Stripe products/webhooks guide
mixnd setup resend          # Resend domain setup guide
```

**All guides are interactive** - copy-pasteable values, step tracking, validation where possible

---

## Project-Specific Notes

<!-- Add app-specific context here -->
<!-- Business logic, domain concepts, API integrations -->
<!-- Anything unique to {{ APP_NAME }} -->

---

**Remember:** This is a mixnd ecosystem app. Follow the protocols, use the context repo, maintain the diary, stick to the design system.
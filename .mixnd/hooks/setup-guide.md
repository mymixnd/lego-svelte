# Manual Setup Guide

This guide covers the few remaining setup steps that cannot be automated.

## 1. Resend Domain Verification

**Required for:** Sending emails from your domain

**Steps:**
1. Go to [Resend Dashboard → Domains](https://resend.com/domains)
2. Click "Add Domain"
3. Enter your domain (e.g., `dev.mixnd.com`)
4. Add the DNS records shown (TXT, MX, DKIM)
5. Wait for verification (5-10 minutes)

---

## 2. Google OAuth (Optional)

**Required for:** "Sign in with Google" button

### Create OAuth Credentials
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create new project or select existing
3. APIs & Services → Credentials → Create OAuth client ID
4. Configure consent screen:
   - App name: `{{ APP_NAME }}`
5. Create Web application credentials:
   - Authorized redirect URIs:
     ```
     https://{{ SUPABASE_PROJECT_REF }}.supabase.co/auth/v1/callback
     http://localhost:54321/auth/v1/callback
     ```
6. Copy Client ID and Client Secret

### Configure Supabase
1. Go to Supabase Dashboard → Authentication → Providers
2. Enable Google provider
3. Paste Client ID and Client Secret
4. Save

### Enable in Code
1. Edit `src/lib/config/login_config.ts`
2. Add `"google"` to `oAuthProviders` array
3. Commit and push

---

## 3. Supabase SMTP (Optional)

**Optional:** Use Resend for auth emails instead of Supabase's default SMTP

**Steps:**
1. Supabase Dashboard → Settings → Auth → SMTP Settings
2. Enable Custom SMTP:
   - Host: `smtp.resend.com`
   - Port: `587`
   - Username: `resend`
   - Password: Your Resend API key
   - Sender email: `noreply@yourdomain.com`
   - Sender name: `{{ APP_NAME }}`

---

## Troubleshooting

**Emails not sending:**
- Check Resend domain is verified
- Check `PRIVATE_RESEND_API_KEY` in Coolify
- Check logs: `gh run view` or Coolify dashboard

**Google OAuth not working:**
- Check redirect URI matches exactly
- Check Client ID/Secret in Supabase
- Check `login_config.ts` has `["google"]`

**Migrations failed:**
- Run manually: `pnpm exec supabase db push`
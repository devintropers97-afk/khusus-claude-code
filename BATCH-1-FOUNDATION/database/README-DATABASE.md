# DATABASE DOCUMENTATION

**Database Name:** situneo_digital
**Total Tables:** 208
**MySQL Version:** 8.0+
**Character Set:** utf8mb4_unicode_ci

---

## IMPORT INSTRUCTIONS

### Via cPanel phpMyAdmin:
1. Login to cPanel → phpMyAdmin
2. Create database: `cpaneluser_situneo`
3. Select the database
4. Click **Import** tab
5. Choose file: `situneo_digital.sql`
6. Click **Go**
7. Wait for completion (~2-3 minutes for 208 tables)

### Via MySQL Command Line:
```bash
mysql -u username -p database_name < situneo_digital.sql
```

---

## TABLE STRUCTURE (208 Tables)

### Category A: User Management (18 tables)
1. users
2. user_roles
3. user_permissions
4. user_profiles
5. user_sessions
6. user_login_history
7. user_activity_logs
8. user_notifications
9. user_notification_settings
10. user_api_tokens
11. user_two_factor_auth
12. user_settings
13. user_documents
14. user_bank_accounts
15. user_verification_requests
16. user_referrals
17. user_blocks
18. password_resets

### Category B: Admin System (12 tables)
19. admins
20. admin_roles
21. admin_permissions
22. admin_role_permissions
23. admin_tasks
24. admin_notes
25. admin_work_hours
26. system_settings
27. system_maintenance
28. admin_announcement
29. admin_activity_logs
30. admin_reports

### Category C: Partner System (28 tables)
31. partners
32. partner_tiers
33. partner_tier_history
34. partner_sales
35. partner_commission_summary
36. partner_arpu_tracking
37. partner_clients
38. partner_leads
39. partner_withdrawal_requests
40. partner_training_progress
41. partner_performance_metrics
42. partner_targets
43. partner_incentives
44. partner_complaints
45. partner_communication_logs
46. partner_documents
47. partner_ratings
48. partner_team_members
49. partner_availability
50. partner_service_specialization
51. partner_certifications
52. partner_payout_methods
53. partner_referral_codes
54. partner_login_restrictions
55. partner_suspension_history
56. partner_earnings_adjustments
57. partner_subscription_plans
58. partner_analytics_summary

### Category D: SPV System (15 tables)
59. spv
60. spv_partner_mapping
61. spv_commission
62. spv_arpu_bonuses
63. spv_team_performance
64. spv_targets
65. spv_partner_recruitment
66. spv_training_sessions
67. spv_team_meetings
68. spv_partner_performance_reviews
69. spv_withdrawal_requests
70. spv_incentives
71. spv_complaints
72. spv_reports
73. spv_communication_logs

### Category E: Manager System (15 tables)
74. managers
75. manager_spv_mapping
76. manager_commission
77. manager_arpu_bonuses
78. manager_team_performance
79. manager_targets
80. manager_spv_recruitment
81. manager_strategic_plans
82. manager_spv_performance_reviews
83. manager_division_meetings
84. manager_withdrawal_requests
85. manager_incentives
86. manager_complaints
87. manager_reports
88. manager_budget_allocations

### Category F: Client System (25 tables)
89. clients
90. client_companies
91. client_contacts
92. client_segments
93. client_segment_mapping
94. client_preferences
95. client_credit_limits
96. client_projects
97. client_project_milestones
98. client_service_subscriptions
99. client_payment_methods
100. client_invoices
101. client_payments
102. client_credit_notes
103. client_communication_history
104. client_support_tickets
105. client_ticket_replies
106. client_feedback
107. client_complaints
108. client_referrals
109. client_loyalty_points
110. client_loyalty_transactions
111. client_contracts
112. client_nda
113. client_login_history

### Category G: Services & Orders (20 tables)
114. service_categories
115. services
116. service_addons
117. service_packages
118. service_pricing_tiers
119. service_custom_fields
120. orders
121. order_items
122. order_custom_requirements
123. order_files
124. order_deliverables
125. order_revisions
126. order_timeline
127. order_assignments
128. order_time_tracking
129. order_status_history
130. order_notes
131. order_cancellations
132. order_reviews
133. coupons

### Category H: Portfolio & Showcase (10 tables)
134. portfolio_categories
135. portfolio_projects
136. portfolio_images
137. portfolio_tags
138. portfolio_tag_mapping
139. portfolio_testimonials
140. portfolio_views
141. portfolio_likes
142. demo_websites
143. demo_requests

### Category I: Job Board System (10 tables)
144. job_posts
145. job_claims
146. job_assignments
147. job_progress
148. job_deliverables
149. job_commission_payments
150. job_cancellations
151. job_disputes
152. job_ratings
153. job_templates

### Category J: Commission & Financials (15 tables)
154. commission_tiers
155. commission_transactions
156. commission_calculations
157. arpu_calculations
158. withdrawal_requests
159. payment_transactions
160. invoices
161. invoice_items
162. payment_gateways
163. refunds
164. transaction_fees
165. financial_reports
166. revenue_summary
167. budget_allocations
168. tax_records

### Category K: Email Automation (8 tables)
169. email_templates
170. email_campaigns
171. email_queue
172. email_logs
173. email_clicks
174. email_unsubscribes
175. email_automation_workflows
176. email_workflow_subscribers

### Category L: Content Management (12 tables)
177. pages
178. blog_categories
179. blog_posts
180. blog_tags
181. blog_post_tags
182. blog_comments
183. faqs
184. faq_categories
185. media_library
186. banners
187. announcements
188. redirects

### Category M: Analytics & Tracking (10 tables)
189. website_analytics
190. conversion_tracking
191. user_behavior_tracking
192. search_queries
193. ab_tests
194. ab_test_results
195. heatmap_data
196. performance_metrics
197. error_logs
198. api_request_logs

### Category N: System & Configuration (10 tables)
199. migrations
200. sessions
201. cache
202. jobs
203. failed_jobs
204. notifications
205. backups
206. cron_jobs
207. audit_trails
208. feature_flags

---

## DEFAULT DATA INCLUDED

### Default Roles (user_roles):
1. Super Admin
2. Manager
3. SPV
4. Partner
5. Client

### Default Admin User:
- Email: admin@situneo.my.id
- Password: Admin123! (hashed with bcrypt)
- Role: Super Admin

### Default Commission Tiers (4 tiers):
- TIER 1: 30% (Rp 0 - Rp 10M/month)
- TIER 2: 40% (Rp 10M - Rp 25M/month)
- TIER 3: 50% (Rp 25M - Rp 50M/month)
- TIER MAX: 55% (Rp 50M+/month)

### Sample Services (10 services):
- Landing Page 1 Halaman
- Company Profile 5 Halaman
- Company Profile 10 Halaman
- E-Commerce Basic
- SEO Basic
- (etc.)

---

## INDEXES & OPTIMIZATION

All tables include:
- ✅ Primary keys (AUTO_INCREMENT)
- ✅ Foreign keys (with ON DELETE/UPDATE rules)
- ✅ Indexes on frequently queried columns
- ✅ UNIQUE constraints where needed
- ✅ Timestamps (created_at, updated_at)
- ✅ Soft deletes (deleted_at) on important tables

---

## BACKUP RECOMMENDATIONS

**Automated Daily Backups:**
- Via cPanel → Backup Wizard → Daily backups
- Or use cron job:
```bash
0 2 * * * mysqldump -u user -p password situneo_digital > backup_$(date +\%Y\%m\%d).sql
```

**Retention:** 30 days minimum

---

## DATABASE SIZE ESTIMATE

**Empty Database:** ~5 MB (structure only)
**With Sample Data:** ~8 MB
**After 1 Year Operation (estimated):** 500 MB - 2 GB
- Depends on: orders, analytics, logs, uploads

---

## TROUBLESHOOTING

### Import Errors:
- **"Max execution time exceeded":** Increase `max_execution_time` in php.ini
- **"Packet too large":** Increase `max_allowed_packet` in MySQL config
- **Foreign key errors:** Import in order (file already ordered correctly)

### Connection Errors:
- Check `config/database.php` credentials
- Verify database user has ALL PRIVILEGES
- Test connection: cPanel → Remote MySQL (allow localhost)

---

**Generated:** 2025-11-27
**Version:** 1.0

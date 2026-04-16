# James Clark E-Commerce (PHP + MySQL)

## What’s included
- Role-based accounts: `user` and `admin`
- Login:
  - Email/password registration + login
  - Google OAuth login (see setup)
  - Logout
- User features:
  - Browse products by category, add to cart, place orders
  - View order history
  - Update profile
- Admin features (CRUD):
  - Products
  - Categories
  - Users
  - Orders (status update + delete)

## Requirements
- PHP (PDO + cURL enabled)
- MySQL (InnoDB)
- Internet access for Google OAuth + Bootstrap CDN

## Database setup
1. Create/verify your database (default name: `helmet_db`).
2. Update `.env` if your MySQL credentials/db name differ.
3. Run `schema.sql` in MySQL against your target database (it drops and recreates tables there).

Default admin credentials (created by `schema.sql`):
- Email: `admin@example.com`
- Password: `Admin123!`

## Configure environment variables
Create a file named `.env` in the project root (`c:\xampp\htdocs\james_clark\.env`), for example:

```env
DB_HOST=localhost
DB_NAME=helmet_db
DB_USER=root
DB_PASS=

APP_NAME=JC SPORTS APPAREL

# Google OAuth
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
# Must match exactly what you set in Google Cloud:
GOOGLE_REDIRECT_URI=http://localhost/james_clark/?route=auth.google.callback
GOOGLE_SCOPES=openid email profile
```

## Run the app
Open:
- `http://localhost/james_clark/`

Then use the navbar to browse, cart, orders, profile, and admin screens.

## Notes
- For Google OAuth to work, ensure your Google project has the redirect URI configured exactly as above.
- If you change the schema, rerun `schema.sql` to keep `order_items` in sync.


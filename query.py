import mysql.connector
import os

# Database configuration (consider using environment variables in production)
DB_CONFIG = {
    'user': 'vscode',
    'password': 'password',
    'host': '127.0.0.1', # Use 127.0.0.1 because the MySQL server runs in the same container
    'database': 'mydatabase',
    'port': 3306
}

def query_users():
    """Connects to the MySQL database and queries the users table."""
    conn = None # Initialize conn to None
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()

        print(f"Querying database: {DB_CONFIG['database']} on {DB_CONFIG['host']}")
        cursor.execute("SELECT id, name FROM users")

        rows = cursor.fetchall()

        if rows:
            print("Found users:")
            for row in rows:
                print(f"  ID: {row[0]}, Name: {row[1]}")
        else:
            print("No users found in the table.")

    except mysql.connector.Error as e:
        print(f"Database error: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        if conn and conn.is_connected():
            cursor.close()
            conn.close()
            print("Database connection closed.")

if __name__ == "__main__":
    query_users() 
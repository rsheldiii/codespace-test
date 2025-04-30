import mysql.connector
import os
import sys

# Database configuration
DB_CONFIG = {
    'user': 'vscode',
    'password': 'password',
    'host': '127.0.0.1',
    'database': 'mydatabase',
    'port': 3306
}

def execute_sql_from_file(sql_file_path):
    """Connects to the MySQL database and executes SQL commands from a file."""
    conn = None
    try:
        # Read SQL commands from the file
        print(f"Reading SQL commands from: {sql_file_path}")
        with open(sql_file_path, 'r') as file:
            sql_script = file.read()

        # Connect to the database
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()
        print(f"Connected to database: {DB_CONFIG['database']} on {DB_CONFIG['host']}")

        # Execute the SQL script (handling multiple statements)
        print("Executing SQL script...")
        results_iterator = cursor.execute(sql_script, multi=True)

        statement_count = 0
        for result in results_iterator:
            statement_count += 1
            print(f"--- Result for statement {statement_count} ---")
            if result.with_rows:
                print(f"Rows returned by statement: {result.statement}")
                fetched_rows = result.fetchall()
                if fetched_rows:
                    # Print header (column names)
                    print(" | ".join([col[0] for col in result.description]))
                    print("-" * (len(" | ".join([col[0] for col in result.description])))) # Separator
                    # Print rows
                    for row in fetched_rows:
                        print(" | ".join(map(str, row)))
                else:
                    print("(No rows returned)")
            else:
                print(f"Statement executed (no rows): {result.statement}, Rows affected: {result.rowcount}")
        
        conn.commit() # Commit changes if any INSERT/UPDATE/DELETE were executed
        print("\nSQL script execution finished successfully.")

    except FileNotFoundError:
        print(f"Error: SQL file not found at {sql_file_path}")
    except mysql.connector.Error as e:
        print(f"Database error during execution: {e}")
        if conn: # Rollback changes if an error occurred mid-script
             print("Rolling back potential changes.")
             conn.rollback()
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        if conn and conn.is_connected():
            cursor.close()
            conn.close()
            print("Database connection closed.")

if __name__ == "__main__":
    # Default to sample_queries.sql, but allow overriding via command line argument
    sql_file = sys.argv[1] if len(sys.argv) > 1 else "sample_queries.sql"
    execute_sql_from_file(sql_file) 
import pyodbc
import logging
import time

# ==========================
# Database Configuration
# ==========================
from config import SERVER, DATABASE, DRIVER

connection_string = (
    f"DRIVER={{{DRIVER}}};"
    f"SERVER={SERVER};"
    f"DATABASE={DATABASE};"
    "Trusted_Connection=yes;"
)

#================================
# Logging
#================================
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s",
    handlers=[
        logging.FileHandler("logs/etl_pipeline.log"),
        logging.StreamHandler()
    ]
)

# ==========================
# Function to Execute Stored Procedures
# ==========================

def execute_procedure(cursor, procedure_name):

    logging.info(f"Running {procedure_name}")

    start_time = time.time()

    cursor.execute(f"EXEC {procedure_name};")

    end_time = time.time()

    duration = round(end_time - start_time, 2)

    logging.info(f"{procedure_name} Completed Successfully ({duration} sec)")

# ==========================
# Main Program
# ==========================

try:

    logging.info("Connecting to SQL Server...")

    conn = pyodbc.connect(connection_string)

    cursor = conn.cursor()

    logging.info("Connected Successfully!")

    # Bronze Layer
    execute_procedure(cursor, "Bronze.load_Bronze")

    # Silver Layer
    execute_procedure(cursor, "Silver.load_Silver")

    conn.commit()

    cursor.close()

    conn.close()

    logging.info("\nETL Pipeline Finished Successfully!")

except Exception as e:

    logging.error("Pipeline Failed!")

    logging.exception(e)

    print("pipeline version2")
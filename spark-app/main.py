from pyspark.sql import SparkSession

def main():
    spark = SparkSession.builder \
        .appName("Basic CSV Reader") \
        .getOrCreate()

    df = spark.read.csv("/opt/spark-apps/data/students.csv", header=True, inferSchema=True)
    df.show()
    print(f"Total students: {df.count()}")
    spark.stop()

if __name__ == "__main__":
    main()

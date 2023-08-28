import csv
import psycopg2

conn = psycopg2.connect(database='collegedb',
                        host="localhost",
                        user="omdeshmukh",
                        password="123456",
                        port=5432)

mycursor = conn.cursor()

with open("studentData.csv","r") as ipt:
    csv_reader = csv.reader(ipt)

    for row in csv_reader:
        line = "INSERT INTO student VALUES("+row[0]+",\'"+row[1]+"\',\'"+row[2]+"\',"+row[3]+");"
        mycursor.execute(line)
        
        
with open("departmentData.csv","r") as ipt:
    csv_reader = csv.reader(ipt)

    for row in csv_reader:
        line = "INSERT INTO department VALUES(\'"+row[0]+"\',"+row[1]+");"
        mycursor.execute(line)
        
        
with open("professorData.csv","r") as ipt:
    csv_reader = csv.reader(ipt)

    for row in csv_reader:
        line = "INSERT INTO professor VALUES(\'"+row[0]+"\',\'"+row[1]+"\');"
        mycursor.execute(line)
  
  
with open("courseData.csv","r") as ipt:
    csv_reader = csv.reader(ipt)

    for row in csv_reader:
        line = "INSERT INTO course VALUES("+row[0]+",\'"+row[1]+"\',\'"+row[2]+"\');"
        mycursor.execute(line)      


with open("majorData.csv","r") as ipt:
    csv_reader = csv.reader(ipt)

    for row in csv_reader:
        line = "INSERT INTO major VALUES(\'"+row[0]+"\',"+row[1]+");"
        mycursor.execute(line)
 
with open("enrollData.csv","r") as ipt:
    csv_reader = csv.reader(ipt)

    for row in csv_reader:
        line = "INSERT INTO enroll VALUES("+row[0]+",\'"+row[1]+"\',\'"+row[2]+"\',"+row[3]+");"
        mycursor.execute(line) 

       
conn.commit()
conn.close()
mycursor.close()
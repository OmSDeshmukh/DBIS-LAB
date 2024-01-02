import csv
import psycopg2

conn = psycopg2.connect(database='moviedb',
                        host="localhost",
                        user="omdeshmukh",
                        password="123456",
                        port=5432) 
                        
mycursor = conn.cursor()

id = int(input("Enter actor id:"))
fname = input("Enter First Name:")
lname = input("Enter Last Name:")
g = input("Enter Gender:")

mycursor.execute("SELECT COUNT(*) FROM actor WHERE act_id = %s", (id,))
# mycursor.fetchall() gives us all the tuple which are output in the given query
# for row in mycursor.fetchall():
#     print(row)

if(mycursor.fetchall()[0][0] == 1):
    print("Actor ID already exists")
else:
    mycursor.execute("INSERT INTO actor VALUES(%s,%s,%s,%s)",(id, fname, lname, g))
    print("Actor details inserted into the actor table succesfully")
    conn.commit()
    
mycursor.close()
conn.close()

    
    

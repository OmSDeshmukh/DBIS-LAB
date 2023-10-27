import csv
import psycopg2

conn = psycopg2.connect(database='moviedb',
                        host="localhost",
                        user="omdeshmukh",
                        password="123456",
                        port=5432) 
                        
mycursor = conn.cursor()

n = int(input("Enter the number of movies he has acted in"))
ids = []
roles = []
for i in range(1, n + 1):
    id = int(input("Enter movie id of movie number " + str(i) + ": "))
    ids.append(id)
    role = input("Enter role of the actor in movie number " + str(i) + ": ")
    roles.append(role)
    
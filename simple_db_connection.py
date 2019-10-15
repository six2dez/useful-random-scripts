#!/usr/bin/python
import MySQLdb
import sys

if(len(sys.argv) < 4):
		print("Usage: %s HOST USER PASSWORD DBNAME\n" % sys.argv[0])
		print("Eg:    %s 10.10.10.10 root toor database1" % sys.argv[0])
		exit()

db = MySQLdb.connect(host=sys.argv[1],
                     user=sys.argv[2],
                     passwd=sys.argv[3],
                     db=sys.argv[4])

# you must create a Cursor object. It will let
#  you execute all the queries you need
cur = db.cursor()

# Use all the SQL you like
cur.execute("SELECT * FROM USERS")

# print all the first cell of all the rows
for row in cur.fetchall():
    print row[0]

db.close()
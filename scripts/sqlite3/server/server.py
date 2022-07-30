import socket
import sqlite3 as sq3


def InsertInDB(file_gameplay):
    with open("/home/flaera/MFRG/scripts/sqlite3/server/gameplay.db", "wb") as game_file:
        game_file.write(file_gameplay)

    conn1 = sq3.connect("/home/flaera/MFRG/scripts/sqlite3/server/gameplay.db")
    conn1.execute("SELECT * FROM data")
    cursor1 = conn1.cursor().fetchall()
    print("cursor=", cursor1)
    params = (cursor1[0], cursor1[1], cursor1[2])

    conn = sq3.connect("/home/flaera/MFRG/scripts/sqlite3/server/gameplays.db")
    cursor = conn.execute("SELECT * FROM data")
    cursor.execute("INSERT INTO group_etn, name_event, opnion VALUES (?, ?, ?)", (params,))
    conn.commit()

    conn.close()
    conn1.close()
    cursor1.close()


def main():
    my_ip = "localhost"
    port = 51568 #client: 51568
    
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind((my_ip,port))
    server.listen(100)
    online_flag = bool(True)
    while online_flag==True:
        print("Waiting connections...\n")
        
        conn, address = server.accept()
        
        name_file = conn.recv(5*1024)
        #print("name_file=", name_file)
        InsertInDB(name_file)
        #with open("/home/flaera/MFRG/scripts/sqlite3/server/"+name_save, "wb") as file:
         #   print("Escrevendo...")
          #  file.write(name_file)
        
        conn.close()

    server.close()
    return 0


main()
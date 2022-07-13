import socket
#import sqlite3 as sq3


def main():
    my_ip = "localhost"
    port = 51568 #client: 51567
    
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind((my_ip,port))
    server.listen(100)
    online_flag = bool(True)
    while online_flag==True:
        print("Waiting connections...\n")
        
        conn, address = server.accept()
        
        name_file = conn.recv(5*1024)
        print("name_file=", name_file)
        with open("/home/flaera/MFRG/scripts/sqlite3/server/gameplay1_test.db", "wb") as file:
            print("Escrevendo...")
            file.write(name_file)
        
        conn.close()

    server.close()
    return 0


main()
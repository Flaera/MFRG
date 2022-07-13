from bge import logic
import sqlite3 as sq3
import socket
#import errno
#from signal import signal, SIGPIPE, SIG_DFL 
#Ignore SIG_PIPE and don't throw exceptions on it... (http://docs.python.org/library/signal.html)
#signal(SIGPIPE,SIG_DFL)


class DataBase():
    def CreateDB(group_social):
        group_etn = int(group_social)

        is_conection = int(0)
        with open(logic.expandPath("//data_files/data_permission.txt"), 'r') as data_perm:
            is_conection = int(data_perm.read())
        
        if (is_conection==1):
            #self.connected = bool(False)

            conn = sq3.connect(logic.expandPath("//MFRG.db"))
            print("Obj_connection_create: ", conn)
            conn.execute("CREATE TABLE IF NOT EXISTS data (group_etn integer, name_event text, opnion text)")
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM data")
            lines = cursor.fetchall()
            print("lines=", lines)
            if (lines==[]) or (lines==None):
                try:
                    cursor.execute("INSERT INTO data (group_etn, name_event, opnion) VALUES (?,?,?)",(group_etn,"","",))
                    conn.commit()
                    print("Dados inseridos in table empty.")
                except sq3.Error as e:
                    print("Não foi possivel inserir o grupo social. Erro:",e)
                finally:
                    print("Conexão ao sqlite3 encerrada.")
            else:
                try:
                    cursor.execute("UPDATE data SET group_etn=?, name_event=?, opnion=?",(group_etn,"","",))
                    conn.commit()
                    print("Dados atualizados in table existing.")
                except sq3.Error as e:
                    print("Não foi possivel atualizar os dados. Erro:",e)
                finally:
                    print("Conexão ao sqlite3 encerrada.")

            cursor.close()
            conn.close()


    def InsertEvent(n_event):
        #self.cont = logic.getCurrentController()
        is_conection = 0
        with open(logic.expandPath("//data_files/data_permission.txt"), 'r') as data_perm:
            is_conection = int(data_perm.read())
        
        if (is_conection==1):
            #connected = bool(False)

            conn = sq3.connect(logic.expandPath("//MFRG.db"))
            cursor = conn.cursor()
            try:
                print("Obj_connection_create: ", conn)
                cursor.execute("SELECT name_event FROM data")
                line_event = cursor.fetchall()
                print("line_event=", line_event)
                if (line_event==None or line_event==[]): line_event=""
                sep_event = "-"+n_event
                params = line_event[0][0]+sep_event
                print("params=",params)
                conn.execute("UPDATE data SET name_event=?", (params,))
                conn.commit()
            except sq3.Error as e:
                print("Falhou envio do evento, erro: ",e)
            finally:
                cursor.close()
                conn.close()
                print("Conexão ao sqlite3 encerrada.")


    def SendDB():
        my_ip = "127.0.0.1"
        port = 51568

        client = socket.socket(socket.AF_INET, #type of ip: IPv4
                            socket.SOCK_STREAM) #Protocol TCP
        client.connect((my_ip, port))

        with open(logic.expandPath("//MFRG.db"), "rb") as file:
            client.sendfile(file)
            print("File of gameplay sended.")
            """for data in file.readlines()
                print("data=", data)
                try:
                    client.sendfile(data)
                    #print("bytes enviados: ", bytes)
                except IOError as e:
                    if e.errno == errno.EPIPE:
                        print("Falha ao enviar os dados, broken pipe. Erro: ", e)"""
        client.close()
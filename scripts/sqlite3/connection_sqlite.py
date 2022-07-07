from bge import logic
import sqlite3 as sq3


class DataBase():
    def CreateDB(group_social):
        group_etn = int(group_social)

        is_conection = int(0)
        with open(logic.expandPath("//data_files/data_permission.txt"), 'r') as data_perm:
            is_conection = int(data_perm.read())
        
        if (is_conection==1):
            #self.connected = bool(False)

            conn = sq3.connect("MFRG.db")
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
                    print("Dados inseridos.")
                except sq3.Error as e:
                    print("Não foi possivel inserir o grupo social. Erro:",e)
                finally:
                    print("Conexão ao sqlite3 encerrada.")
            else:
                try:
                    cursor.execute("UPDATE data SET group_etn=?, name_event=?, opnion=?",(group_etn,"","",))
                    conn.commit()
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

            conn = sq3.connect("MFRG.db")
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


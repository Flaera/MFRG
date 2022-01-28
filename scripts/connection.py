from bge import logic
import mysql.connector
from mysql.connector import Error


class Connection():
    def __init__(self, n_event):
        self.name_event = n_event
        cont = logic.getCurrentController()
        is_conection = 0
        with open(logic.expandPath("//data_files/data_permission.txt"), 'r') as data_perm:
            is_conection = int(data_perm.read())
        
        if (is_conection==1):
            try:
                con_obj = mysql.connector.connect(host="localhost", database="mfrg_data", user="mfrg",               password="049Mf#30")
                if (con_obj.is_connected()==True):
                    db_info = con_obj.get_server_info()
                    print("Conectado ao server MySQL, versão: ", db_info)
                    cursor = con_obj.cursor()
                    #print("name_event=", self.name_event)
                    #comand0 = """SELECT * events_completes;"""
                    #cursor.execute(comand0)
                    comand1 = """INSERT INTO 
                                events_completes 
                                (name_event)
                                VALUES 
                                ('"""+self.name_event+"""')"""
                    cursor.execute(comand1)
                    con_obj.commit()
                    
            except Error as e:
                print("Não estabelida conexão. Erro: ", e)
            finally:
                if (con_obj.is_connected()==True):
                    cursor.close()
                    con_obj.close()
                    print("Conexão ao MySQL encerrada.")
            
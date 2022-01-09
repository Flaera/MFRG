from bge import logic
import mysql.connector
from mysql.connector import Error


def AcessTable(cursor):
    try:
        cursor.execute("CREATE TABLE IF NOT EXISTS events_completes (name_event VARCHAR(100));")
        print("Tabela não encontrada. Tabela criada.")
    except Error as e:
        print("Erro na criação de tabela: ", e)


def Start():
    cont = logic.getCurrentController()
    is_conection = 0
    with open(logic.expandPath("//data_files/data_permission.txt"), 'r') as data_perm:
        is_conection = int(data_perm.read())
    
    if (is_conection==1):
        try:
            con_obj = mysql.connector.connect(host="localhost", database="mfrg_data", user="mfrg", password="049Mf#30")
            if (con_obj.is_connected()==True):
                db_info = con_obj.get_server_info()
                print("Conectado ao server MySQL, versão: ", db_info)
                cursor = con_obj.cursor()
                AcessTable(cursor)
                
                events = []
                with open(logic.expandPath("//data_files/events_completes.txt"), 'r') as events_completes:
                    events = events_completes.read().split('\n')
                print("events={}-".format(events))

                cursor.execute("SELECT * FROM mfrg_data.events_completes ORDER BY name_event DESC;")
                lines = cursor.fetchall()
                print("lines=", lines)

                len_lines = len(lines)
                len_events = len(events)
                for j in range(0, len_events):
                    if events[j]!='':
                        print("j=", j)
                        cursor.execute("UPDATE events_completes SET id = " + str(j))
                        con_obj.commit()
                
                acc = int(2)
                for i in lines:
                    print("i=", i[0], "acc=", acc)
                    update = "UPDATE events_completes SET name_event="+events[acc]+" WHERE id="+str(acc)
                    cursor.execute(update)
                    acc += 1
                    con_obj.commit()
        except Error as e:
            print("Não estabelida conexão. Erro: ", e)
        finally:
            if (con_obj.is_connected()==True):
                cursor.close()
                con_obj.close()
                print("Conexão ao MySQL encerrada.")
        
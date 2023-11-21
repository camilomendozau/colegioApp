#from config import config
import pgdb
from hashlib import md5    

class Database:
     def __init__(self):
        self.conexion = None
        self.connect()

     def connect(self):   
        try:

            # Conexion al servidor de PostgreSQL
            print('Conectando a la base de datos PostgreSQL...')
            self.conexion = pgdb.connect(host="localhost",database="Colegio", user="postgres", password="mendoza97_Inf")
            print('Conectado exitosamente a PostgreSQL...')
        except (Exception) as error:
            print(error)
            
     def closeConexion(self):
         if self.conexion is not None:
                self.conexion.close()
                print('Conexión finalizada.')
            
     def verificarLogin(self,username:str,psw:str):
          try:    
            #md5Psw = md5(psw.encode("utf-8")).hexdigest()
            cur = self.conexion.cursor()         
            query = f"""SELECT adm."verifyLogin"('{username}','{psw}')"""
            self.conexion.commit()
            cur.execute(query)
            response = cur.fetchone()
            responseIfClientExist = response[0]
            query = 'SELECT adm."getLastSesion"()'
            cur.execute(query)
            response = cur.fetchone()
            responsePID = response[0] 
            print(responseIfClientExist,responsePID)
            cur.close()
          except(Exception) as error:
              print(error)  
          return (responseIfClientExist,responsePID)   
     
     def getUINames(self,username:str):
          try:
            cur = self.conexion.cursor()         
            query = f"""SELECT adm."getUINames"('{username}')"""
            cur.execute(query)
            response = cur.fetchall() 
            #print(response)
            cur.close()
          except(Exception) as error:
            print(error)
          return response  
     
     def insertNewStudent(self,firstName:str,lastName:str,carnetIdentidad:str,fechaNacimiento:str,numeroTelefono:int,direccion:str):
          try:                
            cur = self.conexion.cursor()         
            query = f"""SELECT public."insertNewStudent"('{firstName}','{lastName}','{carnetIdentidad}','{fechaNacimiento}','{numeroTelefono}','{direccion}')"""
            cur.execute(query)
            self.conexion.commit()
            response = cur.fetchone()
            #print(response.insertNewStudent)
            cur.close()
          except(Exception) as error:
              print(error)  
          return (response)   
     
     def insertNewLaptop(self,serialNum:str,marca:str,modelo:str,sistemaOperativo:str,fechaAdquisicion:str,descripcion:int,estado:str,fileLink:str):
          try:                
            if fileLink != '':
               drawing = open(fileLink,'rb').read()
            else:
               drawing = None
            cur = self.conexion.cursor()         
            query = f"""SELECT public."insertNewLaptop"('{serialNum}','{marca}','{modelo}','{sistemaOperativo}','{fechaAdquisicion}','{drawing}','{descripcion}','{estado}')"""
            cur.execute(query)
            self.conexion.commit()
            response = cur.fetchone()
            #print(response)
            cur.close()   

          except(Exception) as error:
            print(error)  
          return (response)  
     
     def getSONames(self):
          try:
            cur = self.conexion.cursor()         
            query = f"""SELECT public."getSONames"()"""
            cur.execute(query)
            response = cur.fetchall()
            # print(type(response))
            cur.close()
          except(Exception) as error:
            print(error)
          return response  
     
     def getMarcasNames(self):
          try:
            cur = self.conexion.cursor()         
            query = f"""SELECT public."getMarcasLaptopsNames"()"""
            cur.execute(query)
            response = cur.fetchall() 
            #print(response)
            cur.close()
          except(Exception) as error:
            print(error)
          return response  
     
     def getRolesNames(self):
         try:
            cur = self.conexion.cursor()         
            query = f"""SELECT adm."getRolNames"()"""
            cur.execute(query)
            response = cur.fetchall() 
            #print(response)
            cur.close()
         except(Exception) as error:
            print(error)
         return response 
     
     def createNewUser(self,username:str,password:str,rol:str):
         try:
            #response = ''
            cur = self.conexion.cursor()         
            query = f"""SELECT adm."createNewUser"('{username}','{password}','{rol}')"""
            cur.execute(query)
            self.conexion.commit()
            response = cur.fetchone() 
            #print(response)
            cur.close()
         except(Exception) as error:
            print(error)
         return response 
     
     def deleteUser(self,username:str):
         try:
            #response = ''
            cur = self.conexion.cursor()         
            query = f"""SELECT adm."deleteUserByName"('{username}')"""
            cur.execute(query)
            self.conexion.commit()
            response = cur.fetchone() 
            #print(response.deleteUserByName)
            cur.close()
         except(Exception) as error:
            print(error)
         return response.deleteUserByName 
         
     
     def getUsernames(self):
         try:
            #response = ''
            cur = self.conexion.cursor()         
            query = f"""SELECT adm."getUserNames"()"""
            cur.execute(query)
            response = cur.fetchall() 
            #print(response)
            cur.close()
         except(Exception) as error:
            print(error)
         return response 
     
     

              
               
                     

# j = Database()
# j.deleteUser('nicanora98')
# j.getUsernames()
# print(j.createNewUser('miguelitos','chiquillos32','Estudiante'))
# j.getUINames('julioVerne'
#j.getMarcasNames()
#print(j.insertNewLaptop('G2P9N6Z5CR','Dell','Latitude E6430','Windows 10','2023-02-03','Ninguna','Nueva'))
    
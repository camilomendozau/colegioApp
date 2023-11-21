import tkinter as tk
from tkinter import Tk, Label, Button, Entry,filedialog
from db import Database
from tkcalendar import DateEntry 
from hashlib import md5 

class VentanaLogin(Tk):
    def __init__(self):
        super().__init__()
        self.geometry("350x180")
        self.title("Login")

        self.active = False 

        self.etiquetaUsername = Label(self, text="Username")
        self.etiquetaUsername.pack()

        self.userInput = Entry(self)
        self.userInput.pack()

        self.etiquetaPsw = Label(self, text="Password")
        self.etiquetaPsw.pack()

        self.passInput = Entry(self,show='*')
        self.passInput.pack()

        self.botonValidar = Button(self, text="VALIDAR", command=self.login)
        self.botonValidar.config(fg="white", bg="green")
        self.botonValidar.pack()

        self.etiquetaMsg = Label(self, text="")

        self.db = Database()   

    def login(self):
        if self.userInput.get() == '':   
                self.printLabel("El campo username no debe estar vacio !!!",'red')
        elif self.passInput.get() == '':
                self.printLabel("El campo password no debe ser vacio !!!",'red')         
        else:   
                print(self.userInput.get())
                print(self.passInput.get())  
                res = self.db.verificarLogin(self.userInput.get(),md5(self.passInput.get().encode("utf-8")).hexdigest())
                if res[0] == 1:
                      self.printLabel("Usuario correcto",'green')
                      self.etiquetaMsg = Label(self.master, text=f"PID: {res[1]}")
                      self.etiquetaMsg.config(fg='black')
                      self.etiquetaMsg.pack()

                      menuWindow = VentanaMenu(self.db,self.userInput.get())
                else:
                      self.printLabel("Usuario NO registrado en la BD",'red')    
                      
    def printLabel(self,mensaje,color):
        self.etiquetaMsg.destroy()
        self.etiquetaMsg = Label(self.master, text=mensaje)
        self.etiquetaMsg.config(fg=color)
        self.etiquetaMsg.pack()

    def getActive(self):
          return  self.active    



class VentanaMenu(Tk):
    def __init__(self,database,currentUsr):
        super().__init__()
        #tk.Toplevel(self)
        self.geometry("550x200")
        self.title("Menu Principal")
        self.currentUsername = currentUsr
        self.colors = ['red','yellow','green','orange','blue','pink','brown','gray','purple']

        self.db = database
        self.showOptionsInWindow()

        self.newWindow = ''

    def showOptionsInWindow(self):
        uiNames = self.db.getUINames(self.currentUsername)
        r = 0
        c = 0
        for i in range(len(uiNames)):
            if (i+1)%3 == 0:
                btnNewWindow = tk.Button(self, text=uiNames[i].getUINames,bg=self.colors[i],padx=5,pady=5, command=self.getCommandName(uiNames[i].getUINames))
                btnNewWindow.grid(row=r,column=c)
                c = 0
                r = r + 1
            else:
                btnNewWindow = tk.Button(self, text=uiNames[i].getUINames,bg=self.colors[i],padx=5,pady=5, command=self.getCommandName(uiNames[i].getUINames))
                btnNewWindow.grid(row=r,column=c) 
                c = c + 1

        self.close_button = tk.Button(self, text="Cerrar", command=self.closeProgram, bg='red')
        self.close_button.grid(row=r+1, column=3)   

    def closeProgram(self):
        self.db.closeConexion()
        self.quit()
                     
    def getCommandName(self,uiName):
         res = ''
         if uiName == "Insertar Estudiante":
            res = self.getWindowInsertStudent
         elif uiName == "Insertar Nueva Laptop":
            res = self.getWindowInsertLaptop   
         elif uiName == 'Crear Nuevo Usuario':
            res = self.getWindowCreateNewUser    
         elif uiName == 'Eliminar Usuario':
            res = self.getWindowDeleteUser    
         else:
             res = ''    
         return res   
                                
    def getWindowInsertStudent(self):
        self.newWindow = VentanaNewStudent(self.db)

    def getWindowInsertLaptop(self):
        self.newWindow = VentanaNewLaptop(self.db)    

    def getWindowCreateNewUser(self):
        self.newWindow = VentanaNewUser(self.db)  

    def getWindowDeleteUser(self):
        self.newWindow = VentanaDeleteUser(self.db)       
        



class VentanaNewStudent(Tk):

    def __init__(self,database):
        # Crear la ventana principal
        super().__init__()
        self.geometry("870x150")
        self.title("Insertar Nuevo Estudiante")

        self.db = database

        # Crear los widgets de entrada
        self.nombre_label = tk.Label(self, text="Nombres:")
        self.nombre_entry = tk.Entry(self)

        self.apellido_label = tk.Label(self, text="Apellidos:")
        self.apellido_entry = tk.Entry(self)

        self.ci_label = tk.Label(self, text="Carnet de Identidad:")
        self.ci_entry = tk.Entry(self)

        self.fecha_nacimiento_label = tk.Label(self, text="Fecha de Nacimiento:")
        self.fecha_nacimiento_entry = DateEntry(self, width=12, background='darkblue',
                                                foreground='white', borderwidth=2, year=2000)

        self.telefono_label = tk.Label(self, text="Número de Teléfono:")
        self.telefono_entry = tk.Entry(self)

        self.direccion_label = tk.Label(self, text="Dirección:")
        self.direccion_entry = tk.Entry(self,width=50)
    
        # Organizar los widgets utilizando el sistema de grillas
        self.nombre_label.grid(row=0, column=0)
        self.nombre_entry.grid(row=0, column=1)

        self.apellido_label.grid(row=0, column=2)
        self.apellido_entry.grid(row=0, column=3)

        self.ci_label.grid(row=1, column=0)
        self.ci_entry.grid(row=1, column=1)

        self.fecha_nacimiento_label.grid(row=1, column=2)
        self.fecha_nacimiento_entry.grid(row=1, column=3)

        self.telefono_label.grid(row=2, column=0)
        self.telefono_entry.grid(row=2, column=1)

        self.direccion_label.grid(row=3, column=0)
        self.direccion_entry.grid(row=3, column=1)

        # Crear el botón para enviar los datos
        self.enviar_button = tk.Button(self, text="Guardar", command=self.verifyAndInsertStudentData)
        self.enviar_button.grid(row=4, column=2, columnspan=2)

        self.close_button = tk.Button(self, text="Cerrar", command=self.destroy, bg='red')
        self.close_button.grid(row=4, column=3, columnspan=2)

        self.etiquetaMsg = Label(self, text="")


    def verifyAndInsertStudentData(self):
        nombres = ''
        apellidos = ''
        carnetIdentidad = ''
        fechaNacimiento = ''
        telefono = 0
        direccion = 'ninguna'

        if self.nombre_entry.get() != '':
             nombres =  self.nombre_entry.get()
        if self.apellido_entry.get() != '':
             apellidos =  self.apellido_entry.get()   
        if self.ci_entry.get() != '':
             carnetIdentidad =  self.ci_entry.get()       

        if self.direccion_entry.get() != 'ninguna':
             direccion =  self.direccion_entry.get()     

        if self.fecha_nacimiento_entry.get() != '' and self.telefono_entry.get() != '':
             telefono =  int(self.telefono_entry.get())  
             fechaNacimiento =  self.fecha_nacimiento_entry.get()
             res = self.db.insertNewStudent(nombres,apellidos,carnetIdentidad,fechaNacimiento,telefono,direccion)     
             self.printLabel(res.insertNewStudent,'green')
        else:
             self.printLabel("Fecha de Nacimiento y Telefono no deben estar vacios",'red')     

    def printLabel(self,mensaje,color):
        self.etiquetaMsg.destroy()
        self.etiquetaMsg = tk.Label(self, text=mensaje)
        self.etiquetaMsg.config(fg=color)
        self.etiquetaMsg.grid(row=5, column=1)


class VentanaNewLaptop(Tk):
    def __init__(self,database):
        # Crear la ventana principal
        super().__init__()
        self.geometry("870x200")
        self.title("Insertar Nueva Laptop")

        self.db = database

        # Crear los widgets de entrada
        self.serialNum_label = tk.Label(self, text="Numero Serial:")
        self.serialNum_entry = tk.Entry(self)

        self.marca_label = tk.Label(self, text="Marca:")
        self.marca_defaultText = tk.StringVar(self)
        self.marca_defaultText.set("HP")
        self.marca_menu = tk.OptionMenu(self, self.marca_defaultText,*self.getMarcasList())

        self.modelo_label = tk.Label(self, text="Modelo:")
        self.modelo_entry = tk.Entry(self)

        self.so_label = tk.Label(self, text="Sistema Operativo:")
        self.so_defaultText = tk.StringVar(self)
        self.so_defaultText.set("Windows 10")
        self.so_menu = tk.OptionMenu(self, self.so_defaultText, *self.getSOList())

        self.adquisicionFecha_label = tk.Label(self, text="Fecha de Adquisicion:")
        self.adquisicionFecha_entry = DateEntry(self, width=12, background='darkblue',
                                                foreground='white', borderwidth=2, year=2023)
        
        self.estadoLabel = tk.Label(self, text="Estado:")
        self.estado_defaultText = tk.StringVar(self)
        self.estado_defaultText.set("Nuevo")
        self.estadoMenu = tk.OptionMenu(self, self.estado_defaultText, *["Nuevo","Usado"])

        self.descripcionLabel = tk.Label(self, text="Descripcion:")
        self.descripcionEntry = tk.Entry(self,width=50)
    
        # Organizar los widgets utilizando el sistema de grillas
        self.serialNum_label.grid(row=0, column=0)
        self.serialNum_entry.grid(row=0, column=1)

        self.marca_label.grid(row=0, column=2)
        self.marca_menu.grid(row=0, column=3)

        self.modelo_label.grid(row=1, column=0)
        self.modelo_entry.grid(row=1, column=1)

        self.adquisicionFecha_label.grid(row=1, column=2)
        self.adquisicionFecha_entry.grid(row=1, column=3)

        self.so_label.grid(row=2, column=0)
        self.so_menu.grid(row=2, column=1)

        self.estadoLabel.grid(row=2, column=2)
        self.estadoMenu.grid(row=2, column=3)

        self.descripcionLabel.grid(row=3, column=0)
        self.descripcionEntry.grid(row=3, column=1)

        self.loadImageBtn = tk.Button(self,text="Cargar Imagen", command=self.openFile,bg='pink')
        self.loadImageBtn.grid(row=4,column=3)

        # Crear el botón para enviar los datos
        self.enviar_button = tk.Button(self, text="Guardar", command=self.verifyAndInsertNewLaptop, bg='green')
        self.enviar_button.grid(row=5, column=2, columnspan=2)

        self.close_button = tk.Button(self, text="Cerrar", command=self.destroy, bg='red')
        self.close_button.grid(row=5, column=3, columnspan=2)

        self.fileLink = ''
        self.etiquetaMsg = Label(self, text="")

    def readFile(self):
        try:
            self.fileLink = filedialog.askopenfile(title="Abrir",filetypes=(('Imagenes JPG',"*.jpg"),('Imagenes PNG','*.png')))
            print(self.fileLink.name)
        except(Exception) as error:
            self.fileLink = ''
            print('No se eligio una imagen',self.fileLink)    


    def getSOList(self):
        listSONames = self.db.getSONames() 
        for i in range(len(listSONames)):
             listSONames[i] = listSONames[i].getSONames

        #print(listSONames)    
        return listSONames  

    def getMarcasList(self):
        listMarcasNames = self.db.getMarcasNames() 
        for i in range(len(listMarcasNames)):
             listMarcasNames[i] = listMarcasNames[i].getMarcasLaptopsNames

        #print(listSONames)    
        return listMarcasNames  

    def verifyAndInsertNewLaptop(self):
        serialNumber = ''
        marca = ''
        modelo = ''
        sistemaOperativo = ''
        fechaAdquisicion = ''
        descipcion = 'Ninguna'
        estado = ''

        if self.marca_defaultText.get() != '':
             marca =  self.marca_defaultText.get()

        if self.so_defaultText.get() != '':
             sistemaOperativo =  self.so_defaultText.get() 

        if self.descripcionEntry.get() != '':
             descipcion =  self.descripcionEntry.get()

        if self.estado_defaultText.get() != '':
             estado = self.estado_defaultText.get() 

        if self.serialNum_entry.get() != '' and self.modelo_entry.get() != '' and self.adquisicionFecha_entry.get() != '':
            serialNumber =  self.serialNum_entry.get()
            modelo =  self.modelo_entry.get()
            fechaAdquisicion = self.adquisicionFecha_entry.get()
            res = self.db.insertNewLaptop(serialNumber,marca,modelo,sistemaOperativo,fechaAdquisicion,descipcion,estado)
            self.printLabel(res.insertNewLaptop,'green')          
        else:
             self.printLabel("El numero Serial, modelo y Fecha de adquisicion no deben estar vacios",'red')      
                
             
    def printLabel(self,mensaje,color):
        self.etiquetaMsg.destroy()
        self.etiquetaMsg = tk.Label(self, text=mensaje)
        self.etiquetaMsg.config(fg=color)
        self.etiquetaMsg.grid(row=5, column=1)    

class VentanaNewUser(Tk):
    def __init__(self,database):
        # Crear la ventana principal
        super().__init__()
        self.geometry("580x150")
        self.title("Crear Nuevo Usuario")

        self.db = database

        # Crear los widgets de entrada
        self.newUsrname_label = tk.Label(self, text="Insertar Nuevo Nombre de Usuario:")
        self.newUsrname_entry = tk.Entry(self)

        self.newPsw_label = tk.Label(self, text="Insertar Nueva Contraseña:")
        self.newPsw_entry = tk.Entry(self)

        self.rol_label = tk.Label(self, text="Rol que cumplira:")
        self.rol_defaultText = tk.StringVar(self)
        self.rol_defaultText.set("Maestro")
        self.roles_menu = tk.OptionMenu(self, self.rol_defaultText,*self.getRolList())

    
        # Organizar los widgets utilizando el sistema de grillas
        self.newUsrname_label.grid(row=0, column=0)
        self.newUsrname_entry.grid(row=0, column=1)

        self.newPsw_label.grid(row=1, column=0)
        self.newPsw_entry.grid(row=1, column=1)


        self.rol_label.grid(row=2, column=0)
        self.roles_menu.grid(row=2, column=1)


        # Crear el botón para enviar los datos
        self.enviar_button = tk.Button(self, text="Guardar", command=self.verifyAndCreateNewUser, bg= 'green')
        self.enviar_button.grid(row=3, column=1, columnspan=2)

        self.close_button = tk.Button(self, text="Cerrar", command=self.destroy, bg='red')
        self.close_button.grid(row=3, column=2, columnspan=2)

        self.etiquetaMsg = Label(self, text="")

    
    def getRolList(self):
        listRolesNames = self.db.getRolesNames() 
        for i in range(len(listRolesNames)):
             listRolesNames[i] = listRolesNames[i].getRolNames

        #print(listSONames)    
        return listRolesNames  


    def verifyAndCreateNewUser(self):
        newUsername = ''
        newPsw = ''
        rolName = ''

        if self.newUsrname_entry.get() == '':
            #print("El campo Username no debe ser vacio")
            self.printLabel("El campo Username no debe ser vacio",'red')
             
        elif self.newPsw_entry.get() == '':
            #print("El campo Password no debe ser vacio")
            self.printLabel("El campo Password no debe ser vacio",'red')
                
        elif self.rol_defaultText.get() == '':
            #print("El campo  Rol no debe ser vacio")
            self.printLabel("El campo  Rol no debe ser vacio",'red')

        else:     
             newUsername =  self.newUsrname_entry.get()
             newPsw = md5(self.newPsw_entry.get().encode("utf-8")).hexdigest()  
             rolName =  self.rol_defaultText.get()
             msg = self.db.createNewUser(newUsername,newPsw,rolName).createNewUser
             if msg == 'Ya existe una persona con este nombre de usuario':
                self.printLabel(msg,'red')
             if msg == 'Usuario creado exitosamente':
                self.printLabel(msg,'green')   
  
    def printLabel(self,mensaje,color):
        self.etiquetaMsg.destroy()
        self.etiquetaMsg = tk.Label(self, text=mensaje)
        self.etiquetaMsg.config(fg=color)
        self.etiquetaMsg.grid(row=4, column=0)            
        
class VentanaDeleteUser(Tk):
    def __init__(self,database):
        # Crear la ventana principal
        super().__init__()
        self.geometry("450x150")
        self.title("Eliminar Usuarios")

        self.db = database

        self.username_label = tk.Label(self, text="Lista de Nombres de Usuario disponibles para eliminar:")
        self.usnCurrentText = tk.StringVar(self)
        self.usnCurrentText.set("Username")
        self.username_menu = tk.OptionMenu(self, self.usnCurrentText,*self.getUsernameList())       

        self.username_label.pack()
        self.username_menu.pack()

        self.close_button = tk.Button(self, text="Eliminar", command=self.deleteUser, bg='red')
        self.close_button.pack()

        self.etiquetaMsg = Label(self, text="")

    def getUsernameList(self):
        listUsernames = self.db.getUsernames()
        for i in range(len(listUsernames)):
             listUsernames[i] = listUsernames[i].getUserNames
        return listUsernames
    
    def deleteUser(self):
        responseMsg = ''
        #print(self.usnCurrentText.get())
        if self.usnCurrentText.get() == 'Username':
            self.printLabel('DEBE ELEGIR UN USUARIO DE LA LISTA!!!','red')
        else:
            responseMsg = self.db.deleteUser(self.usnCurrentText.get())
            if responseMsg == 'No se encuentra el usuario ingresado':
                self.printLabel(responseMsg,'red')    
            else:
                self.printLabel(responseMsg,'green')
                print(responseMsg)
                self.destroy() 
                msgWindow = WindowMessage(responseMsg,'green')
                
    def printLabel(self,mensaje,color):
        self.etiquetaMsg.destroy()
        self.etiquetaMsg = tk.Label(self, text=mensaje)
        self.etiquetaMsg.config(fg=color)
        self.etiquetaMsg.pack()       


class WindowMessage(Tk):
    def __init__(self,message,color):
        # Crear la ventana principal
        super().__init__()
        self.geometry("260x60")
        self.title("Alerta")

        self.messageToShow = tk.Label(self, text=message,fg=color)
        self.messageToShow.pack()

        self.closeBtn = tk.Button(self, text="Aceptar", command=self.destroy, bg='green')
        self.closeBtn.pack()








# if __name__ == "__main__":
#     d = Database()
#     app = VentanaDeleteUser(d)
#     app.mainloop()

# e = VentanaNewLaptop(Database())
# e.getSOList()

#u = VentanaNewUser(Database())
#u.verifyAndCreateNewUser()
# Manual Tecnico

## Objetos Utilizados

### Usuario
<img width="2048" height="7542" alt="image" src="https://github.com/user-attachments/assets/4d3c8bb2-742b-43d2-89d8-a38a143ef84a" />

Nuestro objeto usuario es el encargado de almacenar toda la informacion sobre un usuario.

### Contacto
<img width="2048" height="4588" alt="image" src="https://github.com/user-attachments/assets/08d38b68-63d7-4817-b59e-742d0caeae8a" />

Nuestro objeto contacto es el encargado de almacenar toda la informacion sobre los contactos de un usuario.

### Correo
<img width="2048" height="4886" alt="image" src="https://github.com/user-attachments/assets/43921527-0e6b-43e0-9746-f842bd13c321" />

Nuestro objeto correo es el encargado de almacenar toda la informacion sobre los correos de un usuario.

## Estructuras Utilizadas

### Lista Usuarios
<img width="1702" height="7718" alt="image" src="https://github.com/user-attachments/assets/c691a633-9bd8-4cfb-b34b-3b2ae2f097c0" />

Lista Simplemente Enlazada que guarda a los usuarios registrados en el sistema.

### Lista Usuarios Circular
<img width="1736" height="6972" alt="image" src="https://github.com/user-attachments/assets/e67a5a4b-1115-49d3-9bf0-711370ec4a36" />

Lista Circular Doblemente Enlazada encargada de guardar los contactos de cada usuario en el sistema.

### Lista Correos
<img width="1838" height="7270" alt="image" src="https://github.com/user-attachments/assets/70c0bed0-4de0-4100-b460-b01f7c914608" />

Lista Doblemente Enlazadaa encargada de guardar los correos recibidos de cada usuario en el sistema.

### Pila Papelera
<img width="1752" height="5558" alt="image" src="https://github.com/user-attachments/assets/9934b261-479c-47e2-90f6-59df9eb7818c" />

Pila que almacena los correos localizados en la papelera del usuario.

### Cola Correos
<img width="1720" height="5668" alt="image" src="https://github.com/user-attachments/assets/dd10f311-0979-43de-9106-213f2de1b3b6" />

Cola que almacena los correos programados del usuario.

### Relaciones
<img width="1938" height="9468" alt="image" src="https://github.com/user-attachments/assets/571326ab-3898-4625-98bc-f7579fd97298" />

Matriz dispersa la cual almacena la cantidad de correos enviados entre usuarios dentro del sistema.

### Comunidad
<img width="2048" height="10400" alt="image" src="https://github.com/user-attachments/assets/804de696-a295-442f-a311-a24698a9a31b" />

Lista de lista la cual almacena las comunidades creadas y los usuarios que se encuentran dentro de estas(Integracion por Grupos).

## Globals
<img width="1010" height="938" alt="image" src="https://github.com/user-attachments/assets/849e4e81-0621-441a-b279-98352d5af450" />

Almacena informacion globalmente, el usuario que se encuentra logeado y la lista de usuarios registrados en el sistema.


# Arbol del directorio
── Fase1
├── Fase1.ico
├── Fase1.lpi
├── Fase1.lpr
├── Fase1.lps
├── Fase1.res
├── lib
│   └── x86_64-linux
├── Objetos
│   ├── contactos.pas
│   ├── correo.pas
│   └── usuario.pas
├── usuarios.json
├── Utilidades
│   └── globals.pas
└── Ventanas
    ├── actualizarperfil.lfm
    ├── actualizarperfil.pas
    ├── agregarcontacto.lfm
    ├── agregarcontacto.pas
    ├── backup
    ├── bandejaentrada.lfm
    ├── bandejaentrada.pas
    ├── crearcomunidadad.lfm
    ├── crearcomunidadad.pas
    ├── enviarcorreo.lfm
    ├── enviarcorreo.pas
    ├── enviarcorreop.lfm
    ├── enviarcorreop.pas
    ├── menuadmin.lfm
    ├── menuadmin.pas
    ├── menucrearcuenta.lfm
    ├── menucrearcuenta.pas
    ├── menuinicio.lfm
    ├── menuinicio.pas
    ├── menuusuario.lfm
    ├── menuusuario.pas
    ├── papelera.lfm
    ├── papelera.pas
    ├── programarcorreo.lfm
    ├── programarcorreo.pas
    ├── vercontactos.lfm
    ├── vercontactos.pas
    ├── vercorreo.lfm
    └── vercorreo.pas

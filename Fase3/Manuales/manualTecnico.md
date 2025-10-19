# Manual Tecnico

## Objetos Utilizados

### Usuario
<img width="2048" height="8790" alt="image" src="https://github.com/user-attachments/assets/4290c23a-0d99-413c-bcca-6e9853e4dfca" />

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

### Arbol AVL
<img width="2048" height="14124" alt="image" src="https://github.com/user-attachments/assets/4a819c5a-498e-402d-ac49-bf1e44e828be" />

Arbol AVL el cual se encarga de guardar los correos guardados como borradores.

### Arbol B De Grado 5
<img width="1954" height="18260" alt="image" src="https://github.com/user-attachments/assets/07e98cba-5776-4bc7-a689-b777bc494697" />

Arbol B el cual se encarga de guardar los correos seleccionados como favoritos.

### Arbol BST
<img width="2048" height="11406" alt="image" src="https://github.com/user-attachments/assets/09c67fc4-9484-4cdd-915b-53eb562e5c96" />

Arbol BST el cual se encarga de almacenar los mensajes enviados por los usuarios dentro de las comunidades(Integracion por Grupos)

## Globals
<img width="1010" height="938" alt="image" src="https://github.com/user-attachments/assets/849e4e81-0621-441a-b279-98352d5af450" />

Almacena informacion globalmente, el usuario que se encuentra logeado y la lista de usuarios registrados en el sistema.


# Arbol del directorio
-Fase2
├── backup
│   ├── actualizarperfil.lfm
│   ├── actualizarperfil.pas
│   ├── agregarcontacto.lfm
│   ├── agregarcontacto.pas
│   ├── bandejaentrada.lfm
│   ├── bandejaentrada.pas
│   ├── colacorreos.pas
│   ├── comunidades.pas
│   ├── contactos.pas
│   ├── correo.pas
│   ├── crearcomunidadad.lfm
│   ├── crearcomunidadad.pas
│   ├── enviarcorreo.lfm
│   ├── enviarcorreo.pas
│   ├── enviarcorreop.lfm
│   ├── enviarcorreop.pas
│   ├── Fase1.lpi
│   ├── Fase1.lpr
│   ├── Fase1.lps
│   ├── fase2.lpi
│   ├── fase2.lpr
│   ├── fase2.lps
│   ├── globals.pas
│   ├── listacorreos.pas
│   ├── listausuarioscircular.pas
│   ├── listausuarios.pas
│   ├── menuadmin.lfm
│   ├── menuadmin.pas
│   ├── menucrearcuenta.lfm
│   ├── menucrearcuenta.pas
│   ├── menuinicio.lfm
│   ├── menuinicio.pas
│   ├── menuusuario.lfm
│   ├── menuusuario.pas
│   ├── papelera.lfm
│   ├── papelera.pas
│   ├── pilapapelera.pas
│   ├── programarcorreo.lfm
│   ├── programarcorreo.pas
│   ├── relaciones.pas
│   ├── tiposusuarios.pas
│   ├── usuario.pas
│   ├── vercontactos.lfm
│   ├── vercontactos.pas
│   ├── vercorreo.lfm
│   └── vercorreo.pas
├── correosM.json
├── Estructuras
│   ├── avlborradores.pas
│   ├── backup
│   │   ├── avlborradores.pas
│   │   ├── bfavoritos.pas
│   │   ├── bstcomunidades.pas
│   │   ├── colacorreos.pas
│   │   ├── listacorreos.pas
│   │   ├── listausuarioscircular.pas
│   │   ├── listausuarios.pas
│   │   └── pilapapelera.pas
│   ├── bfavoritos.pas
│   ├── bstcomunidades.pas
│   ├── colacorreos.pas
│   ├── comunidades.pas
│   ├── listacorreos.pas
│   ├── listausuarioscircular.pas
│   ├── listausuarios.pas
│   ├── pilapapelera.pas
│   └── relaciones.pas
├── fase2
├── fase2.ico
├── fase2.lpi
├── fase2.lpr
├── fase2.lps
├── fase2.res
├── lib
│   └── x86_64-linux
│       ├── actualizarperfil.lfm
│       ├── actualizarperfil.o
│       ├── actualizarperfil.ppu
│       ├── agregarcontacto.lfm
│       ├── agregarcontacto.o
│       ├── agregarcontacto.ppu
│       ├── avlborradores.o
│       ├── avlborradores.ppu
│       ├── bandejaentrada.lfm
│       ├── bandejaentrada.o
│       ├── bandejaentrada.ppu
│       ├── bfavoritos.o
│       ├── bfavoritos.ppu
│       ├── borradores.lfm
│       ├── borradores.o
│       ├── borradores.ppu
│       ├── bstcomunidades.o
│       ├── bstcomunidades.ppu
│       ├── colacorreos.o
│       ├── colacorreos.ppu
│       ├── comunidades.o
│       ├── comunidades.ppu
│       ├── contactos.o
│       ├── contactos.ppu
│       ├── correo.o
│       ├── correo.ppu
│       ├── crearcomunidadad.lfm
│       ├── crearcomunidadad.o
│       ├── crearcomunidadad.ppu
│       ├── enviarcorreo.lfm
│       ├── enviarcorreo.o
│       ├── enviarcorreop.lfm
│       ├── enviarcorreop.o
│       ├── enviarcorreop.ppu
│       ├── enviarcorreo.ppu
│       ├── Fase1.compiled
│       ├── Fase1.o
│       ├── Fase1.or
│       ├── Fase1.res
│       ├── fase2.compiled
│       ├── fase2.o
│       ├── fase2.or
│       ├── fase2.res
│       ├── globals.o
│       ├── globals.ppu
│       ├── listacorreos.o
│       ├── listacorreos.ppu
│       ├── listausuarioscircular.o
│       ├── listausuarioscircular.ppu
│       ├── listausuarios.o
│       ├── listausuarios.ppu
│       ├── mensajescomunidad.lfm
│       ├── mensajescomunidad.o
│       ├── mensajescomunidad.ppu
│       ├── menuadmin.lfm
│       ├── menuadmin.o
│       ├── menuadmin.ppu
│       ├── menucrearcuenta.lfm
│       ├── menucrearcuenta.o
│       ├── menucrearcuenta.ppu
│       ├── menuinicio.lfm
│       ├── menuinicio.o
│       ├── menuinicio.ppu
│       ├── menuusuario.lfm
│       ├── menuusuario.o
│       ├── menuusuario.ppu
│       ├── papelera.lfm
│       ├── papelera.o
│       ├── papelera.ppu
│       ├── pilapapelera.o
│       ├── pilapapelera.ppu
│       ├── programarcorreo.lfm
│       ├── programarcorreo.o
│       ├── programarcorreo.ppu
│       ├── relaciones.o
│       ├── relaciones.ppu
│       ├── usuario.o
│       ├── usuario.ppu
│       ├── verborrador.lfm
│       ├── verborrador.o
│       ├── verborrador.ppu
│       ├── vercontactos.lfm
│       ├── vercontactos.o
│       ├── vercontactos.ppu
│       ├── vercorreo.lfm
│       ├── vercorreo.o
│       ├── vercorreo.ppu
│       ├── verfavorito.lfm
│       ├── verfavorito.o
│       ├── verfavorito.ppu
│       ├── verfavoritos.lfm
│       ├── verfavoritos.o
│       └── verfavoritos.ppu
├── Manuales
│   ├── Manual de Integracion.pdf
│   ├── manualTecnico.md
│   └── ManualUsuario.md
├── Objetos
│   ├── backup
│   │   └── usuario.pas
│   ├── contactos.pas
│   ├── correo.pas
│   └── usuario.pas
├── relaciones.pas
├── usuariosM.json
├── Utilidades
│   └── globals.pas
└── Ventanas
    ├── actualizarperfil.lfm
    ├── actualizarperfil.pas
    ├── agregarcontacto.lfm
    ├── agregarcontacto.pas
    ├── backup
    │   ├── bandejaentrada.lfm
    │   ├── bandejaentrada.pas
    │   ├── borradores.lfm
    │   ├── borradores.pas
    │   ├── crearcomunidadad.lfm
    │   ├── crearcomunidadad.pas
    │   ├── enviarcorreo.lfm
    │   ├── enviarcorreo.pas
    │   ├── enviarcorreop.pas
    │   ├── mensajescomunidad.lfm
    │   ├── mensajescomunidad.pas
    │   ├── menuadmin.lfm
    │   ├── menuadmin.pas
    │   ├── menucrearcuenta.pas
    │   ├── menuinicio.lfm
    │   ├── menuinicio.pas
    │   ├── menuusuario.lfm
    │   ├── menuusuario.pas
    │   ├── papelera.pas
    │   ├── verborrador.lfm
    │   ├── verborrador.pas
    │   ├── vercontactos.lfm
    │   ├── vercontactos.pas
    │   ├── vercorreo.lfm
    │   ├── vercorreo.pas
    │   ├── verfavorito.lfm
    │   ├── verfavorito.pas
    │   ├── verfavoritos.lfm
    │   └── verfavoritos.pas
    ├── bandejaentrada.lfm
    ├── bandejaentrada.pas
    ├── borradores.lfm
    ├── borradores.pas
    ├── crearcomunidadad.lfm
    ├── crearcomunidadad.pas
    ├── enviarcorreo.lfm
    ├── enviarcorreo.pas
    ├── enviarcorreop.lfm
    ├── enviarcorreop.pas
    ├── mensajescomunidad.lfm
    ├── mensajescomunidad.pas
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
    ├── verborrador.lfm
    ├── verborrador.pas
    ├── vercontactos.lfm
    ├── vercontactos.pas
    ├── vercorreo.lfm
    ├── vercorreo.pas
    ├── verfavorito.lfm
    ├── verfavorito.pas
    ├── verfavoritos.lfm
    └── verfavoritos.pas

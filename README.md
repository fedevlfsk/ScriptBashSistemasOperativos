# Bash Script de funcionalidades varias

Este proyecto es un **script en Bash** que ofrece tres herramientas básicas para usuarios de Linux o Windows (a través de Git Bash):  
- **Respaldar directorios**  
- **Generar un informe general del sistema**  
- **Limpiar archivos temporales**

Está propuesto como una utilidad sencilla para practicar scripting en Bash y automatización de tareas básicas del sistema.

## **Instrucciones de uso**

### Ejecución del script
1. Abrí una terminal (en Linux o Git Bash en Windows).  
2. Navegá hasta la carpeta donde guardaste el archivo del script.  
3. Asignale permisos de ejecución (solo si estás en Linux):
-------------------------------------------------------------
```bash
chmod +x script.sh
```

4. Luego simplemente ejecutas el programa con Bash:
(En Windows puedes darle doble click al archivo simplemente)
```bash
bash script.sh
```


## Funcionalidades
**1. Respaldar directorio**

Permite crear un archivo comprimido (.tar.gz) con el contenido de una carpeta.
Ejemplo de uso:

Ingrese el directorio a respaldar:
```bash
/home/usuario/Documentos
```
Ingrese donde guardar el backup:
```bash
/home/usuario/Backups
```

**ADVERTENCIA:** Recuerde que las direcciones en el Bash de Windows se escriben diferente a como son normalmente. 
el directorio de Windows debe ser algo como:
```bash
/c/Users/Nombre/Documentos
```
Y no algo como: C:\Users\Federico\Documents

El script creará un archivo con la siguiente estructura:
```bash
/home/fede/Backups/backup_fecha.tar.gz
```
**2. Informe del sistema**

Genera un informe que incluye:

**- Fecha actual**
**- Uso de CPU**
**- Memoria disponible y utilizada**
**- Espacio en disco**

**3. Limpiar temporales**

Elimina archivos temporales del sistema y cachés para liberar espacio en el disco.

**Licencia**
Este software es de dominio público.

Cualquiera puede usar, copiar, modificar, publicar o distribuir copias de este software, para cualquier propósito, sin restricción alguna.

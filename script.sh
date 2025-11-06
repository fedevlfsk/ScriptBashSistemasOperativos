#!/bin/bash

# Detectar sistema operativo
OS=$(uname -s)  # uname -s devuelve el nombre del sistema

if [[ "$OS" == "Linux" ]]; then
    # En Linux, los temporales están en /tmp y ~/.cache
    TMP_DIR="/tmp"
    CACHE_DIR="$HOME/.cache"
elif [[ "$OS" == "MINGW"* || "$OS" == "CYGWIN"* ]]; then
    # En Windows con Git Bash o Cygwin, se usan rutas equivalentes
    TMP_DIR="/c/Users/$USERNAME/AppData/Local/Temp"
    CACHE_DIR="/c/Users/$USERNAME/AppData/Local/Temp"
else
    # Si no se encuentra el OS significa que no está soportado.
    echo "Sistema operativo no soportado."
    exit 1
fi

# ===========================
# Respaldar directorio
# ===========================
backup() {
    echo "Ingrese el directorio a respaldar:"
    read dir  # Se lee la ruta del directorio
    echo "Ingrese donde guardar el backup:"
    read destino  # Se lee la ruta donde se guardará el backup
    fecha=$(date)
    mkdir -p "$destino"  # Crear carpeta destino si no existe
    tar -czf "$destino/backup_$fecha.tar.gz" "$dir"  # Crear backup comprimido
    echo "Backup guardado en $destino/backup_$fecha.tar.gz"
}

# ===========================
# Generar informe del sistema
# ===========================
informe() {
    LOG_FILE="$HOME/informe_sistema_$(date).log"  # Archivo con fecha

    {
        echo "=== INFORME DEL SISTEMA ==="
        echo "Fecha: $(date)"
        echo ""

        echo "CPU:"
        if [[ "$OS" == "Linux" ]]; then
            top -b -n1 | head -5  # Linux: mostrar uso de CPU con top
        else
            wmic cpu get loadpercentage  # Windows: mostrar porcentaje de CPU
        fi
        echo ""

        echo "Memoria:"
        if [[ "$OS" == "Linux" ]]; then
            free -h  # Linux: mostrar memoria
        else
            wmic OS get FreePhysicalMemory,TotalVisibleMemorySize  # Windows: memoria libre y total en KB
        fi
        echo ""

        echo "Disco:"
        if [[ "$OS" == "Linux" ]]; then
            df -h  # Muestra el uso de disco de todas las particiones en formato legible
        else
            wmic logicaldisk get size,freespace,caption  # Espacio libre y capacidad total
        fi
        echo ""

    } | tee "$LOG_FILE"   # Muestra en pantalla y guarda en archivo

    echo "Informe guardado en: $LOG_FILE"
}


# ===========================
# Limpiar archivos temporales
# ===========================
limpiar() {
    echo "Limpiando archivos temporales..."
    # r = recursivo, elimina subcarpetas, f forza aunque el usuario no tenga permisos completos
    rm -rf "$TMP_DIR"/* 2>/dev/null  # Eliminar archivos temporales
    rm -rf "$CACHE_DIR"/* 2>/dev/null  # Limpiar cache
    echo "Archivos temporales eliminados"
}

# ===========================
# Menú principal
# ===========================
while true; do
    echo ""
    echo "=== MENÚ DE SCRIPT ==="
    echo "1) Respaldar directorio"
    echo "2) Informe del sistema"
    echo "3) Limpiar temporales"
    echo "4) Salir"
    echo "Elija una opción:"
    read opcion  # Leer opción del usuario

    # Ejecutar la función correspondiente según la opción
    case $opcion in
        1) backup ;;
        2) informe ;;
        3) limpiar ;;
        4) echo "Saliendo..."; exit ;;  # Salir del script
        *) echo "Opción no válida" ;;  # Validación default
    esac
done




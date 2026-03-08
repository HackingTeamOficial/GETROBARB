#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════════
# GETROBARB XSS Scanner - Framework de Escaneo XSS By AnonSec777 Para Hacking Team
# Herramientas: subfinder, httpx, katana, gospider, waybackurls, urless, dalfox
# ═══════════════════════════════════════════════════════════════════════════════

# Añadir go/bin al PATH
export PATH=$PATH:$HOME/go/bin:/usr/local/go/bin

VERSION="1.0"
AUTHOR="@hackingteamprohackers"

# ─── COLORES ─────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
WHITE='\033[0;37m'
BOLD='\033[1m'
RESET='\033[0m'

# ─── BANNER ─────────────────────────────────────────────────────────────────
banner() {
    echo -e "${MAGENTA}${BOLD}"
    echo "  ██████╗ ███████╗████████╗██████╗  ██████╗ ██████╗  █████╗ ██████╗ ██████╗ "
    echo " ██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗"
    echo " ██║  ███╗█████╗     ██║   ██████╔╝██║   ██║██████╔╝███████║██████╔╝██████╔╝"
    echo " ██║   ██║██╔══╝     ██║   ██╔══██╗██║   ██║██╔══██╗██╔══██║██╔══██╗██╔══██╗"
    echo " ╚██████╔╝███████╗   ██║   ██║  ██║╚██████╔╝██████╔╝██║  ██║██║  ██║██████╔╝"
    echo "  ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ "
    echo -e "${RESET}"
    echo -e "${CYAN}[${VERSION}] ${WHITE}GETROBARB XSS Scanner Framework By AnonSec777${RESET}"
    echo -e "${YELLOW}[!] Úsalo solo en sistemas con autorización${RESET}"
    echo ""
}

# ─── HELPERS ─────────────────────────────────────────────────────────────────
usage() {
    echo -e "${BOLD}Uso: $0 [OPCIÓN] [ARGS]${RESET}"
    echo ""
    echo -e "${BOLD}Opciones:${RESET}"
    echo "  1) subfinder    - Enumerar subdominios"
    echo "  2) httpx        - Verificar hosts vivos"
    echo "  3) katana       - Crawling de URLs"
    echo "  4) urlfinder    - Buscar URLs en fuentes públicas"
    echo "  5) wayback      - URLs desde Wayback Machine"
    echo "  6) merge        - Unir todas las URLs"
    echo "  7) params       - Extraer URLs con parámetros"
    echo "  8) urless       - Limpiar parámetros"
    echo "  9) dalfox       - Escaneo XSS"
    echo "  10) all         - Ejecutar todo el workflow completo"
    echo "  11) help        - Mostrar esta ayuda"
    echo ""
    echo -e "${BOLD}Ejemplos:${RESET}"
    echo "  $0 subfinder ejemplo.com"
    echo "  $0 all ejemplo.com"
    echo "  $0 dalfox clean_params.txt"
    echo ""
}

# ─── CHECK ETICO ─────────────────────────────────────────────────────────────
check_ethical() {
    echo -e "${RED}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════════════╗"
    echo "║                      ⚠️  AVISO ÉTICO  ⚠️                          ║"
    echo "╠══════════════════════════════════════════════════════════════════════╣"
    echo "║  Esta herramienta es para USO ÉTICO y LEGAL únicamente.             ║"
    echo "║                                                                      ║"
    echo "║  ✅ SOLO usar en sistemas con AUTORIZACIÓN ESCRITA                  ║"
    echo "║  ✅ Usar para PENTESTS autorizados                                 ║"
    echo "║  ✅ Usar en CTFs y LABORATORIOS de práctica                         ║"
    echo "║                                                                      ║"
    echo "║  ❌ NO usar para atacar sistemas sin autorización                   ║"
    echo "║                                                                      ║"
    echo "╚══════════════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    echo -ne "${YELLOW}[?] ¿Aceptas los términos éticos? (si/no): ${RESET}"
    read -r response
    
    case "$response" in
        si|SI|Sí|sí|s|S|y|Y|yes|YES)
            echo -e "${GREEN}[✓] Continuando...${RESET}"
            ;;
        *)
            echo -e "${RED}[✗] Saliendo.${RESET}"
            exit 0
            ;;
    esac
}

# ─── TOOLS CHECK ────────────────────────────────────────────────────────────
check_tools() {
    echo -e "${BLUE}[*] Verificando herramientas...${RESET}"
    
    tools=("subfinder" "httpx" "katana" "gospider" "waybackurls" "urless" "dalfox" "dnsx")
    missing=()
    
    for tool in "${tools[@]}"; do
        if command -v "$tool" &> /dev/null || [ -f "$HOME/go/bin/$tool" ]; then
            echo -e "  ${GREEN}✓${RESET} $tool"
        else
            echo -e "  ${RED}✗${RESET} $tool (no encontrado)"
            missing+=("$tool")
        fi
    done
    
    if [ ${#missing[@]} -gt 0 ]; then
        echo -e "${YELLOW}[!] Herramientas faltantes: ${missing[*]}${RESET}"
        echo -e "${YELLOW}[!] Instala con: go install github.com/...${RESET}"
    fi
    echo ""
}

# ─── FUNCIONES ───────────────────────────────────────────────────────────────

# 1) Subfinder
do_subfinder() {
    target="$1"
    output="${2:-subs.txt}"
    
    echo -e "${CYAN}[1/9] ${WHITE}Enumerando subdominios con subfinder...${RESET}"
    
    if [ -z "$target" ]; then
        echo -e "${RED}Error: Falta target${RESET}"
        return 1
    fi
    
    if [[ "$target" == *.txt ]]; then
        # Es un archivo de targets
        cat "$target" | subfinder -all -silent > "$output" 2>/dev/null
    else
        # Es un target único
        echo "$target" | subfinder -all -silent > "$output" 2>/dev/null
    fi
    
    count=$(wc -l < "$output" 2>/dev/null || echo 0)
    echo -e "${GREEN}[✓] Subdominios encontrados: $count → $output${RESET}"
}

# 2) Httpx
do_httpx() {
    input="${1:-subs.txt}"
    output="${2:-alive.txt}"
    
    echo -e "${CYAN}[2/9] ${WHITE}Verificando hosts vivos con httpx...${RESET}"
    
    if [ ! -f "$input" ]; then
        echo -e "${RED}Error: No existe $input${RESET}"
        return 1
    fi
    
    httpx -list "$input" -mc 200,301,302,403 -silent -threads 50 -o "$output" 2>/dev/null
    
    count=$(wc -l < "$output" 2>/dev/null || echo 0)
    echo -e "${GREEN}[✓] Hosts vivos: $count → $output${RESET}"
}

# 3) Katana
do_katana() {
    input="${1:-alive.txt}"
    output="${2:-katana.txt}"
    
    echo -e "${CYAN}[3/9] ${WHITE}Crawling con katana...${RESET}"
    
    if [ ! -f "$input" ]; then
        echo -e "${RED}Error: No existe $input${RESET}"
        return 1
    fi
    
    katana -list "$input" -d 5 -jc -kf all -silent -o "$output" 2>/dev/null
    
    count=$(wc -l < "$output" 2>/dev/null || echo 0)
    echo -e "${GREEN}[✓] URLs encontradas: $count → $output${RESET}"
}

# 4) Gospider (alternativa a urlfinder)
do_gospider() {
    input="${1:-alive.txt}"
    output="${2:-gospider.txt}"
    
    echo -e "${CYAN}[4/9] ${WHITE}Buscando URLs con gospider...${RESET}"
    
    if [ ! -f "$input" ]; then
        echo -e "${RED}Error: No existe $input${RESET}"
        return 1
    fi
    
    # Verificar si gospider está instalado
    if command -v gospider &> /dev/null; then
        gospider -S "$input" -t 5 -q -o "$output" 2>/dev/null
        # Extraer URLs del output
        grep -oP 'https?://[^\s"]+' "$output" 2>/dev/null | sort -u > "${output}_urls.txt"
        mv "${output}_urls.txt" "$output"
    else
        echo -e "${YELLOW}[!] gospider no encontrado, usando katana como alternativa${RESET}"
        # katana ya collecta URLs, simplemente copiar
        if [ -f "katana.txt" ]; then
            cp katana.txt "$output"
        fi
    fi
    
    count=$(wc -l < "$output" 2>/dev/null || echo 0)
    echo -e "${GREEN}[✓] URLs encontradas: $count → $output${RESET}"
}

# 5) Waybackurls
do_wayback() {
    input="${1:-subs.txt}"
    output="${2:-wayback.txt}"
    
    echo -e "${CYAN}[5/9] ${WHITE}Extrayendo URLs de Wayback Machine...${RESET}"
    
    if [ ! -f "$input" ]; then
        echo -e "${RED}Error: No existe $input${RESET}"
        return 1
    fi
    
    cat "$input" | waybackurls 2>/dev/null | sort -u > "$output"
    
    count=$(wc -l < "$output" 2>/dev/null || echo 0)
    echo -e "${GREEN}[✓] URLs de Wayback: $count → $output${RESET}"
}

# 6) Merge
do_merge() {
    output="${1:-all_urls.txt}"
    
    echo -e "${CYAN}[6/9] ${WHITE}Uniendo todas las URLs...${RESET}"
    
    files=("katana.txt" "gospider.txt" "wayback.txt")
    
    # Combinar y deduplicar
    > "$output"
    for f in "${files[@]}"; do
        if [ -f "$f" ]; then
            cat "$f" >> "$output"
        fi
    done
    
    sort -u "$output" -o "$output"
    
    count=$(wc -l < "$output" 2>/dev/null || echo 0)
    echo -e "${GREEN}[✓] URLs únicas: $count → $output${RESET}"
}

# 7) Params
do_params() {
    input="${1:-all_urls.txt}"
    output="${2:-params.txt}"
    
    echo -e "${CYAN}[7/9] ${WHITE}Extrayendo URLs con parámetros...${RESET}"
    
    if [ ! -f "$input" ]; then
        echo -e "${RED}Error: No existe $input${RESET}"
        return 1
    fi
    
    grep '=' "$input" | sort -u > "$output"
    
    count=$(wc -l < "$output" 2>/dev/null || echo 0)
    echo -e "${GREEN}[✓] URLs con parámetros: $count → $output${RESET}"
}

# 8) Urless
do_urless() {
    input="${1:-params.txt}"
    output="${2:-clean_params.txt}"
    
    echo -e "${CYAN}[8/9] ${WHITE}Limpiando parámetros con urless...${RESET}"
    
    if [ ! -f "$input" ]; then
        echo -e "${RED}Error: No existe $input${RESET}"
        return 1
    fi
    
    if command -v urless &> /dev/null; then
        urless -i "$input" -o "$output" 2>/dev/null
    else
        # Fallback: eliminar duplicados de parámetros
        echo -e "${YELLOW}[!] urless no encontrado, usando método alternativo${RESET}"
        cat "$input" | sed 's/=.*/=/' | sort -u > "$output"
    fi
    
    count=$(wc -l < "$output" 2>/dev/null || echo 0)
    echo -e "${GREEN}[✓] Parámetros únicos: $count → $output${RESET}"
}

# 9) Dalfox
do_dalfox() {
    input="${1:-clean_params.txt}"
    output="${2:-xss_findings.txt}"
    
    echo -e "${CYAN}[9/9] ${WHITE}Escaneo XSS con dalfox...${RESET}"
    
    if [ ! -f "$input" ]; then
        echo -e "${RED}Error: No existe $input${RESET}"
        return 1
    fi
    
    # Verificar que hay URLs
    count=$(wc -l < "$input" 2>/dev/null || echo 0)
    if [ "$count" -eq 0 ]; then
        echo -e "${YELLOW}[!] No hay parámetros para escanear${RESET}"
        return
    fi
    
    echo -e "${YELLOW}[!] Escaneando $count URLs... (Ctrl+C para detener)${RESET}"
    
    dalfox file "$input" --blind "your@email.com" -o "$output" 2>/dev/null
    
    findings=$(wc -l < "$output" 2>/dev/null || echo 0)
    echo -e "${GREEN}[✓] XSS findings: $findings → $output${RESET}"
}

# Workflow completo
do_all() {
    target="$1"
    
    echo -e "${MAGENTA}[*] Iniciando workflow completo para: $target${RESET}"
    echo ""
    
    # 1. Subfinder
    do_subfinder "$target" "subs.txt"
    
    # 2. Httpx
    do_httpx "subs.txt" "alive.txt"
    
    # 3. Katana
    do_katana "alive.txt" "katana.txt"
    
    # 4. Gospider
    do_gospider "alive.txt" "gospider.txt"
    
    # 5. Wayback
    do_wayback "subs.txt" "wayback.txt"
    
    # 6. Merge
    do_merge "all_urls.txt"
    
    # 7. Params
    do_params "all_urls.txt" "params.txt"
    
    # 8. Urless
    do_urless "params.txt" "clean_params.txt"
    
    # 9. Dalfox
    do_dalfox "clean_params.txt" "xss_findings.txt"
    
    echo ""
    echo -e "${GREEN}${BOLD}╔══════════════════════════════════════════════════════════════╗"
    echo "║                    ESCANEO COMPLETADO                          ║"
    echo -e "╚══════════════════════════════════════════════════════════════╝${RESET}"
    
    # Mostrar resumen
    echo -e "${BOLD}Resultados:${RESET}"
    [ -f "subs.txt" ] && echo -e "  • Subdominios: $(wc -l < subs.txt)"
    [ -f "alive.txt" ] && echo -e "  • Hosts vivos: $(wc -l < alive.txt)"
    [ -f "all_urls.txt" ] && echo -e "  • URLs totales: $(wc -l < all_urls.txt)"
    [ -f "params.txt" ] && echo -e "  • URLs con params: $(wc -l < params.txt)"
    [ -f "xss_findings.txt" ] && echo -e "  • XSS encontrados: $(wc -l < xss_findings.txt)"
}

# ─── MAIN ───────────────────────────────────────────────────────────────────
main() {
    banner
    
    # Check ético
    check_ethical
    
    # Verificar herramientas
    check_tools
    
    # Procesar argumentos
    case "$1" in
        1|subfinder)
            do_subfinder "$2" "$3"
            ;;
        2|httpx)
            do_httpx "$2" "$3"
            ;;
        3|katana)
            do_katana "$2" "$3"
            ;;
        4|gospider)
            do_gospider "$2" "$3"
            ;;
        5|wayback)
            do_wayback "$2" "$3"
            ;;
        6|merge)
            do_merge "$2"
            ;;
        7|params)
            do_params "$2" "$3"
            ;;
        8|urless)
            do_urless "$2" "$3"
            ;;
        9|dalfox)
            do_dalfox "$2" "$3"
            ;;
        all)
            do_all "$2"
            ;;
        help|--help|-h)
            usage
            ;;
        *)
            usage
            ;;
    esac
}

# Ejecutar
main "$@"

GETROBARB XSS Scanner es un framework automatizado de reconocimiento y detección de vulnerabilidades XSS (Cross-Site Scripting) escrito en Bash, diseñado para auditorías de seguridad web autorizadas. Integra varias utilidades populares del ecosistema de bug bounty y pentesting para automatizar todo el flujo de descubrimiento de endpoints vulnerables.

Descripción de la herramienta: GETROBARB XSS Scanner

GETROBARB XSS Scanner Framework es una herramienta de reconocimiento y escaneo XSS automatizado que combina múltiples utilidades de seguridad ofensiva para identificar posibles vulnerabilidades Cross-Site Scripting (XSS) en aplicaciones web.

El framework está orientado a pentesters, investigadores de seguridad y bug bounty hunters, permitiendo ejecutar un workflow completo de descubrimiento de subdominios, recolección de URLs, extracción de parámetros y escaneo XSS desde una sola interfaz.

Fue desarrollado en Bash por AnonSec777 para el equipo Hacking Team.

Objetivo de la herramienta

El objetivo principal del framework es:

Automatizar el proceso de reconocimiento web

Descubrir subdominios activos

Recolectar URLs desde múltiples fuentes

Identificar parámetros potencialmente vulnerables

Ejecutar escaneo automático de XSS

Todo esto se ejecuta mediante un pipeline estructurado de 9 etapas.

Herramientas integradas

El framework utiliza varias herramientas de seguridad ampliamente utilizadas:

subfinder → enumeración de subdominios

httpx → verificación de hosts activos

katana → crawling de aplicaciones web

gospider → recolección avanzada de URLs

waybackurls → extracción de URLs históricas de Wayback Machine

urless → limpieza y normalización de parámetros

dalfox → escáner avanzado de vulnerabilidades XSS

dnsx → resolución DNS (verificación de dominios)

Estas herramientas están integradas en un workflow automatizado.

Flujo de funcionamiento (Workflow)

El escaneo completo se ejecuta en 9 etapas:

1️⃣ Enumeración de subdominios

Utiliza subfinder para descubrir subdominios asociados al dominio objetivo.

Salida:

subs.txt
2️⃣ Verificación de hosts activos

Usa httpx para comprobar qué subdominios responden.

Salida:

alive.txt
3️⃣ Crawling de aplicaciones

Utiliza katana para descubrir endpoints internos y rutas del sitio web.

Salida:

katana.txt
4️⃣ Spidering adicional

Utiliza gospider para recolectar más URLs mediante crawling.

Salida:

gospider.txt
5️⃣ Extracción de URLs históricas

Obtiene endpoints desde Wayback Machine mediante waybackurls.

Salida:

wayback.txt
6️⃣ Fusión de URLs

Combina todas las URLs recolectadas en un único archivo eliminando duplicados.

Salida:

all_urls.txt
7️⃣ Extracción de parámetros

Filtra URLs que contienen parámetros (=), ya que suelen ser vectores para XSS.

Salida:

params.txt
8️⃣ Limpieza de parámetros

Utiliza urless para normalizar parámetros y eliminar duplicados.

Salida:

clean_params.txt
9️⃣ Escaneo XSS

Ejecuta dalfox para detectar posibles vulnerabilidades XSS en los parámetros encontrados.

Salida:

xss_findings.txt
Funcionalidades principales

✔ Framework automatizado de reconocimiento web
✔ Pipeline completo para detección de XSS
✔ Integración con herramientas modernas de pentesting
✔ Escaneo modular (puede ejecutarse por fases)
✔ Escaneo completo con un solo comando
✔ Verificación de herramientas instaladas
✔ Aviso ético antes de ejecutar
✔ Salidas organizadas en archivos

Modo de uso

Ejecutar workflow completo:

./getrobarb.sh all ejemplo.com

Ejecutar solo un módulo:

./getrobarb.sh subfinder ejemplo.com

Escanear XSS desde lista de parámetros:

./getrobarb.sh dalfox clean_params.txt
Resultados generados

El framework genera varios archivos con los resultados:

Archivo	Contenido
subs.txt	subdominios encontrados
alive.txt	hosts activos
katana.txt	URLs descubiertas
gospider.txt	URLs adicionales
wayback.txt	URLs históricas
all_urls.txt	todas las URLs
params.txt	URLs con parámetros
clean_params.txt	parámetros normalizados
xss_findings.txt	posibles vulnerabilidades XSS

Casos de uso

La herramienta puede utilizarse en:

Pentesting web autorizado

Programas Bug Bounty

CTF y laboratorios de seguridad

Auditorías de seguridad web

Reconocimiento avanzado de aplicaciones web

Advertencia ética

El propio script incluye una verificación ética que recuerda que la herramienta debe utilizarse únicamente en:

Sistemas con autorización

Pentesting legal

Laboratorios de seguridad

✅ En resumen:

GETROBARB XSS Scanner es un framework automatizado de reconocimiento web y detección de XSS, que integra varias herramientas populares de pentesting para ejecutar un workflow completo de descubrimiento de vulnerabilidades de forma rápida y estructurada.

Telegram

https://t.me/PlantillasNucleiHackingTeam
https://t.me/HackingTeamGrupoOfficial
https://t.me/+0hHSaKO7eI9mNWY8 Hacking Team Difusion
https://t.me/+llcmNGzz6JIyMmI0 Biblioteca
https://t.me/TermuxHackingTeam

X

@HackingTeam777

Bluesky

https://bsky.app/profile/hackingteam.bsky.social

DiscordTelegram

https://t.me/PlantillasNucleiHackingTeam
https://t.me/HackingTeamGrupoOfficial
https://t.me/+0hHSaKO7eI9mNWY8 Hacking Team Difusion
https://t.me/+llcmNGzz6JIyMmI0 Biblioteca
https://t.me/TermuxHackingTeam

X

@HackingTeam777

Bluesky

https://bsky.app/profile/hackingteam.bsky.social

Discord

https://discord.gg/V4nPFbQX

Facebook 

https://www.facebook.com/groups/hackingteam2022/?ref=share
https://www.facebook.com/groups/HackingTeamCyber/?ref=share

Youtube 

https://www.youtube.com/@HackingTeamOfficial

Canal de tiktok 

https://www.tiktok.com/@hacking.kdea?_t=ZS-8vTtlaQrDTL&_r=1

#hackingteam #cibersecurity #infosec #eticalhacking #pentesting #dns #script #cracking #hack #security #bugbounty #payload #tools #exploit #cors #sqli #ssrf #python #c2 #poc #web #ramsomware #phishing #linux #osint #linux #windows #redteam #blueteam #spyware #digitalforensics #reverseengineeringtools #rat #malwareforensics #exploitdevelopment #sandboxing #apt #zerodayexploit #xss #github #cve #java #tools #termux #troyano    #dev #sqlmap #waybackurls #copilot #ai #ia #kalilinux #parrot #dracos #susse #nessus #oswazap #burpsuite #wireguar



# Guía de Traspaso para el Equipo de TI

Este documento explica cómo desplegar el "Sistema de Compra JDE" en los servidores de la empresa.

> [!IMPORTANT]
> **NO ES NECESARIO MODIFICAR EL CÓDIGO FUENTE.**
> El sistema está diseñado siguiendo el principio de "12-factor app". Toda la configuración (credenciales, IPs, llaves) se gestiona exclusivamente a través de **Variables de Entorno** (archivos `.env`). El equipo de TI solo debe configurar estos archivos sin tocar los archivos `.py` o `.tsx`.

## 1. El Concepto Clave: Aplicación vs. Infraestructura
El repositorio contiene la **Aplicación** (Frontend en React y Backend en FastAPI), pero esta aplicación requiere de una **Infraestructura de Servicios** para funcionar (Base de datos y el sistema de Login con Google).

Actualmente, estos servicios corren en una cuenta personal de **Supabase**. TI debe elegir uno de los siguientes caminos para el traspaso:

---

## 2. Estrategia de Despliegue: Supabase Local con Docker

Para este proyecto, la empresa ha optado por un **despliegue 100% local**. Esto significa que se instalarán todos los servicios (Base de datos y Autenticación) dentro de los servidores de la empresa usando Docker.

- **Ventaja**: Privacidad total; los datos y usuarios nunca salen de la red corporativa.
- **Qué hacer**: El equipo de TI debe seguir la [guía oficial de Supabase Self-Hosting](https://supabase.com/docs/guides/self-hosting/docker) para levantar la infraestructura base. Una vez instalada, este repositorio se conectará a dicha instancia local.

---

## 3. Checklist de Credenciales (Qué debe poner TI)

Como los archivos `.env` no se suben al repositorio por seguridad, el equipo de TI debe crear los suyos propios con esta información:

1.  **Base de Datos JDE**: Host, Puerto, Usuario y Password de la base de datos PostgreSQL de JDE.
2.  **Supabase Local**: Ellos generarán sus propias llaves (`URL`, `ANON_KEY`, `SERVICE_ROLE_KEY`) al levantar el contenedor de Supabase.
3.  **Google Auth**: Deben crear un "Client ID" y "Client Secret" en su consola de Google Cloud corporativa.

---

## 4. Configuración del Repositorio
TI encontrará estos archivos listos en la raíz para orquestar la aplicación:

- **`docker-compose.yml`**: Orquestación del Backend (FastAPI) y Frontend (Nginx).
- **`backend/Dockerfile`**: Configuración para el motor de lógica.
- **`frontend/Dockerfile`**: Configuración para compilar y servir la web.

### Pasos para TI:
1. **Configurar Variables**: Crear/Editar `/backend/.env` y `/frontend/.env.local` con el checklist del punto 3.
2. **Levantar**: Ejecutar `docker compose up -d --build`.

---

## 5. Migración de la Base de Datos (Estructura)
Para pasar los datos actuales (historial de compras) al nuevo servidor, el equipo de TI debe ejecutar el script SQL que se encuentra en `/database/schema.sql`. 

> [!NOTE] 
> Este archivo actúa como la **migración manual** del sistema. No es estrictamente necesario configurar el sistema de "Supabase Migrations CLI" a menos que TI prefiera ese flujo de trabajo avanzado. Con ejecutar este SQL es suficiente para que la App sea operativa.

---

## 6. Login de Google
TI deberá configurar un nuevo "Client ID" en la consola de Google Cloud vinculado a la dirección IP o dominio del nuevo servidor corporativo.

# Guía de Traspaso para el Equipo de TI

Este documento explica cómo desplegar el "Sistema de Compra JDE" en los servidores de la empresa.

## 1. El Concepto Clave: Aplicación vs. Infraestructura
El repositorio contiene la **Aplicación** (Frontend en React y Backend en FastAPI), pero esta aplicación requiere de una **Infraestructura de Servicios** para funcionar (Base de datos y el sistema de Login con Google).

Actualmente, estos servicios corren en una cuenta personal de **Supabase**. TI debe elegir uno de los siguientes caminos para el traspaso:

---

## 2. Opciones de Despliegue para TI

### Opción A: Supabase en la Nube (La más rápida)
La empresa crea su propia cuenta en [supabase.com](https://supabase.com).
- **Ventaja**: No requiere mantenimiento de servidores de base de datos. El Login de Google ya está integrado.
- **Qué hacer**: TI entrega las nuevas `URL` y `API KEYS` al desarrollador para actualizar los archivos `.env`.

### Opción B: Supabase Local con Docker (Privacidad Total)
Si la empresa no quiere usar la nube, deben instalar Supabase en sus propios servidores usando Docker.
- **Ventaja**: Los datos nunca salen de la red de la empresa.
- **Qué hacer**: Seguir la [guía oficial de Supabase Self-Hosting](https://supabase.com/docs/guides/self-hosting/docker). Una vez instalado, el repositorio de la aplicación se conecta a esa instancia local.

---

## 3. Configuración del Repositorio
Independientemente de la opción elegida, el equipo de TI encontrará estos archivos listos en la raíz:

- **`docker-compose.yml`**: Orquestación del Backend (FastAPI) y Frontend (Nginx).
- **`backend/Dockerfile`**: Configuración para levantar el servidor de lógica.
- **`frontend/Dockerfile`**: Configuración para compilar y servir la web.

### Pasos para TI:
1. **Configurar Variables**: Editar `/backend/.env` y `/frontend/.env.local` con las credenciales de la base de datos de la empresa y de JDE.
2. **Levantar**: Ejecutar `docker compose up -d --build`.

---

## 4. Migración de la Base de Datos
Para pasar los datos actuales (historial de compras) al nuevo servidor, TI debe ejecutar el script SQL que se encuentra en `/database/schema.sql` (contiene la estructura de las tablas `purchases` y `purchase_items`).

---

## 5. Login de Google
TI deberá configurar un nuevo "Client ID" en la consola de Google Cloud vinculado a la dirección IP o dominio del nuevo servidor para que el login siga funcionando.

# Guía de Traspaso para el Equipo de TI

Este documento explica cómo desplegar el "Sistema de Compra JDE" en los servidores de la empresa.

## 1. El Concepto Clave: Aplicación vs. Infraestructura
El repositorio contiene la **Aplicación** (Frontend en React y Backend en FastAPI), pero esta aplicación requiere de una **Infraestructura de Servicios** para funcionar (Base de datos y el sistema de Login con Google).

Actualmente, estos servicios corren en una cuenta personal de **Supabase**. TI debe elegir uno de los siguientes caminos para el traspaso:

---

## 2. Estrategia de Despliegue: Supabase Local con Docker

Para este proyecto, la empresa ha optado por un **despliegue 100% local**. Esto significa que se instalarán todos los servicios (Base de datos y Autenticación) dentro de los servidores de la empresa usando Docker.

- **Ventaja**: Privacidad total; los datos y usuarios nunca salen de la red corporativa.
- **Qué hacer**: El equipo de TI debe seguir la [guía oficial de Supabase Self-Hosting](https://supabase.com/docs/guides/self-hosting/docker) para levantar la infraestructura base. Una vez instalada, este repositorio se conectará a dicha instancia local.

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

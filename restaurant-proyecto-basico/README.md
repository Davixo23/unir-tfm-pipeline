# 🍽️ Restaurante Básico

Una aplicación web moderna para gestión de restaurantes construida con Next.js, Supabase y TypeScript. Este proyecto incluye un sistema completo de autenticación y una interfaz de usuario elegante desarrollada con Tailwind CSS y Radix UI.

## 🚀 Características

- ✅ Autenticación completa (registro, inicio de sesión, recuperación de contraseña)
- ✅ Sistema de usuarios con protección de rutas
- ✅ Interfaz moderna y responsiva
- ✅ Componentes UI reutilizables
- ✅ TypeScript para type safety
- ✅ Base de datos con Supabase
- ✅ Middleware para gestión de sesiones

## 📁 Estructura del Proyecto

```
restaurante-basico/
├── app/                          # App Router de Next.js 15
│   ├── auth/                     # Rutas de autenticación
│   │   ├── confirm/              # Confirmación de email
│   │   ├── error/                # Página de errores de auth
│   │   ├── forgot-password/      # Recuperación de contraseña
│   │   ├── login/                # Página de inicio de sesión
│   │   ├── sign-up/              # Página de registro
│   │   ├── sign-up-success/      # Confirmación de registro
│   │   └── update-password/      # Actualización de contraseña
│   ├── protected/                # Rutas protegidas
│   ├── globals.css               # Estilos globales
│   ├── layout.tsx                # Layout principal
│   └── page.tsx                  # Página de inicio
├── components/                   # Componentes React
│   ├── ui/                       # Componentes UI base (Radix UI + Tailwind)
│   │   ├── button.tsx
│   │   ├── input.tsx
│   │   ├── form.tsx
│   │   ├── card.tsx
│   │   ├── dialog.tsx
│   │   └── ... (otros componentes)
│   ├── login-form.tsx            # Formulario de login
│   ├── sign-up-form.tsx          # Formulario de registro
│   ├── forgot-password-form.tsx  # Formulario de recuperación
│   ├── update-password-form.tsx  # Formulario de actualización
│   └── logout-button.tsx         # Botón de cerrar sesión
├── lib/                          # Librerías y utilidades
│   ├── supabase/                 # Configuración de Supabase
│   │   ├── client.ts             # Cliente de Supabase (lado cliente)
│   │   ├── server.ts             # Cliente de Supabase (lado servidor)
│   │   └── middleware.ts         # Middleware de sesiones
│   └── utils.ts                  # Utilidades generales
├── middleware.ts                 # Middleware de Next.js
├── package.json                  # Dependencias y scripts
├── tsconfig.json                 # Configuración de TypeScript
├── tailwind.config.js            # Configuración de Tailwind CSS
└── next.config.ts                # Configuración de Next.js
```

## 🛠️ Tecnologías Utilizadas

- **[Next.js 15](https://nextjs.org/)** - Framework de React con App Router
- **[TypeScript](https://www.typescriptlang.org/)** - Superset tipado de JavaScript
- **[Supabase](https://supabase.com/)** - Backend como servicio (autenticación y base de datos)
- **[Tailwind CSS](https://tailwindcss.com/)** - Framework de CSS utility-first
- **[Radix UI](https://www.radix-ui.com/)** - Componentes UI accesibles
- **[React Hook Form](https://react-hook-form.com/)** - Gestión de formularios
- **[Zod](https://github.com/colinhacks/zod)** - Validación de esquemas TypeScript
- **[Drizzle ORM](https://orm.drizzle.team/)** - ORM TypeScript para SQL
- **[Lucide React](https://lucide.dev/)** - Iconos

## 📋 Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- **Node.js** 18.0 o superior
- **npm**, **yarn**, **pnpm** o **bun**
- Una cuenta en **[Supabase](https://supabase.com/)**

## ⚡ Instalación e Inicialización

### 1. Clonar el repositorio

```bash
git clone <url-del-repositorio>
cd restaurante-basico
```

### 2. Instalar dependencias

```bash
npm install
# o
yarn install
# o
pnpm install
# o
bun install
```

### 3. Configurar variables de entorno

Crea un archivo `.env.local` en la raíz del proyecto con las siguientes variables:

```bash
# Copia este contenido en tu archivo .env.local

# Configuración de Supabase
NEXT_PUBLIC_SUPABASE_URL=tu_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu_supabase_anon_key

# Opcional: URL base para producción
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

### 4. Cómo obtener las credenciales de Supabase

1. **Crear proyecto en Supabase:**
   - Ve a [https://supabase.com/](https://supabase.com/)
   - Crea una cuenta o inicia sesión
   - Crea un nuevo proyecto

2. **Obtener las credenciales:**
   - En tu proyecto de Supabase, ve a `Settings` → `API`
   - Copia el `Project URL` (será tu `NEXT_PUBLIC_SUPABASE_URL`)
   - Copia el `anon/public` key (será tu `NEXT_PUBLIC_SUPABASE_ANON_KEY`)

3. **Configurar autenticación:**
   - Ve a `Authentication` → `Settings`
   - En "Site URL", añade: `http://localhost:3000` (para desarrollo)
   - En "Redirect URLs", añade:
     - `http://localhost:3000/auth/confirm`
     - `http://localhost:3000/auth/callback`

### 5. Ejecutar el proyecto

```bash
npm run dev
# o
yarn dev
# o
pnpm dev
# o
bun dev
```

Abre [http://localhost:3000](http://localhost:3000) en tu navegador para ver la aplicación.

## 📝 Scripts Disponibles

```bash
# Desarrollo (con Turbopack para mayor velocidad)
npm run dev

# Construir para producción
npm run build

# Ejecutar versión de producción
npm run start

# Linting del código
npm run lint
```

## 🔐 Sistema de Autenticación

La aplicación incluye un sistema completo de autenticación con las siguientes funcionalidades:

- **Registro de usuarios** (`/auth/sign-up`)
- **Inicio de sesión** (`/auth/login`)
- **Recuperación de contraseña** (`/auth/forgot-password`)
- **Actualización de contraseña** (`/auth/update-password`)
- **Confirmación de email** (`/auth/confirm`)
- **Protección de rutas** mediante middleware
- **Gestión de sesiones** automática

### Rutas Protegidas

Las rutas bajo `/protected` requieren autenticación. El middleware automáticamente redirige a `/auth/login` si el usuario no está autenticado.

## 🎨 Componentes UI

El proyecto utiliza un sistema de diseño basado en:

- **Radix UI** para funcionalidad y accesibilidad
- **Tailwind CSS** para estilos
- **Class Variance Authority** para variantes de componentes
- **Lucide React** para iconografía

Los componentes están disponibles en `components/ui/` y son completamente reutilizables.

## 🔧 Configuración Adicional

### Base de Datos

El proyecto está configurado para usar Supabase como base de datos. Puedes:

1. Usar el editor SQL de Supabase para crear tablas
2. Importar esquemas SQL
3. Usar Drizzle ORM para migraciones programáticas

### Deployment

Para desplegar en Vercel:

1. Conecta tu repositorio a Vercel
2. Configura las variables de entorno en Vercel
3. Actualiza la `NEXT_PUBLIC_SITE_URL` con tu dominio de producción
4. Añade tu dominio de producción a las "Redirect URLs" en Supabase

## 🐛 Solución de Problemas

### Error de variables de entorno

Si obtienes errores relacionados con Supabase:
1. Verifica que el archivo `.env.local` existe y tiene las variables correctas
2. Reinicia el servidor de desarrollo después de crear/modificar `.env.local`
3. Asegúrate de que las URLs de Supabase no tienen espacios ni caracteres extra

### Problemas de autenticación

1. Verifica la configuración de "Site URL" y "Redirect URLs" en Supabase
2. Asegúrate de que el email de confirmación esté configurado correctamente
3. Revisa los logs en el panel de Supabase para más detalles

## 🤝 Contribución

1. Haz fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commitea tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 📞 Soporte

Si tienes preguntas o necesitas ayuda:

1. Revisa la documentación de [Next.js](https://nextjs.org/docs)
2. Consulta la documentación de [Supabase](https://supabase.com/docs)
3. Abre un issue en este repositorio

---

Desarrollado con ❤️ usando Next.js y Supabase

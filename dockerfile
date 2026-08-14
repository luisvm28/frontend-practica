# Etapa 1: Construcción (Build)
FROM node:20-alpine AS build
# Establecer el directorio de trabajo
WORKDIR /app
# Copiar package.json y package-lock.json (si existe)
COPY package*.json ./
# Instalar dependencias
RUN npm install
# Copiar el resto del código
COPY . .
# Construir la aplicación para producción
RUN npm run build
# Etapa 2: Servidor Web (Nginx)
FROM nginx:alpine
# Copiar los archivos construidos desde la etapa anterior al servidor Nginx
# NOTA: Dependiendo de tu framework (React/Vue/Angular), la carpeta de salida puede 
# llamarse 'build' o 'dist'. Cambia 'dist' por 'build' si es necesario.
COPY --from=build /app/dist /usr/share/nginx/html
# Exponer el puerto 3001
EXPOSE 3001
# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
# Etapa 1: Construcción (Build)
FROM node:20-alpine AS build
WORKDIR /app

# Copiar package.json y package-lock.json (si existe)
COPY package*.json ./

# Instalar dependencias
RUN npm install


# Copiar el resto del código
COPY . .


# Construir la aplicación para producción
RUN npm run build
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html
# Exponer el puerto 3001
EXPOSE 3001
# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
# Install Operating system and dependencies
FROM nginx:1.10.1-alpine

COPY build/web /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

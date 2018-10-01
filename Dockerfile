# Multi stage docker file for production
# Note build artifacts are in /app/build

#begin stage builder
FROM node:alpine as builder
WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build 
#end stage builder

# begin running stage
FROM nginx
# copy artifacts from previous stage
COPY --from=builder /app/build /usr/share/nginx/html
# end running stage

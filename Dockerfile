# This is to build the production app
# 1. Build Phase

# ... `as builder` is a tag that we are giving to this phase
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# 2. Run phase
FROM nginx
# copy from a different phase, using the tag
# destination path is from nginx docs
COPY --from=builder /app/build /usr/share/nginx/html

# Then it's possible to run:
# docker run -p 8080:80 <containerId>
# Where port 80 is the default nginx port
# And the container will start with the default command of the image.
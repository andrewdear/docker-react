FROM node:alpine

WORKDIR "/app"

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# this starts another phase to this docker file which then allows you to do something else, and it stops the prebiouse phase. to access the first phase just use 0
FROM nginx
# this goes copy the data from the last phase in its app/ build folder and put it into the nginx/hmtl folder in this new phase
COPY --from=0 /app/build /usr/share/nginx/html

#with nginx we do not need to put in a run command as its default setting will sort all that out for us

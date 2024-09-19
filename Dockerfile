FROM node:14 AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:14-alpine

RUN npm install -g serve

COPY --from=build /app/build /app/build

EXPOSE 5000

CMD ["serve", "-s", "/app/build", "-l", "5000"]

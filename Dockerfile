FROM node:16-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:16-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/dist /app
ARG VITE_API_BASE_URL
ENV PORT=5001
ENV NODE_ENV=production
ENV VITE_API_BASE_URL=http://a6d7ba1f5b265467094c559324bf8812-264841935.us-west-2.elb.amazonaws.com:5000/api
EXPOSE 5001
CMD ["serve", "-s", ".", "-l", "5001"]

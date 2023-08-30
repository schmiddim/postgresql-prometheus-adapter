#############################################
# Build
#############################################
FROM --platform=$BUILDPLATFORM golang:1.18-alpine as build

RUN apk upgrade --no-cache --force
RUN apk add --update build-base make git

WORKDIR /app

# Dependencies
COPY go.mod .
COPY go.sum . 
RUN go mod download

# Compile

COPY . .
ENV CGO_ENABLED=0
RUN make clean
RUN make 
RUN ls
#############################################
# Test
#############################################
FROM gcr.io/distroless/static as test
USER 0:0
WORKDIR /app
COPY --from=build /app/postgresql-prometheus-adapter .
RUN ["./postgresql-prometheus-adapter", "--help"]


#############################################
# Final
#############################################
FROM gcr.io/distroless/static

WORKDIR /
COPY --from=test /app .
USER 1000:1000
ENTRYPOINT ["/postgresql-prometheus-adapter"]
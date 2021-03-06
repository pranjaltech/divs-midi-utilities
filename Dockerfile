FROM alpine:latest as builder
RUN apk update && apk --no-cache add gcc g++ alsa-utils make alsa-lib-dev
RUN apk --no-cache add gtk+3.0 gtk+3.0-dev expat-dev wxgtk wxgtk-dev 
# sox libsox-fmt-mp3 <- to play mp3s

FROM builder as build1
COPY . /usr/
WORKDIR /usr/src/
RUN make all -f Makefile.unix

# FROM amd64/ubuntu:latest as builder
# COPY . /usr/
# WORKDIR /usr/src/
# RUN echo "Hello World"
# RUN apt-get update

#RUN apt-get update && install -y gcc g++ alsa-utils make libasound2-dev g++ libwxgtk3.0-gtk3-0v5 libwxgtk3.0-gtk3-dev libexpat1-dev
#RUN make all -f Makefile.unix
#ENV PATH=/usr/bin:$PATH
#WORKDIR /usr/data
#VOLUME ["bin:/usr/bin", "./data:/usr/data"]
#RUN lsmidiins
#CMD ["lsmidiins"]
#CMD ["brainstorm --in 1 --prefix session_ --timeout 10 --confirmation \"echo File Saved: %s >> log.txt\""]

#RUN gcc -o myapp main.c
#CMD ["./myapp"]

#ADD . .
#VOLUME ["./media/", "./logs/"]
#EXPOSE 9199 5432
#CMD sh start.sh

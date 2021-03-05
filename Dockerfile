FROM gcc:4.9
COPY . /usr/
WORKDIR /usr/src/
RUN apt update 
RUN apt upgrade -y
RUN apt install -y alsa-utils make libasound2-dev g++ libwxgtk3.0-gtk3-0v5 libwxgtk3.0-gtk3-dev libexpat1-dev
RUN make all -f Makefile.unix
ENV PATH=/usr/bin:$PATH
WORKDIR /usr/data
VOLUME ["bin:/usr/bin", "./data:/usr/data"]
CMD ["lsmidiins"]
#CMD ["brainstorm --in 1 --prefix session_ --timeout 10 --confirmation \"echo File Saved: %s >> log.txt\""]

#RUN gcc -o myapp main.c
#CMD ["./myapp"]

#ADD . .
#VOLUME ["./media/", "./logs/"]
#EXPOSE 9199 5432
#CMD sh start.sh

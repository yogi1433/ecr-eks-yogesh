FROM ubuntu:latest
ENV MY_NAME="Mobinulla"
ENV MY_COMPANY="ABJ"
LABEL Designedby="Mubeen" Email="smobinulla@gmail.com"
RUN apt update -y && apt install -y wget unzip net-tools tree vim nginx
RUN mkdir html
RUN wget https://www.free-css.com/assets/files/free-css-templates/download/page293/bricker.zip
RUN rm -rf /var/www/html
RUN unzip bricker.zip -d /var/www/html
EXPOSE 8080
CMD ["nginx","-g","daemon off;"]

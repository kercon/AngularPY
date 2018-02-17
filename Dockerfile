FROM ubuntu
RUN apt-get update
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb.list'
RUN apt-get update
RUN apt-get install -y mongodb-org
RUN apt-get install -y python-software-properties python-pip python-dev build-essential 
WORKDIR /app
ADD requirements.txt /app
RUN pip install --upgrade pip
RUN pip install --trusted-host pypi.python.org -r requirements.txt
RUN mkdir -p /data/db /data/configdb \
	&& chown -R mongodb:mongodb /data/db /data/configdb
VOLUME /data/db /data/configdb /app
EXPOSE 80 27017
ENV NAME World
CMD ["mongod", "python", "app.py"]

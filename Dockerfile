FROM phusion/passenger-ruby22

# install imagemagick
WORKDIR /tmp
ADD lib/ImageMagick-6.9.3-0.tar.gz /tmp/ImageMagick-6.9.3-0.tar.gz
WORKDIR /tmp/ImageMagick-6.9.3-0.tar.gz/ImageMagick-6.9.3-0
RUN chmod +x configure
RUN ./configure
RUN make
RUN sudo make install
RUN sudo ldconfig /usr/local/lib

# install node-v5.4.1
RUN sudo apt-get install make g++ libssl-dev git
WORKDIR /tmp
ADD lib/node-v5.4.1.tar.gz /tmp/node-v5.4.1.tar.gz
WORKDIR /tmp/node-v5.4.1.tar.gz/node-v5.4.1
RUN chmod +x configure
RUN ./configure
RUN make
RUN sudo make install

# install stunserver
RUN sudo apt-get update
RUN sudo apt-get install libboost-dev -y
ADD lib/stunserver-1.2.9.tgz /tmp/stunserver-1.2.9.tgz
WORKDIR /tmp/stunserver-1.2.9.tgz/stunserver
RUN make
RUN sudo cp stunserver /usr/sbin/stunserver
ADD config/stuntman-server/stuntman-server /etc/init.d/stuntman-server
RUN sudo chmod +x /etc/init.d/stuntman-server
RUN sudo service stuntman-server start


# Install signalmaster:
WORKDIR /tmp
RUN git clone https://github.com/andyet/signalmaster.git
WORKDIR /tmp/signalmaster
RUN npm install async node-uuid redis underscore precommit-hook getconfig yetify socket.io

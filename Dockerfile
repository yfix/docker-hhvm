FROM yfix/baseimage

MAINTAINER Yuri Vysotskiy (yfix) <yfix.dev@gmail.com>

ENV COMPOSER_HOME /usr/local/share/composer
ENV PATH $PATH:$COMPOSER_HOME/vendor/bin/

RUN echo "" \
  && apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 \
  && echo "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/hhvm.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    hhvm \
    wget \
    curl \
    git \
  \
  && curl --insecure -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && composer --version \
  && echo "PATH VARIABLE: "$PATH \
  \
  && apt-get clean -y \
  && rm -rf /usr/{{lib,share}/locale,share/{man,doc,info,gnome/help,cracklib,il8n},{lib,lib64}/gconv,bin/localedef,sbin/build-locale-archive} \
  && rm -rf /var/lib/apt/lists/*

COPY container-files /

EXPOSE 9000

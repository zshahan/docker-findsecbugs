FROM blacklabelops/java:server-jre.8

ENV VERSION 1.8.0

RUN set -x \
	\
	&& apk add --no-cache --virtual .fetch-deps \
		ca-certificates \
		unzip \
		openssl \
	&& wget -O find-sec-bugs.zip "https://github.com/find-sec-bugs/find-sec-bugs/releases/download/version-$VERSION/findsecbugs-cli-$VERSION.zip" \
  && unzip find-sec-bugs.zip -d /usr/local/bin \
  && rm find-sec-bugs.zip \
  && sed $'s/\r$//' /usr/local/bin/findsecbugs.sh \
  && chmod +x /usr/local/bin/findsecbugs.sh

USER 1001

CMD ["bash","-c","findsecbugs.sh", "help"]

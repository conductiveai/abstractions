FROM alpine:3.14

ADD apply.sh /abstractions/
ADD apply.py /abstractions/
ADD .env /abstractions/
ADD patch.patch /abstractions/
ADD prepare.sql /abstractions/
ADD scripts.csv /abstractions/

WORKDIR /abstractions

RUN apk add --update --no-cache git curl python3 bash uuidgen postgresql-client

CMD ["/abstractions/apply.sh"]

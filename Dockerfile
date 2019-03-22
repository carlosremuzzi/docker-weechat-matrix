FROM alpine:3.9

ARG COMMIT_ID=97a31b003b28ab8c2647e35d16266c48e569b4d2
ARG SHORT_COMMIT_ID=97a31b0

WORKDIR /home/nobody

COPY --chown=nobody:nobody .weechat .weechat

RUN apk add --no-cache \
        lua \
        lua-cjson \
        weechat \
        weechat-lua \
    && wget https://github.com/torhve/weechat-matrix-protocol-script/archive/${SHORT_COMMIT_ID}.tar.gz -O weechat-matrix.tar.gz \
    && tar -xzf weechat-matrix.tar.gz \
    && rm weechat-matrix.tar.gz \
    && cp weechat-matrix-protocol-script-${COMMIT_ID}/matrix.lua ./.weechat/lua \
    && rm -r weechat-matrix-protocol-script-${COMMIT_ID}/ \
    && ln -s /home/nobody/.weechat/lua/matrix.lua ./.weechat/lua/autoload/matrix.lua \
    && chown -R nobody:nobody /home/nobody

USER nobody

ENTRYPOINT ["weechat","-d","/home/nobody/.weechat"]

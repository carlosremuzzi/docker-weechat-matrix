FROM alpine:3.8

RUN apk add --no-cache lua lua-cjson weechat weechat-lua

WORKDIR /home/nobody

RUN chown -R nobody:nobody ./

USER nobody

COPY .weechat .

RUN mkdir -p ./.weechat/lua/autoload \
    && wget https://github.com/torhve/weechat-matrix-protocol-script/archive/ace3fef.tar.gz -O weechat-matrix.tar.gz \
    && tar -xzf weechat-matrix.tar.gz \
    && rm weechat-matrix.tar.gz \
    && cp weechat-matrix-protocol-script-ace3fefc0e35a627f8a528032df2e3111e41eb1b/matrix.lua ./.weechat/lua \
    && rm -r weechat-matrix-protocol-script-ace3fefc0e35a627f8a528032df2e3111e41eb1b/ \
    && ln -s /home/nobody/.weechat/lua/matrix.lua ./.weechat/lua/autoload/matrix.lua

ENTRYPOINT ["weechat","-d","/home/nobody/.weechat"]

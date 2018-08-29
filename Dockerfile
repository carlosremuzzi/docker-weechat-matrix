FROM alpine:3.8

RUN apk add --no-cache lua lua-cjson weechat weechat-lua curl

WORKDIR /home/nobody

RUN chown -R nobody:nobody /home/nobody

USER nobody

RUN mkdir -p ./.weechat/lua/autoload
RUN curl -fSL https://github.com/torhve/weechat-matrix-protocol-script/archive/ace3fef.tar.gz -o weechat-matrix.tar.gz
RUN tar -xzf weechat-matrix.tar.gz
RUN rm weechat-matrix.tar.gz
RUN cp weechat-matrix-protocol-script-ace3fefc0e35a627f8a528032df2e3111e41eb1b/matrix.lua ./.weechat/lua
RUN ln -s /home/nobody/.weechat/lua/matrix.lua ./.weechat/lua/autoload/matrix.lua

ENTRYPOINT ["weechat"]

CMD ["-d","/home/nobody/.weechat"]

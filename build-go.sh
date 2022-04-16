#!/bin/bash

# set -euo pipefail

find_protos() {
    echo $(cd "$1" && find . -type f -name "*.proto" -printf "%f\n" | sort)
}
    # protoc \
    #     -I"protocol/$_name" \  -I protocol目录源码地址
    #     -I/usr/local/include \
    #     -I. \
    #     -I/usr/local/include/grpc-ecosystem/grpc-gateway@v1.11.1/ \
    #     -I/usr/local/include/envoyproxy/protoc-gen-validate@0.1.0 \
    #    -I"$src_root/dependency/include" \  ### 很重要，一些基本的库，比如google的description
    #     --go_out=plugins=grpc,paths=source_relative:"$root" \
#         -i/usr/local/include/grpc-ecosystem/grpc-gateway@v1.11.1/ \ 编译gateway代码j
#         -i/usr/local/include/envoyproxy/protoc-gen-validate@0.1.0 \ 编译validate代码，没有使用validate可以不用
#         --go_out=plugins=grpc,paths=source_relative:"$root" \ 编译grpc代码，source_relative 是编译好的代码使用和protocol一样的目录结构
#         --grpc-gateway_out=logtostderr=true,paths=source_relative:"$root"  \
#         --validate_out=lang=go,paths=source_relative:"$root" \
#         --swagger_out=allow_merge=true,merge_file_name="doc/$_name",logtostderr=true:. \
            # {你指定的源码地址}/文件.proto

### 注意 "\" 换行中间不能有注释，不然会有notfound 什么的 一定要连续 \

src_root="apis/protocol"
dest_root="apis/golang"
doc_dest="apis/doc/$_name"
mkdir -p "$doc_dest"

do_build() {
    _name="$1"
    echo do_build $_name
    dest="$dest_root/$_name"
    mkdir -p "$dest"
    protoc \
        -I"$src_root/$_name" \
        -I"$dest_root" \
        -I"$dest_root/$_name" \
        -I. \
        -I"$src_root/dependency" \
        -I"$src_root/dependency/include" \
        --go_out="$dest" --go_opt=paths=source_relative \
        --go-grpc_out="$dest" --go-grpc_opt=paths=source_relative \
        --grpc-gateway_out=logtostderr=true,paths=source_relative:"$dest"  \
        --validate_out=lang=go,paths=source_relative:"$dest" \
        --openapiv2_out "$doc_dest" \
        --openapiv2_opt logtostderr=true \
        $(find_protos "$src_root/$1")
}

# protocol下，哪些需要编译的目录
do_build demo/v1
do_build items/v1

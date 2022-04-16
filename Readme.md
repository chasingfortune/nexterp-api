## 脚本使用须知
创建protocol目录
创建golang目录
安装好脚本中需要的插件：protoc，protocol-gen-go等
执行脚本


## 安装 go的一些插件
GOBIN必须有系统可以找到二进制的目录如 ：/usr/local/bin
go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
go install google.golang.org/protobuf/cmd/protoc-gen-go
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

go install github.com/envoyproxy/protoc-gen-validate
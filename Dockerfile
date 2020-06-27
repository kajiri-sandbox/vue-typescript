FROM node:lts-alpine

# 静的コンテンツを配信するシンプルな http サーバをインストールする
# RUN npm install -g  yarn

# カレントワーキングディレクトリとして 'app' フォルダを指定する
WORKDIR /app

# `package.json` と `package-lock.json` （あれば）を両方コピーする
COPY package*.json ./

# プロジェクトの依存ライブラリをインストールする
RUN yarn

# カレントワーキングディレクトリ(つまり 'app' フォルダ)にプロジェクトのファイルやフォルダをコピーする
COPY . .

# 本番向けに圧縮しながらアプリケーションをビルドする
# RUN yarn run build

EXPOSE 8080
CMD [ "yarn", "serve" ]
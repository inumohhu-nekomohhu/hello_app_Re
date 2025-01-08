#Docker Hubからruby:3.0.5のイメージをプルする
FROM ruby:3.2.6

#debian系のためapt-getを使用してnode.jsとyarnをインストール
RUN apt-get update -qq
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
&& apt-get install -y nodejs
RUN npm install --global yarn

#docker内の作業ディレクトリを作成＆設定
WORKDIR /docker_rails_test

#Gemfile,Gemfile.lockをローカルからCOPY
COPY Gemfile Gemfile.lock /docker_rails_test/

#コンテナ内にコピーしたGemfileを用いてbundel install
RUN bundle install

# 環境変数の設定 
ENV NODE_OPTIONS=--openssl-legacy-provider

#railsを起動する
CMD ["rails", "server", "-b", "0.0.0.0"]

# 出力先のログファイルの指定
set :output, 'log/crontab.log'
# ジョブの実行環境の指定
set :environment, :development


every :hour do
  rake 'trends:get_trends'
end
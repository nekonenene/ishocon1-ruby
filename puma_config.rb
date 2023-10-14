max_threads_count = ENV.fetch('RAILS_MAX_THREADS', 40)
min_threads_count = ENV.fetch('RAILS_MIN_THREADS', 1)
# 設定値としては5から16が目安らしいが、リソースとしてはCPU使用率70%が目安らしい。
threads min_threads_count, max_threads_count

workers 4

port 8080

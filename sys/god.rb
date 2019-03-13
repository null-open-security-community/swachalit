d_user      = "swachalit"
d_group     = "swachalit"
group_name  = "swachalit"
pids_path   = "/tmp"

components = [
   ["redis-server",     "cd /home/swachalit/redis-2.8.19 && ./src/redis-server"],
   ["resque-worker",    "cd /home/swachalit/apps/nullify/current && sh script/run_workers.sh"],
   ["resque-scheduler", "cd /home/swachalit/apps/nullify/current && sh script/run_scheduler.sh"],
   ["unicorn-server",   "cd /home/swachalit/apps/nullify/current && sh script/run_app.sh"]
]

components.each do |aa|
  God.watch do |w|
    w.group = group_name
    w.uid = d_user
    w.gid = d_group

    # Let god manage PID by its own
    #w.pid_file = File.join(pids_path, aa[0].to_s + ".pid")

    w.name = aa[0].to_s
    w.start = aa[1].to_s
    w.keepalive
  end
end



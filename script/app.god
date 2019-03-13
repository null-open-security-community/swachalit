root_dir = File.join(File.dirname(__FILE__), "..")

# Application Server
God.watch do |w|
  w.name = "swachalit_app_server"
  w.group = "swachalit"
  w.dir = root_dir
  w.start = File.join(root_dir, "script", "run_app.sh")
  w.keepalive
end

# Resque Workers
God.watch do |w|
  w.name = "swachalit_workers"
  w.group = "swachalit"
  w.dir = root_dir
  w.start = File.join(root_dir, "script", "run_workers.sh")
  w.keepalive
end



require './lib/snackHack2'

ssh = Snackhack2::SSHForwardRemote.new
ssh.site  = "187.171.198.132"
ssh.user  = "root"
ssh.pass  = "secretpassword"
ssh.key   = "/home/JakeFromStateFarm/.ssh/id_rsa"
ssh.lport = 2222
ssh.lsite = "localhost"
ssh.rport = 8022

ssh.run

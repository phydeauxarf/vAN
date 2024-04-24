import subprocess
# call attribute is for python2....use run attribute when using python3

# Creating L2TP tunnel
subprocess.call([
    'ip', 'l2tp', 'add', 'tunnel', 'tunnel_id', '1000', 'peer_tunnel_id', '2000',
    'encap', 'udp', 'local', '10.10.1.10', 'remote', '10.10.1.20',
    'udp_sport', '6000', 'udp_dport', '5000'
])

# Adding L2TP session
subprocess.call([
    'ip', 'l2tp', 'add', 'session', 'tunnel_id', '1000', 'session_id', '3000',
    'peer_session_id', '4000'
])

# Showing L2TP tunnel information
subprocess.call(['ip', 'l2tp', 'show', 'tunnel'])

# Creating bridge
subprocess.call(['brctl', 'addbr', 'br0'])
subprocess.call(['brctl', 'addif', 'br0', 'eth0'])
subprocess.call(['brctl', 'addif', 'br0', 'eth1'])
subprocess.call(['ip', 'link', 'set', 'dev', 'br0', 'up'])

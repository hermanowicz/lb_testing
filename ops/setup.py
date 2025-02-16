from pyinfra.operations import dnf, git, systemd, server, files

dnf.update(
    name='full os update',
    _sudo_user='root',
    _sudo=True,
)

dnf.packages(
    name='installing go, vim, git, fail2ban',
    packages=['golang', 'vim', 'git', 'fail2ban'],
    clean=True,
    _sudo_user='root',
    _sudo=True,
)

systemd.service(
    name='enabling and starting fail2ban',
    service='fail2ban',
    running=True,
    enabled=True,
    _sudo_user='root',
    _sudo=True,
)

server.shell(
    name='fail2ban client status',
    commands=["fail2ban-client status"],
    _sudo_user='root',
    _sudo=True,
)

files.put(
    name='service file for test app',
    src='files/test-app.service',
    dest='/lib/systemd/system/test-app.service',
    force=True,
    user='root',
    group='root',
    _sudo_user='root',
    _sudo=True,
)

files.file(
    name='creating log file for test app',
    path='/root/test_app/std.log',
    user='root',
    group='root',
    _sudo_user='root',
    _sudo=True,
)

systemd.service(
    name='enabling and starting test-app',
    service='test-app.service',
    running=False,
    enabled=False,
    _sudo_user='root',
    _sudo=True,
)

from pyinfra.operations import dnf, git

dnf.update(
    name='full os update',
    _sudo_user='root',
    _sudo=True,
)

dnf.packages(
    name='installing go, vim, git, fail2ban',
    packages=['golang', 'vim', 'git', 'fail2ban'],
    lates=True,
    clean=True,
    _sudo_user='root',
)

git.repo(
    name='pulling test_app repo',
    src='https://github.com/hermanowicz/test_app.git',
    dest='/root/test_app',
    branch='master',
    user='root',
    group='root',
    _sudo_user='root',
)


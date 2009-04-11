use inc::Module::Install;

name     'Chef';
all_from 'lib/Chef.pm';
author   'Adam Jacob <info@opscode.com>';
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;


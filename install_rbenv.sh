rbenv_root=~/.rbenv
git clone https://github.com/rbenv/rbenv.git "${rbenv_root}"
cd ~/.rbenv && src/configure && make -C src && cd -
mkdir -p "${rbenv_root}/plugins"
git clone https://github.com/rbenv/ruby-build.git "${rbenv_root}"/plugins/ruby-build
PATH="${rbenv_root}/bin":$PATH
export PATH
eval "$(rbenv init -)"
RUBY_VERSION=2.7.1
rbenv install "${RUBY_VERSION}"
rbenv global "${RUBY_VERSION}"


# NeoVim & Python 3 on lxplus (not shure if Standard_Ana. setup was run for Python3)

cd ~/analysis/rivet/MCRivetValidation
source ./scripts/setup_ATLASLocalRootBase.sh
source ./scripts/setup_rivet.sh

git clone https://github.com/neovim/neovim.git
cd neovim/
make -j8 CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX:PATH=$HOME/.local"
make install
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bash_local
export PATH="$HOME/.local/bin:$PATH"

wget https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tgz
tar xvzf Python-3.4.3.tgz
cd Python-3.4.3/
./configure --prefix=$HOME/.local
make
make install
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc_local
python3 -m pip install neovim
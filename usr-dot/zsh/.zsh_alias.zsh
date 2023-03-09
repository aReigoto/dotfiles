function mcd {
    mkdir -p $1 && cd $1
}

alias tlp='teleport.py && cd "$(cat ~/.local/state/teleport/portal)"'
alias LogicProX='/Applications/Logic\ Pro\ X.app/Contents/MacOS/Logic\ Pro\ X'
alias cnda="conda activate"
alias cndd="conda deactivate"
alias cndls="conda env list"
alias jplab="jupyter-lab"
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias ipy='ipython3'
# ========== Jupyter tools ==========

alias jpkl='jupyter kernelspec list'

function jpkInstallKernel() {
  if [ $# -eq 1 ]
  then
    python -m ipykernel install --user --name $1 --display-name "$1"
  else
    echo "Pass a name to register your kernel"
  fi
}

function jpqt() {
  if [ $# -eq 0 ]
  then
    jupyter qtconsole
  else
    jupyter qtconsole --kernel=$1
  fi
}

function jplab() {
  if [ $# -eq 0 ]
  then
    conda activate nvim
  else
    conda activate $1
  fi
  jupyter-lab
}

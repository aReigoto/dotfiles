new_env="/Volumes/Quatro.Tera/lerning/tf_build"
bazel_version="0.11.0"
tf_version="1.9"

mkdir -p $new_env
cd $new_env

wget "https://github.com/bazelbuild/bazel/releases/download/${bazel_version}/bazel-${bazel_version}-installer-darwin-x86_64.sh"
chmod u+x "bazel-${bazel_version}-installer-darwin-x86_64.sh"
bazel-${bazel_version}-installer-darwin-x86_64.sh --prefix=$HOME/.local/

pipenv --python 3.6
pipenv install numpy
venv_path=$(pipenv --venv)

git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout "r${tf_version}"

pipenv shell

export PATH="$PATH:$HOME/.local/bin"
bazel build -c opt --copt=-march=native --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-mfpmath=sse -k //tensorflow/tools/pip_package:build_pip_package

pip_package_path="${new_env}/tensorflow_pip_package_build"

mkdir -p "${pip_package_path}"

bazel-bin/tensorflow/tools/pip_package/build_pip_package "${pip_package_path}"

# pipenv install ${pip_package_path}/tensorflow-${tf_version}*.whl

# ${venv_path}/bin/pip install ${pip_package_path}/tensorflow-${tf_version}*.whl

#!/bin/bash

# Ensure pip is installed
if ! command -v pip &> /dev/null; then
    echo "pip is not installed. Installing now..."
    python3 -m ensurepip --default-pip
fi

echo "Upgrading pip, setuptools, and wheel..."
pip install --upgrade pip setuptools wheel

packages=(
    "aiohappyeyeballs" "aiohttp" "aiosignal" "alembic" "aniso8601" "anyio" "APScheduler" "asgiref"
    "astroid" "attrs" "autopep8" "banal" "beautifulsoup4" "black" "blinker" "bokeh" "cattrs"
    "certifi" "cffi" "chardet" "charset-normalizer" "click" "cloudpickle" "colorama"
    "configparser" "contourpy" "cycler" "Cython" "dash" "dash-core-components"
    "dash-html-components" "dash-table" "dask" "dataclasses" "DataProperty" "dataset"
    "dill" "Django" "dnspython" "docopt" "EasyProcess" "entrypoint2" "et_xmlfile" "falcon"
    "flake8" "Flask" "flask-cors" "Flask-JWT-Extended" "Flask-Login" "Flask-RESTful"
    "Flask-SQLAlchemy" "Flask-WTF" "fonttools" "frozenlist" "fsspec" "future" "fuzzywuzzy"
    "greenlet" "gunicorn" "h11" "halo" "html5lib" "httpcore" "httpx" "hug" "hypothesis"
    "idna" "imageio" "importlib_metadata" "iniconfig" "inpass" "iso8601" "isort"
    "itsdangerous" "Jinja2" "joblib" "keyboard" "kiwisolver" "locket" "log-symbols"
    "lxml" "Mako" "markdown-it-py" "MarkupSafe" "matplotlib" "mbstrdecoder" "mccabe"
    "mdurl" "mechanize" "modin" "MouseInfo" "multidict" "mypy" "mypy-extensions"
    "mysql-connector-python" "narwhals" "nest-asyncio" "netifaces" "nltk" "nose" "numpy"
    "openpyxl" "outcome" "packaging" "pandas" "partd" "passlib" "pathspec" "pathvalidate"
    "patool" "peewee" "pillow" "pip" "platformdirs" "plotext" "plotly" "pluggy"
    "polyglot" "pony" "progress" "prompt_toolkit" "propcache" "psutil" "PyAudio"
    "PyAutoGUI" "pycodestyle" "pycparser" "pycryptodome" "pycryptodomex" "pydub"
    "pyfiglet" "pyflakes" "PyGetWindow" "Pygments" "PyJWT" "pylint" "pymongo" "PyMsgBox"
    "pyparsing" "pyperclip" "PyRect" "PyScreeze" "pyserial" "PySocks" "pytablewriter"
    "pytesseract" "pytest" "python-dateutil" "python-dotenv" "python-fzf" "python-rapidjson"
    "python3-xlib" "pyttsx3" "pytweening" "pytz" "pyunpack" "pyusb" "PyYAML" "pyzbar"
    "pyzipper" "records" "redis" "regex" "requests" "requests-cache" "retrying" "rich"
    "rich-click" "schedule" "seaborn" "selenium" "serial" "setuptools" "shellingham"
    "simpleaudio" "simplemma" "six" "sniffio" "socketio" "sortedcontainers" "sounddevice"
    "soupsieve" "SpeechRecognition" "speedtest-cli" "spinners" "SQLAlchemy" "sqlparse"
    "tabledata" "tablib" "tabulate" "tcolorpy" "termcolor" "textblob" "tinydb" "toml"
    "tomlkit" "toolz" "torchtext" "turtle" "tornado" "tqdm" "trio" "trio-websocket" "tritonclient"
    "typepy" "typer" "typing_extensions" "tzdata" "tzlocal" "url-normalize" "urllib3"
    "uvicorn" "Wand" "watchdog" "wcwidth" "webencodings" "websocket-client" "websockets"
    "Werkzeug" "wheel" "wsproto" "WTForms" "xyzservices" "yapf" "yarl" "yt-dlp" "zipp"
)

rm -f skipped_packages.log

echo "Starting package installation..."

is_package_installed() {
    pip show "$1" &> /dev/null
}

for package in "${packages[@]}"; do
    clear
    echo "Checking installation $package"
    
    if is_package_installed "$package"; then
        echo "✅ Already installed $package. Skipping..."
        sleep 0.5
        clear
        continue
    fi

    echo "⬇️ Installing $package..."
    
    if pip install "$package"; then
        echo "✅ Successfully installed $package!"
        sleep 2
        continue
    fi

    echo "❌ Failed to install: $package. Trying fixes..."

    if pip install --no-cache-dir "$package"; then
        echo "✅ Fixed with --no-cache-dir $package!:"
        sleep 1
        continue
    fi

    if pip install --force-reinstall "$package"; then
        echo "✅ Fixed with --force-reinstall $package!"
        sleep 1
        continue
    fi

    if pip install -U "$package"; then
        echo "✅ Fixed with -U (upgrade) $package!"
        sleep 1
        continue
    fi

    if [[ "$OSTYPE" == "linux-android" ]]; then
        if pkg install "$package" -y; then
            echo "✅ Installed via pkg $package!"
            sleep 1
            continue
        fi
    elif [[ "$OSTYPE" == "linux-gnu" ]]; then
        if sudo apt install "$package" -y; then
            echo "✅ Installed via apt $package!"
            continue
        fi
    fi

    echo "❌ FINAL FAILURE: $package" | tee -a skipped_packages.log
done

clear
echo "✅ Installation completed!"

if [ -f skipped_packages.log ]; then
    echo "⚠️ Some packages failed to install. See skipped_packages.log."
    cat skipped_packages.log
else
    echo "🎉 All packages installed successfully!"
fi
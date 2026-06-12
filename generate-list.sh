#!/bin/sh
# 扫描所有 .html 文件，排除 index.html，生成 files.json
python3 -c "
import os, json
files = [f for f in os.listdir('.') if f.endswith('.html') and f != 'index.html']
with open('files.json', 'w') as fp:
    json.dump(files, fp)
"

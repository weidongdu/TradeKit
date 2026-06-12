#!/bin/sh
python3 -c "
import os, json, re
files = []
for f in sorted(os.listdir('.')):
    if not (f.endswith('.html') and f != 'index.html'):
        continue
    path = os.path.join('.', f)
    st = os.stat(path)
    title = f
    desc = ''
    try:
        with open(path, encoding='utf-8') as fp:
            content = fp.read(4096)
            m = re.search(r'<title[^>]*>(.*?)</title>', content, re.I | re.S)
            if m:
                title = m.group(1).strip()
            m = re.search(r'<meta\s+name=\"description\"\s+content=\"(.*?)\"', content, re.I)
            if m:
                desc = m.group(1).strip()
            if not desc:
                m = re.search(r'<meta\s+content=\"(.*?)\"\s+name=\"description\"', content, re.I)
                if m:
                    desc = m.group(1).strip()
    except Exception:
        pass
    files.append({
        'name': f,
        'title': title,
        'desc': desc,
        'size': st.st_size,
        'modified': int(st.st_mtime),
    })
with open('files.json', 'w') as fp:
    json.dump(files, fp, ensure_ascii=False)
"

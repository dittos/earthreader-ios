# Fake multiprocessing module
import sys, types
mod = types.ModuleType('multiprocessing')
mod.cpu_count = lambda: 1
sys.modules[mod.__name__] = mod

from waitress.server import create_server
from earthreader.web.app import app, spawn_worker

app._worker_running = False

def new_server(repo_path, session_id):
    app.config['REPOSITORY'] = 'file://' + repo_path
    app.config['SESSION_ID'] = session_id
    if not app._worker_running:
        spawn_worker()
        app._worker_running = True
    return create_server(app, port=0)
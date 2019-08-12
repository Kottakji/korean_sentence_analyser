from flask import Flask
from konlpy.tag import Okt
import json
okt = Okt()
app = Flask(__name__)

@app.route('/analyse/<text>')
def analyse(text):
    return json.dumps(okt.pos(text, norm=True, stem=True))

if __name__ == '__main__':
    app.run(debug=False,host='0.0.0.0')
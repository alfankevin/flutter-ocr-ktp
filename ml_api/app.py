from flask import Flask, request
from helper import utils
import cv2 as cv
import numpy as np
import pytesseract

app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        return 'Hello World! POST'
    return 'Hello World!'
